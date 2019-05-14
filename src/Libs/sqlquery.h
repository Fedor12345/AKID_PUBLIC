#ifndef SQLQUERY_H
#define SQLQUERY_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include <QMutex>
#include <QWaitCondition>


class SQLquery : public QObject
{
    Q_OBJECT
public:
    explicit SQLquery(QObject *parent = nullptr);

private:
    QString query;
    QStringList queries;
    int numberQuery = 0;
    QStringList queriesGroup; /// список SQL запросов (в случае групповых запросов)
    QString connectionName;
    bool isNewName = false;
    bool isGroup = false;
    int iQueryGroup = 0;  /// номер запроса в массиве queriesGroup на выполнение
    bool fl_setQuery; /// станавливается в true, если запрос был послан от интерфейса,
                      /// что бы блокировать обработку сигнала от менеджера при каждом новом подключении к бд
    QString sender_name = ""; /// ? - Дмитрий

private:
    void queryExecute(QString query); /// получает ссылку на текущеее(проверенное) подключение
                         /// и выполняет запрос с обработкой ошибок

    //QMutex mutex;
    //QWaitCondition waitThreads;


signals:
    void signalCheckConnectionDB();
    void signalSendResult(const QString& owner_name, const bool& res, const QVariant& var_res);

public slots:
    void setQuery(const QString &query);
    void setQuery(const QString &query, const bool &isGroup);
    void clearqueriesGroup();

    void checkNameConnection(QString); //, bool

    /// функции Дмитрия
    void getMaxID(const QString& owner_name, const QString &tname, const QString &fname, const QVariant &val);
    bool insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map);
};

#endif // SQLQUERY_H
