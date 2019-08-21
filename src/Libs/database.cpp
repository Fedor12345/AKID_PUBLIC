#include "../Libs/database.h"


Database::Database(QString connectionName, QString hostName, QString databaseName, QObject *parent) : QObject(parent) //
{    
    qDebug() << "Database:          start";
    this->connectionName = connectionName;
    this->hostName       = hostName;
    this->databaseName   = databaseName;

    db = QSqlDatabase::addDatabase("QOCI",connectionName);  //"QODBC"
    //db = QSqlDatabase::addDatabase("QODBC",connectionName);
    //db.setHostName(this->hostName);
    db.setDatabaseName(this->databaseName);
}


Database::~Database()
{
    //db.close();
    //QSqlDatabase::removeDatabase(this->connectionName); //QSqlDatabase::defaultConnection
    //db.removeDatabase(this->connectionName);
    qDebug()<< "(!!!) Удаление объекта БД";
}

void Database::setDB(QString hostName, QString databaseName, QString userName, QString password)
{
    this->hostName      = hostName;
    this->databaseName  = databaseName;
    this->userName      = userName;
    this->password      = password;
}



void Database::connectionDB(const QString &userName, const QString &password) //QString hostName, QString databaseName, QString userName, QString password //, QString nameConnection
{
    qDebug() << "\n -> Database: connectionDB: ("<<this->databaseName << ") |  thread =" << QThread::currentThreadId() << "\n";

    this->userName = userName;
    /// если подключаемся ко второй машине, то редактируем в имени подключения _1 на _2
    /// (!) убрать это если имена пользователей БД на обеих машинах одинаковые
    if(this->connectionName == "machine 1") {
        if ( this->userName.endsWith("_1") ) {
            this->userName = this->userName.remove( this->userName.length()-2, 2 );
        }
         this->userName =  this->userName + "_2";
    }

    this->password = password;
    db.setUserName(this->userName);
    db.setPassword(this->password);
    ///////////////////////////////////////////////////////////////////////////
    //db.setDatabaseName("DRIVER={SQL Server};SERVER=HOME-PC;DATABASE=ARM;");
    ///////////////////////////////////////////////////////////////////////////

    qDebug() << " -> Database:  connectionName = " << this->connectionName;
    qDebug() << " -> Database:  hostName       = " << this->hostName;
    qDebug() << " -> Database:  databaseName   = " << this->databaseName;
    qDebug() << " -> Database:  userName       = " << this->userName;
    qDebug() << " -> Database:  hostName       = " << this->password;

    /// сообщение менеджеру о начале соединения
    emit signalConnectionDB_BEGIN(this->connectionName);

    if (!db.open())
    {
        emit signalConnectionDB_FALSE(this->connectionName);

        qDebug() << "_________________________>";        
        qDebug() << " -> Database: " << this->databaseName;
        qDebug() << " -> Database:Error DB: "       << db.lastError().text();
        qDebug() << " -> Database:ConnectionError:" << db.lastError().ConnectionError;
        //qDebug() << " -> Database: driverText"       << db.lastError().driverText();
        //qDebug() << QSqlDatabase::drivers();
        qDebug() << "_________________________<";
    }
    else
    {
        emit signalConnectionDB_TRUE(this->connectionName);
        //qDebug() << " -> Database: ConnectionError:"<<db.lastError().text(); //ConnectionError
        qDebug() << "\n -> Database: DB connect! <-----("<<this->databaseName << "| thread =" << QThread::currentThreadId() << " ) \n";
    }
}



/// ?
void Database::closeDB()
{
    if(db.isOpen()){
        db.close();
        qDebug()<<" -> Database: Закрывается БД: " << db.connectionName() << db.isOpen();
        //QSqlDatabase::removeDatabase(this->connectionName);
    }
}



////////////////////////////////////////////////////////////////////////
/// тесты с SQL запросами и моделями (можно удалить)
void Database::setQueryDB()
{
    qDebug() << "setQueryDB: thread = " << QThread::currentThreadId();
    QSqlQuery *query = new QSqlQuery(db);
    query->exec("SELECT TABLE1.NUMBER_ FROM TABLE1 WHERE ID=19");
    //("SELECT TABLE1.NUMBER_ FROM TABLE1 WHERE ID=19 ");
    if(!query->exec())
    {
        qDebug() << query->lastError().text();
        //emit signalQuery_test(query->lastError().text());
        delete query;
    }
    {
        query->next();
        qDebug() << query->value(0).toString(); //qDebug() << query->record();
        //emit signalQuery_test(query->value(0).toString());
        delete query;
    }
}

void Database::setQueryModelDB()
{
    qDebug() << "setQueryModelDB: | thread = " << QThread::currentThreadId();

    QString query = " SELECT TABLE1.NUMBER_ FROM TABLE1 ";

//    ModelDB_thread *modelDB = new ModelDB_thread(); //db
//    modelDB->setQuery(query, db);
//    //qDebug()<<"ModelDB_thread : roleNames : "<<modelDB->roleNames().values().value(0);
//    modelDB->printInfo();

    QSqlQueryModel *modelDB = new QSqlQueryModel();
    modelDB->setQuery(query, db);
    for (int i; i<19; i++) {
        qDebug()<<"modelDB : record: "<<modelDB->record(i).value(0).toString()<<"|"; //.value(1).toString()
    }
    delete modelDB;

}
////////////////////////////////////////////////////////////////////////
