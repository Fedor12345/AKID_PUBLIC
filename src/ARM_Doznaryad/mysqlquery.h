#ifndef SQLQUERY_H
#define SQLQUERY_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include <QSharedPointer>
#include <QEventLoop>

class SQLquery : public QObject {
    Q_OBJECT
public:
    explicit SQLquery(QString nameModel, QObject *parent = nullptr);

    //flg_async - false, ждем пока выполнится запрос
    Q_INVOKABLE QMap<QString, QVariant> find_record(const QString& owner_name,const QString &sql_query, const bool& flg_async = false);
    Q_INVOKABLE QVariantList find_records(const QString &sql_query);
    Q_INVOKABLE bool insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map, const bool& flg_async = false);
    Q_INVOKABLE int getMaxID(const QString& owner_name, const QString &tname, const QString &fname, const QVariant &val, const bool& flg_async = false);
    Q_INVOKABLE bool updateRecord(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map, const bool& flg_async = false);
    Q_INVOKABLE bool deleteRecord(const QString& owner_name,
                                  const QString &tname,
                                  const QMap<QString, QVariant> &map,
                                  const bool& flg_async = false);

    Q_INVOKABLE bool setpoint();
    Q_INVOKABLE bool rollback();
    Q_INVOKABLE bool commit();

//    #define AutoDisconnect(l) QSharedPointer <QMetaObject::Connection> l = QSharedPointer <QMetaObject::Connection> (\
//        new QMetaObject::Connection(), [](QMetaObject::Connection *conn){QObject::disconnect(*conn);}); *l
////use AutoDisconnect(conn1) = connect(....)

private:
    QString querySQL;
    QString connectionName;
    bool fl_setQuery; /// устанавливается в true, если запрос был послан от интерфейса,
                      /// что бы блокировать обработку сигнала от менеджера при каждом новом подключении к бд

    QString sender_name = "";               //имя отправителя запроса
    bool result_state = false;              //TRUE - запрос прошел без ошибок
    QMap<QString, QVariant> result_data;    //набор данных
    QString nameModel = "";
    QVariantList z_data;

    QEventLoop evloop;
private:
    void queryExecute();
    void setQuery(const QString& query);

signals:
    void signalCheckConnectionDB();

    //owner_name - кто вызвал запрос,
    //res - true без ошибок
    //var_res - результат запроса, если есть
    void signalSendResult(const QString& owner_name, const bool& res, const QMap<QString, QVariant>& var_res);
    //void signalGetReady();

public slots:
    void checkNameConnection(QString);

};

#endif // SQLQUERY_H
