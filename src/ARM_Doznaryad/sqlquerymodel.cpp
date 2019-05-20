#include "sqlquerymodel.h"

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
SqlQueryModel::SqlQueryModel(QString nameModel, QObject *parent) : QSqlQueryModel(parent) {
    this->nameModel = nameModel;
    this->fl_setQuery = false;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
void SqlQueryModel::queryExecute() {
    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    this->setQuery(this->querySQL, db);

    emit queryStrChanged();
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
QHash<int, QByteArray> SqlQueryModel::roleNames() const {
    QHash<int, QByteArray> roles;
    for (int i=0; i<record().count(); i++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
QStringList SqlQueryModel::userRoleNames() const {
    QStringList names;
    for (int i = 0; i < record().count(); i++) {
        names << record().fieldName(i).toUtf8();
    }
    return names;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
QVariant SqlQueryModel::data (const QModelIndex &index, int role) const {
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

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Q_INVOKABLE QVariantMap SqlQueryModel::get(int row) {
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
bool SqlQueryModel::setQueryDB(const QString& query) {
    this->fl_setQuery = true;
    this->querySQL = query;

    //qDebug() << "-> ["<<this->nameModel<< "] signalCheckConnectionDB";
    emit signalCheckConnectionDB(); /// отправляем менеджеру сигнал начать попытки подключения
    return true;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
void SqlQueryModel::checkNameConnection(const QString& connectionName) {
    /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
    /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка

    //qDebug() << "<- ["<< this->nameModel << "] checkNameConnection > fl_setQuery: " << this->fl_setQuery << "   connection name: " << connectionName;

    if(this->fl_setQuery){
        this->connectionName = connectionName;
        if(connectionName != "0") {
            //this->connectionName = connectionName;
            queryExecute();
        }
        this->fl_setQuery = false;
    }
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
QString SqlQueryModel::queryStr() const {
    return query().lastQuery();
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
//выполнить последний запрос еще раз
Q_INVOKABLE void SqlQueryModel::update_data() {
    qDebug() << "Update SqlQueryModel:" << this->nameModel;
    this->setQueryDB(queryStr());
}


