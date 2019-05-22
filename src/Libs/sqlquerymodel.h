#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H

#include <QObject>
#include <QSqlQueryModel>
#include <QSqlQuery>
#include <QSqlRecord>

#include <QSqlError>
#include <QDebug>

#include <QMutex>
#include <QWaitCondition>


class SQLQueryModel : public QSqlQueryModel {
    Q_OBJECT
    Q_PROPERTY(QString query READ queryStr WRITE setQueryDB NOTIFY signalUpdateDone)
    //Q_PROPERTY(QStringList userRoleNames READ userRoleNames CONSTANT)
public:
    explicit SQLQueryModel(QString nameModel,QObject *parent = nullptr);
    ~ SQLQueryModel();

    QString nameModel;
    int i_ID = Qt::UserRole + 1;
   //QHash<int, QByteArray> roles;

   QStringList dataQueryList;   ///список запросов к SQL
   QString ID;                  /// id в таблице
                                /// (переделать в массив для случая, когда в запросе присутсвует нескольких таблиц)
   QString table;

   /// Переопределяем метод, который будет возвращать данные
   QVariant data(const QModelIndex & index, int role /*= Qt::DisplayRole*/) const;
   Q_INVOKABLE QVariantMap get(int row);

   void setQueryDB(const QString& query); //запрос к БД

   Q_INVOKABLE void updateModel( const QString& str_query = "");
   //Q_INVOKABLE void updateModel(QString);
   int getId(int row);
   QString getFirstColumn(int row);
   void printInfo();

   QString queryStr() const;

protected:
    /** хешированная таблица ролей для колонок.
    * Метод используется в дебрях базового класса QAbstractItemModel,
    * от которого наследован класс QSqlQueryModel
    * **/
    QHash<int, QByteArray> roleNames() const;


private:
    QString querySQL;
    QString connectionName;
    bool fl_setQuery = false; /// станавливается в true, если запрос был послан от интерфейса,
                              /// что бы блокировать обработку сигнала от менеджера при каждом новом подключении к бд
    void queryExecute();

    QMutex mutex;
    QWaitCondition waitThreads;


public slots:
    void checkNameConnection(const QString& str_connName);


signals:
    void signalCheckConnectionDB();
    void signalUpdateDone(QString nameModel);

};

#endif // SQLQUERYMODEL_H
