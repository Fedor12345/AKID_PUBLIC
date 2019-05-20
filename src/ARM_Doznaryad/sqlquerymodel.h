#ifndef SQLQUERYMODEL_H
#define SQLQUERYMODEL_H

#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlError>
#include <QDebug>

class SqlQueryModel : public QSqlQueryModel {
    Q_OBJECT
    Q_PROPERTY(QString query READ queryStr WRITE setQueryDB NOTIFY queryStrChanged)
    Q_PROPERTY(QStringList userRoleNames READ userRoleNames CONSTANT)

private:
    bool fl_setQuery = false;   // устанавливается в true, если запрос был послан от интерфейса,
                                // что бы блокировать обработку сигнала от менеджера при каждом новом подключении к бд
    QString querySQL;
    QString connectionName;

    void queryExecute();

//    QMutex mutex;               ???
//    QWaitCondition waitThreads; ???

public:
    //using QSqlQueryModel::QSqlQueryModel;
    explicit SqlQueryModel(QString nameModel,QObject *parent = nullptr);

    QString nameModel;

    QHash<int, QByteArray> roleNames() const;
    QStringList userRoleNames() const;
    QVariant data (const QModelIndex &index, int role) const;
    Q_INVOKABLE QVariantMap get(int row);

    bool setQueryDB(const QString& query);
    void checkNameConnection(const QString& connectionName);
    QString queryStr() const;

    Q_INVOKABLE void update_data(); //выполнить последний запрос еще раз

signals:
    void queryStrChanged();
    void signalCheckConnectionDB();

};


/*
#include <QSqlQuery>
#include <QSqlQueryModel>
#include <QSqlRecord>
#include <QSqlError>
#include <QDebug>

class SqlQueryModel : public QSqlQueryModel {
    Q_OBJECT
    Q_PROPERTY(QString query READ queryStr WRITE setQueryDB NOTIFY queryStrChanged)
    Q_PROPERTY(QStringList userRoleNames READ userRoleNames CONSTANT)

private:
    bool fl_setQuery = false;   // устанавливается в true, если запрос был послан от интерфейса,
                                // что бы блокировать обработку сигнала от менеджера при каждом новом подключении к бд
    QString querySQL;
    QString connectionName;

    void queryExecute() {
        QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
        this->setQuery(this->querySQL, db);

        emit queryStrChanged();
    }

public:
    using QSqlQueryModel::QSqlQueryModel;

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    QHash<int, QByteArray> roleNames() const {
        QHash<int, QByteArray> roles;
        for (int i=0; i<record().count(); i++) {
            roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
        }
        return roles;
    }

    QStringList userRoleNames() const {
        QStringList names;
        for (int i = 0; i < record().count(); i++) {
            names << record().fieldName(i).toUtf8();
        }
        return names;
    }

    QVariant data (const QModelIndex &index, int role) const {
        QVariant value;
        if (index.isValid()) {
            if (role < Qt::UserRole) {
                value = QSqlQueryModel::data(index, role);
            } else {
                int columnIdx = role - Qt::UserRole - 1;
                QModelIndex modelIndex = this->index(index.row(), columnIdx);
                value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
            }
        }
        return value;
    }

    Q_INVOKABLE QVariantMap get(int row) {
        QHash<int,QByteArray> names = roleNames();
        QHashIterator<int, QByteArray> i(names);
        QVariantMap res;

        while (i.hasNext()) {
            i.next();
            QModelIndex idx = index(row, 0);
            QVariant data = idx.data(i.key());
            res[i.value()] = data;
        }

        return res;
    }

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    bool setQueryDB(const QString& query) {
        this->fl_setQuery = true;
        this->querySQL = query;

        emit signalCheckConnectionDB(); /// отправляем менеджеру сигнал начать попытки подключения
        return true;
    }

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    void checkNameConnection(const QString& connectionName) {
        /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
        /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка

        if(this->fl_setQuery){
            if(connectionName != "0") {
                this->connectionName = connectionName;
                queryExecute();
            }
            this->fl_setQuery = false;
        }
    }

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    QString queryStr() const {
        return query().lastQuery();
    }

    //выполнить последний запрос еще раз
    Q_INVOKABLE void update_data() {
        this->setQueryDB(queryStr());
    }

signals:
    void queryStrChanged();
    void signalCheckConnectionDB();

};
*/
#endif // SQLQUERYMODEL_H
