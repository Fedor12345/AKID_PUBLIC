#include "managerconnectdb.h"
#include "sqlquerymodel.h"

ManagerConnectDB::ManagerConnectDB() {
    qDebug() << "ManagerConnectDB:  start";

    /// задаются настройки подлючения к различным БД и заносятся в массивы
    //this->hostName       = new QString[NUMBER_OF_DB];
    this->databaseName   = new QString[NUMBER_OF_DB];
    this->userName       = new QString[NUMBER_OF_DB];
    this->password       = new QString[NUMBER_OF_DB];
    this->connectionName = new QString[NUMBER_OF_DB];

    this->databaseName[0] = DATABASE_NAME_0; //"ORCLPDB_net(1.5)"; //"ORCLPDB";
    this->databaseName[1] = DATABASE_NAME_1; //"ORCLPDB_net(1.197)"; //"ORCLPDB_net";

    this->connectionName[0] = CONNECTION_NAME_0;
    this->connectionName[1] = CONNECTION_NAME_1;

    db0 = new Database(CONNECTION_NAME_0,HOST_NAME_0,DATABASE_NAME_0); /// в параметрах задается имя соединения
    db1 = new Database(CONNECTION_NAME_1,HOST_NAME_1,DATABASE_NAME_1);

    db0->moveToThread(&dbThread0);
    db1->moveToThread(&dbThread1);

    /// DB0: Менеджер сообщает потоку db0 о необходимости начать коннект с БД
    QObject::connect(this, &ManagerConnectDB::signalConnectionDB0, db0,  &Database::connectionDB);
    /// db0 из своего потока сообщает менеджеру, что соединение с БД прошло удачно
    QObject::connect(db0, &Database::signalConnectionDB_TRUE, this, &ManagerConnectDB::connectionDB_TRUE);
    QObject::connect(db0, &Database::signalConnectionDB_FALSE, this, &ManagerConnectDB::connectionDB_FALSE);
    QObject::connect(db0, &Database::signalConnectionDB_BEGIN, this, &ManagerConnectDB::connectionDB_BEGIN);
//    QObject::connect(this, &ManagerConnectDB::signalCloseDB0, db0,  &Database::closeDB);

    /// DB1: Менеджер сообщает потоку db1 о необходимости начать коннект с БД
    QObject::connect(this, &ManagerConnectDB::signalConnectionDB1, db1, &Database::connectionDB);
    /// db1 из своего потока сообщает менеджеру, что соединение с БД прошло удачно
    QObject::connect(db1, &Database::signalConnectionDB_TRUE, this, &ManagerConnectDB::connectionDB_TRUE);
    QObject::connect(db1, &Database::signalConnectionDB_FALSE, this, &ManagerConnectDB::connectionDB_FALSE);
    QObject::connect(db1, &Database::signalConnectionDB_BEGIN, this, &ManagerConnectDB::connectionDB_BEGIN);
//    QObject::connect(this, &ManagerConnectDB::signalCloseDB1, db1,  &Database::closeDB);

    dbThread0.start();
    dbThread1.start();

    //____________________________________________________
    waitDB = new WaitDB_thread(NUMBER_OF_DB);
    //waitDB->nDB = NUMBER_OF_DB;
    waitDB->moveToThread(&waitDBThread);

    // Сигнал от менеджера к waitDB о запуске основной функции ожидания
    QObject::connect(this, &ManagerConnectDB::signalWaitAllConnectionDB, waitDB, &WaitDB_thread::waitConnetionDB);
    // Сигнал от менеджера к waitDB о запуске функции ожидания проверки текущего соединения
    QObject::connect(this, &ManagerConnectDB::signalWaitConnectionCurrentDB, waitDB, &WaitDB_thread::waitConnectionCurrentDB);
    // Сигнал от waitDB говорит менеджеру, что необходимо начать подключение с БД
    QObject::connect(waitDB, &WaitDB_thread::signalConnectionNextDB, this, &ManagerConnectDB::connectionDB);
    // Сигнал от waitDB говорит менеджеру, что время ожидания всех подключений исчерпано и соединения не произошло
    QObject::connect(waitDB, &WaitDB_thread::signalWaitEnd, this, &ManagerConnectDB::connectionIsEmpty);

    // сквозные сигналы от WaitDB к GUI(qml)
    QObject::connect(waitDB, &WaitDB_thread::signalBlockingGUI, this, &ManagerConnectDB::signalBlockingGUI);
    QObject::connect(waitDB, &WaitDB_thread::signalUnlockingGUI, this, &ManagerConnectDB::signalUnlockingGUI);

    //сигнал говорит WaitDB остановить таймер ожидания подключения
    connect(this, &ManagerConnectDB::signalStopWaitTimer, waitDB, &WaitDB_thread::stopWaitTimer);

    /// запуск потоков
    waitDBThread.start();
}

ManagerConnectDB::~ManagerConnectDB() {
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

void ManagerConnectDB::checkAllConnectionDB() {
    //qDebug()<<"ManagerConnectDB: startConnectionDB | thread = " << QThread::currentThreadId();

    waitDB->fl_connect = false;
    emit signalWaitAllConnectionDB();
}



void ManagerConnectDB::checkConnectionCurrentDB() {
    // alreadyTrytoconnect = true - флаг указывает, что в данный момент уже идет проверка подключения,
    // и вызывающей функции незачем отправлять еще один запрос
    // достаточно только дождаться ответного сигнала
    if (alreadyTrytoconnect == false) {
        alreadyTrytoconnect = true;

        if(!waitDB->fl_waitConnection) {
            waitDB->fl_connect = false;
        }

        int icurrentConnectionName = 0;

        for( int i = 0; i < NUMBER_OF_DB; i++ ) {
            if( this->currentConnectionName == this->connectionName[i] ) {
                icurrentConnectionName = i;
            }
        }

//        qDebug()<<"ManagerConnectDB.checkConnectionCurrentDB()";
//        qDebug()<<"    current connection name: " << this->currentConnectionName << " [" <<icurrentConnectionName << "]";
//        qDebug()<<"    waitDB.fl_waitConnection: " << waitDB->fl_waitConnection;
        emit signalWaitConnectionCurrentDB(icurrentConnectionName);

    } else {
//        qDebug()<<" - ALREADY CHECK CONNECTION";
    }
}


 /// сгенерирует сигнал для одного из db (в потоке):
 /// запустит подключение к указанной в параметрах БД
 /// iDB - номер ДБ
void ManagerConnectDB::connectionDB(int iDB) {
//    qDebug()<<"ManagerConnectDB.connectionDB: " << iDB << " | thread = " << QThread::currentThreadId();

    QString userName       = this->userName[iDB];
    QString password       = this->password[iDB];
    //QString connectionName = this->connectionName[iDB];
    //QString databaseName   = this->databaseName[iDB];

    if ( iDB == 0 ) {
//        qDebug() << "(manager)signalConnectionDB0 -> db thread0";
        emit signalConnectionDB0(userName,password); //,connectionName
    } else if ( iDB == 1 ) {
//        qDebug() << "(manager)signalConnectionDB1 -> db thread1";
        emit signalConnectionDB1(userName,password); //,connectionName
    }
}

/// задается имя текущего подключения через сигнал от потока с удачным покдлючением
void ManagerConnectDB::connectionDB_TRUE(QString connectionName) {
    /// в случае успешного подключения к БД, меняем значения флага на true
    waitDB->fl_connect = true;
    emit signalStopWaitTimer(); //!!!

//    qDebug() << "SET fl_connect = true (connectionDB_TRUE)";

    if(connectionName == CONNECTION_NAME_0) {
        fl_connection_0 = true;  //временное решение
        waitDB->fl_connectionStates[0] = false;
//        qDebug() << "!!!!!!!!!!!!! (TRUE)  waitDB->fl_connectionStates[0] = " << waitDB->fl_connectionStates[0];
    } else if(connectionName == CONNECTION_NAME_1) {
        fl_connection_1 = true;  //временное решение
        waitDB->fl_connectionStates[1] = false;
//        qDebug() << "!!!!!!!!!!!!! (TRUE)  waitDB->fl_connectionStates[1] = " << waitDB->fl_connectionStates[1];
    }

    this->currentConnectionName = connectionName;

    /// отправляем сигнал в SQLquery с именем текущего соединения и говорим новое оно или нет
    emit signalSendConnectionName(this->currentConnectionName); //, isNewName
    alreadyTrytoconnect = false;

//    qDebug()<<"ManagerConnection: waitDB->fl_connect = "<<waitDB->fl_connect << "| currentConnectionName = " << this->currentConnectionName;
    QString message = "текущее соединение: " + this->currentConnectionName;
    emit signalSendGUI_status(message, this->currentConnectionName, true);
}

void ManagerConnectDB::connectionDB_FALSE(QString connectionName) {
    //waitDB->stopTimer = true; ///(?) говорим таймеру останавиться

    if(connectionName == CONNECTION_NAME_0) {
        fl_connection_0 = false; //временное решение
        waitDB->fl_connectionStates[0] = false;
//        qDebug() << "!!!!!!!!!!!!! (FALSE)  waitDB->fl_connectionStates[0] = " << waitDB->fl_connectionStates[0];
    }
    if(connectionName == CONNECTION_NAME_1) {
        fl_connection_1 = false; //временное решение
        waitDB->fl_connectionStates[1] = false;
//        qDebug() << "!!!!!!!!!!!!! (FALSE)  waitDB->fl_connectionStates[1] = " << waitDB->fl_connectionStates[1];
    }
    QString message = "нет соединения c: " + connectionName;
//    qDebug() << message;
    emit signalSendGUI_status(message, connectionName, false);
}


void ManagerConnectDB::connectionDB_BEGIN(QString connectionName) {
    if(connectionName == CONNECTION_NAME_0) {
        waitDB->fl_connectionStates[0] = true;
//        qDebug() << "!!!!!!!!!!!!! (BEGIN)  waitDB->fl_connectionStates[0] = " << waitDB->fl_connectionStates[0];
    }
    if(connectionName == CONNECTION_NAME_1) {
        waitDB->fl_connectionStates[1] = true;
//        qDebug() << "!!!!!!!!!!!!! (BEGIN)  waitDB->fl_connectionStates[1] = " << waitDB->fl_connectionStates[1];
    }
}

/// Вызывается сигналом из waitDB, когда время ожидания всех подключений завершилось
/// и соединения так и не произошло.
/// Меняет имя текущего соединения на "0"
void ManagerConnectDB::connectionIsEmpty() {
//    qDebug() << "НЕТ ДОСТУПНОГО СОЕДИНЕНИЯ | имя соединения = 0";

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
//    qDebug() << "ManagerConnectDB:  set login/password";
    this->userName[0] = login_str; // "user_replication_1";
    this->userName[1] = login_str; // "user_replication_1";
    this->password[0] = pwd_str;   // "alpha1";
    this->password[1] = pwd_str;   // "alpha1";
}

/// динамическое создание модели
QObject* ManagerConnectDB::createModel(const QString &str_query, const QString &nameModel) {
    SqlQueryModel *sqm = new SqlQueryModel(nameModel);
    connect(sqm, &SqlQueryModel::signalCheckConnectionDB, this, &ManagerConnectDB::checkConnectionCurrentDB);
    connect(this, &ManagerConnectDB::signalSendConnectionName, sqm, &SqlQueryModel::checkNameConnection);

    if (str_query.length() > 0)
        sqm->setQueryDB(str_query);

    return sqm;
}



///ненужные методы///
///////////////////////////////////////////////////////////////////////////
