#include "managerconnectdb.h"

#include <QTimer> //удалить в финальной версии

#include "../Libs/sqlquerymodel.h"

ManagerConnectDB::ManagerConnectDB()
{
    qDebug() << "ManagerConnectDB:  start";

    /// задаются настройки подлючения к различным БД и заносятся в массивы
    //this->hostName       = new QString[NUMBER_OF_DB];
    this->databaseName   = new QString[NUMBER_OF_DB];
    this->userName       = new QString[NUMBER_OF_DB];
    this->password       = new QString[NUMBER_OF_DB];
    this->connectionName = new QString[NUMBER_OF_DB];


    this->databaseName[0] = DATABASE_NAME_0; //"ORCLPDB_net(1.5)"; //"ORCLPDB";
    this->databaseName[1] = DATABASE_NAME_1; //"ORCLPDB_net(1.197)"; //"ORCLPDB_net";

    this->userName[0] = USER_NAME_0; //"user_replication_1";
    this->userName[1] = USER_NAME_1; // "user_replication_1";

    this->password[0] = PASSWORD_0; // "alpha1";
    this->password[1] =  PASSWORD_1; // "alpha1";

    this->connectionName[0] = CONNECTION_NAME_0;
    this->connectionName[1] = CONNECTION_NAME_1;



    db0 = new Database(CONNECTION_NAME_0,HOST_NAME_0,DATABASE_NAME_0); /// в параметрах задается имя соединения
    db1 = new Database(CONNECTION_NAME_1,HOST_NAME_1,DATABASE_NAME_1);

    db0->moveToThread(&dbThread0);
    db1->moveToThread(&dbThread1);

    /// DB0:
    /// Менеджер сообщает потоку db0 о необходимости начать коннект с БД
    QObject::connect(this, &ManagerConnectDB::signalConnectionDB0,
                     db0,  &Database::connectionDB);

    QObject::connect(db0,  &Database::signalConnectionDB_TRUE,
                     this, &ManagerConnectDB::connectionDB_TRUE);

    QObject::connect(db0,  &Database::signalConnectionDB_FALSE,
                     this, &ManagerConnectDB::connectionDB_FALSE);

    QObject::connect(db0,  &Database::signalConnectionDB_BEGIN,
                     this, &ManagerConnectDB::connectionDB_BEGIN);

//    QObject::connect(this, &ManagerConnectDB::signalCloseDB0,
//                     db0,  &Database::closeDB);

    /// DB1:
    /// Менеджер сообщает потоку db1 о необходимости начать коннект с БД
    QObject::connect(this, &ManagerConnectDB::signalConnectionDB1,
                     db1,  &Database::connectionDB);

    /// db1 из своего потока сообщает менеджеру, что соединение с БД прошло удачно
    QObject::connect(db1,  &Database::signalConnectionDB_TRUE,
                     this, &ManagerConnectDB::connectionDB_TRUE);

    QObject::connect(db1,  &Database::signalConnectionDB_FALSE,
                     this, &ManagerConnectDB::connectionDB_FALSE);


    QObject::connect(db1,  &Database::signalConnectionDB_BEGIN,
                     this, &ManagerConnectDB::connectionDB_BEGIN);

//    QObject::connect(this, &ManagerConnectDB::signalCloseDB1,
//                     db1,  &Database::closeDB);


    dbThread0.start();
    dbThread1.start();



    //____________________________________________________
    waitDB = new WaitDB_thread(NUMBER_OF_DB);
    //waitDB->nDB = NUMBER_OF_DB;
    waitDB->moveToThread(&waitDBThread);


    /// Сигнал от менеджера к waitDB о запуске основной функции ожидания
    QObject::connect(this,   &ManagerConnectDB::signalWaitAllConnectionDB,
                     waitDB, &WaitDB_thread::waitConnetionDB);
    /// Сигнал от менеджера к waitDB о запуске функции ожидания проверки текущего соединения
    QObject::connect(this,   &ManagerConnectDB::signalWaitConnectionCurrentDB,
                     waitDB, &WaitDB_thread::waitConnectionCurrentDB);

    /// Сигнал от waitDB говорит менеджеру, что необходимо начать подключение с БД
    QObject::connect(waitDB, &WaitDB_thread::signalConnectionNextDB,
                     this,   &ManagerConnectDB::connectionDB);

    /// Сигнал от waitDB говорит менеджеру, что время ожидания всех подключений исчерпано и соединения не произошло
    QObject::connect(waitDB, &WaitDB_thread::signalWaitEnd,
                     this,   &ManagerConnectDB::connectionIsEmpty);

    /// Остановить таймер ожидания
    QObject::connect(this, &ManagerConnectDB::signalStopWaitTimer, waitDB, &WaitDB_thread::stopWaitTimer);



    /// сквозные сигналы от WaitDB к GUI(qml)
    QObject::connect(waitDB, &WaitDB_thread::signalBlockingGUI,
                     this,   &ManagerConnectDB::signalBlockingGUI);

    QObject::connect(waitDB, &WaitDB_thread::signalUnlockingGUI,
                     this,   &ManagerConnectDB::signalUnlockingGUI);




    /// запуск потоков
    waitDBThread.start();

}

ManagerConnectDB::~ManagerConnectDB()
{
    //delete [] this->hostName;    
    delete [] this->databaseName;
    delete [] this->userName;
    delete [] this->password;
    delete [] this->connectionName;

    waitDBThread.quit();
    waitDBThread.wait();

    dbThread0.quit();
    dbThread0.wait();

    dbThread1.quit();
    dbThread1.wait();

}

void ManagerConnectDB::checkConnectionDB(int iConnection)
{
    emit signalSendGUI_status("begin",nullptr,NULL);

    qDebug()<<" @ Manager: checkConnectionDB() | thread = " << QThread::currentThreadId();

    if (alreadyTrytoconnect == false) {
        alreadyTrytoconnect = true;

        if(!waitDB->fl_waitConnection) {
            waitDB->fl_connect = false;
        }

        emit signalWaitConnectionCurrentDB(iConnection);

    } else {
        qDebug()<<" @ Manager: - ALREADY CHECK CONNECTION";
    }


}

void ManagerConnectDB::checkAllConnectionDB()
{
    qDebug()<<" @ Manager: startConnectionDB() | thread = " << QThread::currentThreadId();

    emit signalSendGUI_status("begin",nullptr,NULL);
    waitDB->fl_connect = false;
    //emit signalCloseDB0();
    //emit signalCloseDB1();
    emit signalWaitAllConnectionDB();
}



void ManagerConnectDB::checkConnectionCurrentDB()
{
    qDebug()<<" @ Manager: connectionCurrentDB(): connName = " << this->currentConnectionName << " | thread = " << QThread::currentThreadId();

    emit signalSendGUI_status("begin",nullptr,NULL);
    // alreadyTrytoconnect = true и waitDB->fl_waitConnection - флаги указывают, что в данный момент уже идет проверка подключения,
    // и вызывающей функции незачем отправлять еще один запрос
    // достаточно только дождаться ответного сигнала
    //
    if (alreadyTrytoconnect == false) {
        alreadyTrytoconnect = true;

        if(!waitDB->fl_waitConnection) {
            waitDB->fl_connect = false;
        }

        //emit signalCloseDB0();
        //emit signalCloseDB1();

        int icurrentConnectionName = 0;

        for( int i = 0; i < NUMBER_OF_DB; i++ ) {
            if( this->currentConnectionName == this->connectionName[i] )
            {
                icurrentConnectionName = i;
            }
        }

        emit signalWaitConnectionCurrentDB(icurrentConnectionName);

    } else {
        qDebug()<<" @ Manager: - ALREADY CHECK CONNECTION";
    }

}


 /// сгенерирует сигнал для одного из db (в потоке):
 /// запустит подключение к указанной в параметрах БД
 /// iDB - номер ДБ
void ManagerConnectDB::connectionDB(int iDB)
{
    qDebug()<<" @ Manager: connectionDB: check " << iDB << " | thread = " << QThread::currentThreadId();

    //QString databaseName   = this->databaseName[iDB];
    QString userName       = this->userName[iDB];
    QString password       = this->password[iDB];
    //QString connectionName = this->connectionName[iDB];

    if ( iDB == 0 ) {
        qDebug() << " @ Manager: signalConnectionDB0 -> db thread0";
        emit signalConnectionDB0(userName,password); //,connectionName
    }
    if ( iDB == 1 ) {
        qDebug() << " @ Manager: signalConnectionDB1 -> db thread1";
        emit signalConnectionDB1(userName,password); //,connectionName
    }
}

/// задается имя текущего подключения через сигнал от потока с удачным покдлючением
void ManagerConnectDB::connectionDB_TRUE(QString connectionName)
{
    /// в случае успешного подключения к БД, меняем значения флага на true
    waitDB->fl_connect = true;
    emit signalStopWaitTimer(); //!!!

    if(connectionName == CONNECTION_NAME_0) {
        fl_connection_0 = true;  //временное решение
        waitDB->fl_connectionStates[0] = false;
        qDebug() << " @ Manager: (TRUE connect)  waitDB->fl_connectionStates[0] = " << waitDB->fl_connectionStates[0];
    }
    if(connectionName == CONNECTION_NAME_1) {
        fl_connection_1 = true;  //временное решение
        waitDB->fl_connectionStates[1] = false;
        qDebug() << " @ Manager: (TRUE connect)  waitDB->fl_connectionStates[1] = " << waitDB->fl_connectionStates[1];
    }

    /// проверка является ли установившееся новое подключение новым
    bool isNewName = false;
    if(this->currentConnectionName != connectionName)
        { isNewName = true; }
    else
        { isNewName = false; }
    this->currentConnectionName = connectionName;
    /// отправляем сигнал в SQLquery с именем текущего соединения и говорим новое оно или нет
    emit signalSendConnectionName(this->currentConnectionName); //, isNewName
    alreadyTrytoconnect = false;

    qDebug()<<" @ Manager: waitDB->fl_connect = "<<waitDB->fl_connect << "| currentConnectionName = " << this->currentConnectionName;
    QString message = "текущее соединение: " + this->currentConnectionName;
    emit signalSendGUI_status(message, this->currentConnectionName, true);

    // обновление моделей
    //updateModelDB();
    //emit signalupdataModelDB();
}

void ManagerConnectDB::connectionDB_FALSE(QString connectionName)
{
    //waitDB->stopTimer = true; ///(?) говорим таймеру останавиться

    if(connectionName == CONNECTION_NAME_0) {
        fl_connection_0 = false; //временное решение
        waitDB->fl_connectionStates[0] = false;
        qDebug() << " @ Manager: (FALSE connect)  waitDB->fl_connectionStates[0] = " << waitDB->fl_connectionStates[0];
    }
    if(connectionName == CONNECTION_NAME_1) {
        fl_connection_1 = false; //временное решение
        waitDB->fl_connectionStates[1] = false;
        qDebug() << " @ Manager: (FALSE connect)  waitDB->fl_connectionStates[1] = " << waitDB->fl_connectionStates[1];
    }
    QString message = "нет соединения c: " + connectionName;
    qDebug() << message;
    emit signalSendGUI_status(message, connectionName, false);
}


void ManagerConnectDB::connectionDB_BEGIN(QString connectionName)
{    
    if(connectionName == CONNECTION_NAME_0) {
        waitDB->fl_connectionStates[0] = true;
        qDebug() << " @ Manager: (BEGIN connect to" << connectionName << ")  waitDB->fl_connectionStates[0] = " << waitDB->fl_connectionStates[0];
    }
    if(connectionName == CONNECTION_NAME_1) {
        waitDB->fl_connectionStates[1] = true;
        qDebug() << " @ Manager: (BEGIN connect to" << connectionName << ")  waitDB->fl_connectionStates[1] = " << waitDB->fl_connectionStates[1];
    }
    QString message = "Попытка подключения к " + connectionName;
    qDebug() << " @ Manager: " << message;
    emit signalSendGUI_status(message, nullptr, NULL);
}

/// Вызывается сигналом из waitDB, когда время ожидания всех подключений завершилось
/// и соединения так и не произошло.
/// Меняет имя текущего соединения на "0"
void ManagerConnectDB::connectionIsEmpty() {
    qDebug() << " @ Manager: НЕТ ДОСТУПНОГО СОЕДИНЕНИЯ | имя соединения = 0";

    /// Если имя старого подключения не равно 0, isNewName = true
//    bool isNewName = false;
//    if(this->currentConnectionName != "0")
//        { isNewName = true; }
//    else
//        { isNewName = false; }

    this->currentConnectionName = "0";
    /// отправляем сигнал в SQLquery с именем текущего соединения и говорим новое оно или нет
    emit signalSendConnectionName(this->currentConnectionName); //, isNewName
    alreadyTrytoconnect = false;

    /// сиглнал с сообщениями для интерфейса
    emit signalSendGUI_status("Cоединения отсутствуют", this->currentConnectionName, true);
}


//////////////////////
/// методы от Дмитрия:

/// задается пароль и логин
void ManagerConnectDB::setLoginPwd(const QString &login_str, const QString &pwd_str) {
    qDebug() << "\n @ Manager: set login/password";
    this->userName[0] = login_str; //"user_replication_1";
    this->userName[1] = login_str; // "user_replication_1";
    this->password[0] = pwd_str; // "alpha1";
    this->password[1] = pwd_str; // "alpha1";
}

/// динамическое создание модели
QObject* ManagerConnectDB::createModel(const QString &str_query, const QString &nameModel) {
    SQLQueryModel *sqm = new SQLQueryModel(nameModel);
    connect(sqm, &SQLQueryModel::signalCheckConnectionDB, this, &ManagerConnectDB::checkConnectionCurrentDB);
    connect(this, &ManagerConnectDB::signalSendConnectionName, sqm, &SQLQueryModel::checkNameConnection);

    if (str_query.length() > 0)
        sqm->setQueryDB(str_query);

    return sqm;
}





