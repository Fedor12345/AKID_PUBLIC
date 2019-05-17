#include "../Libs/sqlquerymodel.h"

#include <QThread>
#include <QMutex>


SQLQueryModel::SQLQueryModel(QString nameModel, QObject *parent) :
    QSqlQueryModel(parent)
{
    this->nameModel = nameModel;
    this->fl_setQuery = false;
}

SQLQueryModel::~SQLQueryModel(){
    qDebug() << "Destroy SQLQueryModel: " << this->nameModel;

}

/// Метод для получения данных из модели
QVariant SQLQueryModel::data(const QModelIndex & index, int role) const {
    QVariant value;
    if (index.isValid()) {
        if (role < Qt::UserRole) {
            value = QSqlQueryModel::data(index, role);
        } else {
            /// Определяем номер колонки, адрес так сказать, по номеру роли
            int columnIdx = role - Qt::UserRole - 1;
            /// Создаём индекс с помощью новоиспечённого ID колонки
            QModelIndex modelIndex = this->index(index.row(), columnIdx);
            /// И с помощью уже метода data() базового класса
            /// вытаскиваем данные для таблицы из модели
            value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        }
    }
    return value;

//    //qDebug() << " data | thread = " << QThread::currentThreadId();
//    //qDebug()<<"        Qt::DisplayRole = "<<Qt::UserRole;
//    /// Определяем номер колонки, адрес так сказать, по номеру роли
//    int columnId = role - Qt::UserRole-1; //-1
//    //qDebug()<<"columnId = "<< columnId;
//    /// Создаём индекс с помощью новоиспечённого ID колонки
//    QModelIndex modelIndex = this->index(index.row(), columnId);

//    /** И с помощью уже метода data() базового класса
//     * вытаскиваем данные для таблицы из модели
//     * **/
//    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);


}

/// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> SQLQueryModel::roleNames() const {
    QHash<int, QByteArray> roles;
    for (int i=0; i<record().count(); i++) {
        roles.insert(Qt::UserRole + i + 1, record().fieldName(i).toUtf8());
    }
    return roles;

//    QHash<int, QByteArray> roles;
//    int columnsNumber = this->columnCount(); //число столбцов
//    qDebug()<<"columnsNumber= " << columnsNumber;
//    int j=0;
//    QString nameColumn;
//    for (int i=0; i<columnsNumber; i++) {
//        nameColumn = this->headerData(i, Qt::Horizontal, 0).toString();
//        j = i_ID + i;
//        qDebug()<<"nameColumn = "<< nameColumn<< " i="<<j;
//        roles[j] = nameColumn.toUtf8();  //.toAcii();
//    }

//    return roles;
}



/// обновление модели
void SQLQueryModel:: updateModel() {
    qDebug() << " -> SQLmodel: обновление модели... | thread = " << QThread::currentThreadId();
    this->setQuery(this->query().lastQuery());

    if (this->lastError().isValid()) {
        qDebug() << " -> SQLmodel: ОШИБКА ОБНОВЛЕНИЯ МОДЕЛИ : "<<this->lastError();
    }
    else {
        qDebug()<<" -> SQLmodel: обновление модели прошло удачно";
    }
}

void SQLQueryModel:: updateModel(QString query) {
    qDebug() << " -> SQLmodel: обновление модели... | thread = " << QThread::currentThreadId();
//    qDebug() << query;
    this->setQuery(query);
    qDebug() << "lastQuery = " << this->query().lastQuery();
    if (this->lastError().isValid()) {
        qDebug() << " -> SQLmodel: ОШИБКА ОБНОВЛЕНИЯ МОДЕЛИ : "<<this->lastError();
    }
    else {
        qDebug() << " -> SQLmodel: обновление модели прошло удачно";
    }
}

// получить данные в первом столбце из запроса (в интежере)
int SQLQueryModel::getId(int row) {
    int id_=0;
    id_ = this->data(this->index(row, 0), this->i_ID).toInt();
    //qDebug() << " -> SQLmodel(" << this->nameModel << "):" << "id_ = " << id_;
    return id_;
}

// получить данные в первом столбце из запроса
QString SQLQueryModel::getFirstColumn(int row) {
    QString str="";
    str = this->data(this->index(row, 0), this->i_ID).toString();
    //qDebug() << " -> SQLmodel(" << this->nameModel << "):" << "id_ = " << id_;
    return str;
}


QVariantMap SQLQueryModel::get(int row)
{
    QHash<int,QByteArray> names = roleNames();
    QHashIterator<int, QByteArray> i(names);
    QVariantMap res;

    while (i.hasNext()) {
        i.next();
        QModelIndex idx = index(row, 0);
        QVariant data = idx.data(i.key());
        res[i.value()] = data;
        //cout << i.key() << ": " << i.value() << endl;
    }

    return res;
}


bool SQLQueryModel::setQueryDB(QString query)
{
    qDebug() << " -> SQLmodel(" << this->nameModel << "): setQuery(): query = " << query << "| thread = " << QThread::currentThreadId();

    this->fl_setQuery = true;
    this->querySQL = query;
    emit signalCheckConnectionDB(); /// отправляем менеджеру сигнал начать попытки подключения


    //this->setQuery(query);
    return true;

    //qDebug()<<"ModelDB_thread::queryDB: DATA: "<<this->data(this->index(0, 0), this->i_ID+1).toString(); //.toInt();

}


void SQLQueryModel::checkNameConnection(QString connectionName)
{
    qDebug() << "\n -> SQLmodel(" << this->nameModel << "): checkNameConnection() 1" << "| thread = " << QThread::currentThreadId();

    /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
    /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка
    //if(!this->fl_setQuery) { return; }
    qDebug() << "\n -> SQLmodel(" << this->nameModel << "): checkNameConnection() 2" << "| thread = " << QThread::currentThreadId();


    if(connectionName != "0"){  // !="local"
        //qDebug() << " -> SQLmodel(" << this->nameModel << "): checkNameConnection(): connectionName != '0'" << "| thread = " << QThread::currentThreadId();
        this->connectionName = connectionName;
        queryExecute();

    }
    this->fl_setQuery = false;

}

QString SQLQueryModel::queryStr() const
{
    return query().lastQuery();
}

void SQLQueryModel::queryExecute()
{
    //qDebug() << "1____model: " << this->nameModel;

    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    QSqlQuery querySQL(db);

    qDebug() << " -> SQLmodel(" << this->nameModel << "): queryExecute(): querySQL = " << this->querySQL;
    this->setQuery(this->querySQL,db);

    if(querySQL.lastError().isValid()) { qDebug() << " -> SQLmodel(" << this->nameModel << "): setQuery_ERROR: " << querySQL.lastError().text(); }
    qDebug() << " -> SQLmodel(" << this->nameModel << "): roleNames : "<<this->roleNames();
    //qDebug() << " -> SQLmodel: roleNames : " << this->roleNames().values().value(0);
    emit signalUpdateDone(this->nameModel);
}




///////////////////////////////////////////////////////////////////
/// метод получения инфы на консоль ///////////////////////////////
void SQLQueryModel::printInfo() {

    qDebug() << "\n *** ИНФОРМАЦИЯ О SQL МОДЕЛИ ***  | thread = " << QThread::currentThreadId();

    int columnsNumber = this->columnCount(); //число столбцов
    QString nameColumn;


    qDebug() << " -> SQLmodel: colimnsNumber = " << columnsNumber;

    //qDebug()<<"type: "<< typeid(roles).name();

    for ( int i=0; i<columnsNumber; i++ ) {
        nameColumn = this->headerData(i, Qt::Horizontal, 0).toString();
        qDebug() << " -> SQLmodel: nameColumn = " << nameColumn;
    }
    qDebug() << " -> SQLmodel: roleNames: " << this->roleNames();
    qDebug() << " -> SQLmodel: roleNames: " << this->roleNames().values().value(0);
    //qDebug()<<"modelDB : record(0)"<<this->record(0)<<"|"; //.value(1).toString()
//    qDebug()<<"modelDB : record(0)"<<this->record(0).value(0)<<"|"; //.value(1).toString()

    //печать SQL запроса, посланного в модель
    qDebug() << " -> SQLmodel: query = " << this->query().lastQuery(); //qDebug()<<"query : "<<__query__.lastQuery();
    qDebug() << " -> SQLmodel: i_ID = "  << i_ID;

    qDebug() << "***************************** \n";
}
////////////////////////////////////////////////////////////////////





