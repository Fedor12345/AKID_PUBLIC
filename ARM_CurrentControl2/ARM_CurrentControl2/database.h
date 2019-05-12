#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>


#include <QtSql>
#include <QSqlDatabase>

#include <QThread>
#include <QDebug>


//#include <modeldb_thread.h>



class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QString connectionName, QString hostName, QString databaseName, QObject *parent = nullptr); //
    ~Database();


private:
    QSqlDatabase db;
    QString connectionName;
    QString hostName;
    QString databaseName;
    QString userName;
    QString password;

    //bool fl_connectionStop = false;


signals:
    void signalConnectionDB_BEGIN(QString);
    void signalConnectionDB_TRUE(QString);
    void signalConnectionDB_FALSE(QString);



    //void signalMoveToMainThread(QSqlDatabase);
    //void signslIsConnected(bool);



public slots:
    void connectionDB(const QString &userName, const QString &password); //, QString
    void closeDB();
    void setDB(QString,QString,QString,QString); //(?)
    void setQueryDB();
    void setQueryModelDB();


};

#endif // DATABASE_H
