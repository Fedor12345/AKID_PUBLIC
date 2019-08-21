#ifndef SQLQUERY_H
#define SQLQUERY_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include <QMutex>
#include <QWaitCondition>

#include <QByteArray>


class SQLquery : public QObject
{
    Q_OBJECT
public:
    explicit SQLquery(QObject *parent = nullptr);

private:
    QString query;
    QStringList queries; /// список SQL запросов, поступивших во время ожидания ответа от системы подключения к БД

    QVector<QByteArray> byteValues_tmp;
    QVector<QVector<QByteArray>> byteValues; /// двумерный массив для хранения данных не являющихся строко или числом (например побитовое представление файлов с фото)

   // QStringList types;  /// типы запросов, если "usual", то реузльтат - обычные текстовые данные, помимо них могут быть файлы .jpg, .bmp, .txt, .docm, .docx
   // QString type;       /// тип берется из параметров функций c SQL запросами,и далее записывается в types при каждом вызове setQuery и там же обнуляется
                        ///
    int numberQuery = -1;
    int iQuery = 0;
    QStringList queriesGroup; /// список SQL запросов (в случае групповых запросов)
    QString connectionName;
    bool isNewName = false;
    bool isGroup = false;
    int iQueryGroup = 0;  /// номер запроса в массиве queriesGroup на выполнение
    bool fl_setQuery; /// станавливается в true, если запрос был послан от интерфейса,
                      /// что бы блокировать обработку сигнала от менеджера при каждом новом подключении к бд
    QString sender_name = ""; /// имя отправителя запроса (необходимо для идентификации, когда QML принимает сигнал от запроса с результатом
    QStringList sender_names; /// список имен отправителей

private:
    void queryExecute(QString query); /// получает ссылку на текущеее(проверенное) подключение
                         /// и выполняет запрос с обработкой ошибок

    QMap<QString, QVariant> result_data; ///набор данных
    //QMutex mutex;
    //QWaitCondition waitThreads;


signals:
    void signalCheckConnectionDB();
    void signalSendResult(const QString& owner_name, const bool& res, const QVariant& var_res, const QString& messageError);
    //void signalSendResult(const QString& owner_name, const bool& res, const QMap<QString, QVariant>& var_res, const QString& messageError);
    void signalSendImageToProvider(const QByteArray &outByteArray, const QString &nameImage);



public slots:
    void setQuery(const QString &query);
    void setQuery(const QString &query, const bool &isGroup);
    void setQueryAndName(const QString &query, const QString &owner_name);
    //void setQueryWithName(const QString& owner_name,const QString &query); /// задает SQL запрос и имя запроса
    void clearqueriesGroup();

    void checkNameConnection(QString); //, bool
    /// метод не реализован
    void checkAddRecord(const QString& owner_name,const QString &query); ///проверка существования записи в БД

    /// функции Дмитрия
    void getMaxID(const QString& owner_name, const QString &tname, const QString &fname, const QVariant &val);
    /// owner_name - имя для запроса; tname - имя таблицы; map - данные, у которых индексы - названия полей;
    bool insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map);
    /// idWhere - по какому полю отбираем; id - чему это поле равно
    bool updateRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map, const QString &idWhere, const int &id);


    //void insertImageIntoTable(const QString& owner_name, const QString &tname, const QString &Vname, const QString addressImg);
};

#endif // SQLQUERY_H
