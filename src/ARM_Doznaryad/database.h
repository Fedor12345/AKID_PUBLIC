#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QtSql>
#include <QSqlDatabase>
#include <QThread>
#include <QDebug>


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

signals:
    void signalConnectionDB_BEGIN(QString);
    void signalConnectionDB_TRUE(QString);
    void signalConnectionDB_FALSE(QString);

public slots:
    void connectionDB(const QString &userName, const QString &password); //, QString
    void closeDB();
    void setDB(QString,QString,QString,QString); //(?)
};

#endif // DATABASE_H
