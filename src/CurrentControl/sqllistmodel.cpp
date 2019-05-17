#include "sqllistmodel.h"

#include <QThread>
#include <QMutex>


SQLListModel::SQLListModel(QString nameModel, QObject *parent) :
    QSqlQueryModel(parent)
{
    this->nameModel = nameModel;
    this->fl_setQuery = false;
}

/// Метод для получения данных из модели
QVariant SQLListModel::data(const QModelIndex & index, int role) const {
    //qDebug() << " data | thread = " << QThread::currentThreadId();
    //qDebug()<<"        Qt::DisplayRole = "<<Qt::UserRole;
    /// Определяем номер колонки, адрес так сказать, по номеру роли
    int columnId = role - Qt::UserRole-1; //-1
    //qDebug()<<"columnId = "<< columnId;
    /// Создаём индекс с помощью новоиспечённого ID колонки
    QModelIndex modelIndex = this->index(index.row(), columnId);

    /** И с помощью уже метода data() базового класса
     * вытаскиваем данные для таблицы из модели
     * **/
    return QSqlQueryModel::data(modelIndex, Qt::DisplayRole);


}

/// Метод для получения имен ролей через хешированную таблицу.
QHash<int, QByteArray> SQLListModel::roleNames() const {
    /** То есть сохраняем в хеш-таблицу названия ролей
     * по их номеру
     * **/
//    QHash<int, QByteArray> roles;
//    roles[DateRole] = "NAME_";
//    roles[TimeRole] = "AGE";
//    roles[RandomRole] = "METERING_1";
//    roles[MessageRole] = "METERING_2";

    QHash<int, QByteArray> roles;
    int columnsNumber = this->columnCount(); //число столбцов
    int j=0;
    QString nameColumn;
    for (int i=0; i<columnsNumber; i++) {
        nameColumn = this->headerData(i, Qt::Horizontal, 0).toString();
        j = i_ID + i;
        //qDebug()<<"nameColumn = "<< nameColumn<< " i="<<j;
        roles[j] = nameColumn.toUtf8();  //.toAcii();
    }

    return roles;
}



/// обновление модели
void SQLListModel:: updateModel() {
    qDebug() << "обновление модели... | thread = " << QThread::currentThreadId();
    this->setQuery(this->query().lastQuery());

    if (this->lastError().isValid()) {
        qDebug() << "ОШИБКА ОБНОВЛЕНИЯ МОДЕЛИ : "<<this->lastError();
    }
    else {
        qDebug()<<"обновление модели прошло удачно";
    }
}

void SQLListModel:: updateModel(QString query) {
    qDebug() << "обновление модели... | thread = " << QThread::currentThreadId();
//    qDebug() << query;
    this->setQuery(query);
    qDebug() << "lastQuery = " << this->query().lastQuery();
    if (this->lastError().isValid()) {
        qDebug() << "ОШИБКА ОБНОВЛЕНИЯ МОДЕЛИ : "<<this->lastError();
    }
    else {
        qDebug()<<"обновление модели прошло удачно";
    }
}


int SQLListModel::getId(int row) {
    int id_=0;
    id_ = this->data(this->index(row, 0), this->i_ID).toInt();
    return id_;
}


bool SQLListModel::setQueryDB(QString query)
{
    qDebug() << "ModelDB_thread: Process id( != main id ): " << QThread::currentThreadId();
    qDebug() << "ModelDB_thread::queryDB: query = " << query;

    this->fl_setQuery = true;
    this->querySQL = query;
    emit signalCheckConnectionDB(); /// отправляем менеджеру сигнал начать попытки подключения


    //this->setQuery(query);
    return true;

    //qDebug()<<"ModelDB_thread::queryDB: DATA: "<<this->data(this->index(0, 0), this->i_ID+1).toString(); //.toInt();

}


void SQLListModel::checkNameConnection(QString connectionName)
{
    /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
    /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка
    //if(this->fl_setQuery){

        if(connectionName != "0"){  // !="local"
            this->connectionName = connectionName;
            queryExecute();

        }
        this->fl_setQuery = false;

    //}

}

void SQLListModel::queryExecute()
{
    //qDebug() << "1____model: " << this->nameModel;

    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    QSqlQuery querySQL(db);

    //qDebug() << "2____model | " << this->connectionName << "Open:" << db.isOpen() << "| isValid:" << db.isValid();
    this->setQuery(this->querySQL,db);
    //querySQL.lastError().text();
    emit signalUpdateDone(this->nameModel);
}




///////////////////////////////////////////////////////////////////
/// метод получения инфы на консоль ///////////////////////////////
void SQLListModel::printInfo() {

    qDebug() << "\n *** ИНФОРМАЦИЯ О МОДЕЛИ *** | thread = " << QThread::currentThreadId();

    int columnsNumber = this->columnCount(); //число столбцов
    QString nameColumn;


    qDebug()<<"ModelDB_thread : colimnsNumber = "<<columnsNumber;

    //qDebug()<<"type: "<< typeid(roles).name();

    for (int i=0; i<columnsNumber; i++) {
        nameColumn = this->headerData(i, Qt::Horizontal, 0).toString();
        qDebug()<<"ModelDB_thread : nameColumn = "<<nameColumn;
    }
    qDebug()<<"ModelDB_thread : roleNames : "<<this->roleNames();
    qDebug()<<"ModelDB_thread : roleNames : "<<this->roleNames().values().value(0);
    //qDebug()<<"modelDB : record(0)"<<this->record(0)<<"|"; //.value(1).toString()
//    qDebug()<<"modelDB : record(0)"<<this->record(0).value(0)<<"|"; //.value(1).toString()

    //печать SQL запроса, посланного в модель
    qDebug()<<"ModelDB_thread : query : "<<this->query().lastQuery(); //qDebug()<<"query : "<<__query__.lastQuery();
    qDebug()<<"ModelDB_thread : i_ID = "<<i_ID;

    qDebug() << "***************************** \n";
}
////////////////////////////////////////////////////////////////////





