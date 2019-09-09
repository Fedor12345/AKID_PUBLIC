#ifndef MANAGERCONNECTDB_H
#define MANAGERCONNECTDB_H

#include <QObject>
#include <QThread>

#include <../Libs/waitdb_thread.h>
#include <../Libs/database.h>
//#include <object_thread.h>
//#include <modeldb_thread.h>


/// ноутбуки:
/// "ARM_AKID_1"
/// "ARM_AKID_2"

#define DATABASE_NAME_0 "ORCLPDB_net(0)" // "ARM_AKID_1" //"ORCLPDB_net(1)" //"ORCLPDB_net(1.5)"
#define DATABASE_NAME_1 "ORCLPDB_net(1)" // "ARM_AKID_2"//"ORCLPDB_net(2)" //"ORCLPDB_net(1.197)"

#define HOST_NAME_0 ""
#define HOST_NAME_1 ""

#define USER_NAME_0  "ARM_AKID_TEST_1"
#define USER_NAME_1  "ARM_AKID_TEST_2"

#define PASSWORD_0  "alpha1"
#define PASSWORD_1  "alpha1"

#define CONNECTION_NAME_0 "machine 0" //"name0"
#define CONNECTION_NAME_1 "machine 1" //"name1"

#define NUMBER_OF_DB 2 // количество бд

class ManagerConnectDB: public QObject
{
    Q_OBJECT

    // потоки ------------
    QThread waitDBThread;
    QThread dbThread0;
    QThread dbThread1;
    //QThread testThread;
    //--------------------

public:
    ManagerConnectDB();
    ~ManagerConnectDB();

    // подключение к БД (тест)
    QSqlDatabase db_threadMain;

    // модели
    //ModelDB_thread *modelDB;   /// модель БД

    bool fl_connection_0 = false;
    bool fl_connection_1 = false;

//    bool fl_connectionState_0 = false;
//    bool fl_connectionState_1 = false;

private:

    // объекты для работы в отдельных потоках
    Database *db0 = nullptr;
    Database *db1 = nullptr;
    WaitDB_thread  *waitDB;     /// объект, который ожидает соединения с БД

    QString currentConnectionName = "";

    // настройки подлючений
    int iDB = -1;  /// номер текущей бд, к которой выполняется/выполненно подключение
    //QString *hostName;
    QString *databaseName;
    QString *userName;
    QString *password;
    QString *connectionName;
    bool db_thread_create = false; /// если объект для БД был создан то true, если удален false

    bool alreadyTrytoconnect = false;


signals:
    void signalWaitAllConnectionDB(); /// сигнал для waitDB_thread, запускает основной метод
    void signalWaitConnectionCurrentDB(int);
    void signalConnectionDB0(QString,QString); /// сигнал для DataBase_thread, запускает подключение к бд с данными параметрами подключения
    void signalConnectionDB1(QString,QString); /// сигнал для DataBase_thread, запускает подключение к бд с данными параметрами подключения

    /// сквозные сигналы
    void signalBlockingGUI();
    void signalUnlockingGUI();
    void signalSendConnectionName(QString connectionName); //, bool isNewName

    /// сигнал передачи информации в GUI о состоянии подключений
    void signalSendGUI_status(QString message, QString currentConnectionName, bool status);

    //void signalCloseDB0();
    //void signalCloseDB1();

    void signalSetQueryDB();

    void signalStopWaitTimer(); //сигнал,чтобы остановить waitTimer в потоке WaitDB


public slots:
    void checkConnectionDB(int iConnection); /// сгенерирует сигнал для waitDB: запустит подключение к БД с номером, казанным в параметрах
    void checkAllConnectionDB();      /// сгенерирует сигнал для waitDB: запустит подключение ко всем имеющимся БД
    void checkConnectionCurrentDB();  /// сгенерирует сигнал для WaitDB: запустит подклчюение к текущей БД
    void connectionDB(int);           /// сгенерирует сигнал для db(в потоках): запустит подключение к указанной в параметрах БД

    void connectionDB_TRUE(QString);  /// принимает имя успешного подключения и меняет флаги
    void connectionDB_FALSE(QString); /// принимает имя НЕуспешного подключения и меняет флаги
    void connectionDB_BEGIN(QString);  /// когда попытка соединения начинается, то меняется флаг состояния соединения на true

    void connectionIsEmpty(); /// вызывается сигналом из waitDB, когда время ожидания всех подключений завершилось и соединения не произошло

//    void setQueryDB();
//    void setQueryModelDb();

    /// обновление от Двитрия
    void setLoginPwd(const QString&, const QString&);   //Установить Login/Password
    QObject* createModel(const QString &str_query, const QString &nameModel);


//    //модели
//    void createModelDB(); //(?)
//    void updateModelDB();

    //void connectionDB_test();
    //void qtimer_test(QString a);

};

#endif // MANAGERCONNECTDB_H
