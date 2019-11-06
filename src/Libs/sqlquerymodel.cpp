#include "../Libs/sqlquerymodel.h"

#include <QThread>
#include <QMutex>


SQLQueryModel::SQLQueryModel(QString nameModel, QObject *parent) : QSqlQueryModel(parent) {
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
    //qDebug() << "roles = " << roles;
    return roles;

//    QHash<int, QByteArray> roles;
//    int columnsNumber = this->columnCount(); //число столбцов
//    //qDebug()<<"columnsNumber= " << columnsNumber;
//    int j=0;
//    QString nameColumn;
//    for (int i=0; i<columnsNumber; i++) {
//        nameColumn = this->headerData(i, Qt::Horizontal, 0).toString();
//        j = i_ID + i;
//        //qDebug()<<"nameColumn = "<< nameColumn<< " i="<<j;
//        roles[j] = nameColumn.toUtf8();  //.toAcii();
//    }
//    return roles;

}



// получить данные в первом столбце из запроса (в интежере)
int SQLQueryModel::getFirstColumnInt(int row) {
    int id_ = 0;
    if (row >= 0) {
        id_ = this->data( this->index(row, 0), this->i_ID ).toInt(); /// this->i_ID = Qt::UserRole + 1
        //qDebug() << " -> SQLmodel(" << this->nameModel << "):" << "id_ = " << id_;
    }
    return id_;
}

// получить данные в первом столбце из запроса
QString SQLQueryModel::getFirstColumn(int row) {
    QString str="";
    if (row >= 0) {
        str = this->data( this->index(row, 0), this->i_ID ).toString();  /// this->i_ID = Qt::UserRole + 1
        //qDebug() << " -> SQLmodel(" << this->nameModel << "):" << "id_ = " << id_;
    }
    return str;
}

/// Вытаскивает данные из ячейки с заданным номером строки и указанным именем столбца (роли)
QString SQLQueryModel::getCurrentDateByName(const QByteArray &columnName, const int &row)
{
    QString str = "";
    int iDate = 0;
    iDate = roleNames().key(columnName);
    str = this->data( this->index(row, 0 ), iDate).toString();
    //qDebug() << " (QByteArray) iDate = " << iDate << " role: " << roleNames().values() << "str = " << str;

    return str;
}

QString SQLQueryModel::getCurrentDate(const int &columnNumber, const int &row)
{
    QString str = "";
    int iDate = 0;
    iDate = Qt::UserRole + 1 + columnNumber;
    str = this->data( this->index(row, 0), iDate).toString();
    //qDebug() << " (int) iDate = " << iDate << " role: " << roleNames().values() << "str = " << str;

    return str;
}

int SQLQueryModel::getIndexRow(const QString &columnName, const QString &value)
{
    /////////////////////////////////
    return NULL;
    /////////////////////////////////


    qDebug() << " --> SQLmodel(" << this->nameModel << "): getIndexRow(): columnName = " << columnName <<  " value = " << value;
    qDebug() << " --> SQLmodel(" << this->nameModel << "): getIndexRow(): roleNames().value(0)= "  << this->roleNames().values(); //this->roleNames().values().value(0);

    int iColumn = 0;
    for (int i=0; i<record().count(); i++) {
        if( this->roleNames().values().value(i) == columnName ) {
            qDebug() << " --> SQLmodel(" << this->nameModel << "): getIndexRow(): roleNames().value(0) = "  << this->roleNames().values().value(i); //this->roleNames().values().value(0);
            iColumn = i;
        }
    }
    int indexRow = 0;
    while(this->data(this->index(indexRow, iColumn), this->i_ID).toInt())
    {
        indexRow++;
    }
//    indexRow = this->data(this->index(i, iColumn), this->i_ID).toInt();  /// this->i_ID = Qt::UserRole + 1
    qDebug() << " --> SQLmodel(" << this->nameModel << "): getIndexRow(): indexRow = "  << indexRow;


    return NULL;
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





/// обновление модели
void SQLQueryModel:: updateModel() {
    qDebug() << " -> SQLmodel(" << this->nameModel << "): обновление модели... | thread = " << QThread::currentThreadId();
    //this->setQuery(this->query().lastQuery());
    setQueryDB( this->querySQL );


//    if (this->lastError().isValid()) {
//        qDebug() << " -> SQLmodel(" << this->nameModel << "): (это неточно) ОШИБКА ОБНОВЛЕНИЯ МОДЕЛИ : "<<this->lastError();
//    }
//    else {
//        qDebug()<<" -> SQLmodel(" << this->nameModel << "): (это неточно) обновление модели прошло удачно";
//    }

}



bool SQLQueryModel::setQueryDB(QString query)
{
    qDebug() << " -> SQLmodel(" << this->nameModel << "): setQuery(): query = " << query << "| thread = " << QThread::currentThreadId();

    this->fl_setQuery = true;
    this->querySQL = query;
    emit signalCheckConnectionDB(this->nameModel); /// отправляем менеджеру сигнал начать попытки подключения


    //this->setQuery(query);
    return true;

    //qDebug()<<"ModelDB_thread::queryDB: DATA: "<<this->data(this->index(0, 0), this->i_ID+1).toString(); //.toInt();

}


void SQLQueryModel::checkNameConnection(QString connectionName)
{
    qDebug() << "\n -> SQLmodel(" << this->nameModel << "): checkNameConnection(): got the signal connect..." << "| thread = " << QThread::currentThreadId();

    /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
    /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка
    if(!this->fl_setQuery) { return; }
    //qDebug() << "\n -> SQLmodel(" << this->nameModel << "): checkNameConnection()" << "| thread = " << QThread::currentThreadId();


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
    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    qDebug() << "\n -> SQLmodel(" << this->nameModel << "): queryExecute(): querySQL = \n" << this->querySQL << "\n";
    this->setQuery(this->querySQL,db);

    /// Проверка на ошибки выполнения запроса
    bool res = true;
    QString errorMessage = "";
    if (this->lastError().isValid()) {
        qDebug() << " -> SQLmodel(" << this->nameModel << "): ОШИБКА ОБНОВЛЕНИЯ МОДЕЛИ : "<<this->lastError();
        errorMessage = this->lastError().text();
        res = false;
    }
    else {
        qDebug()<<" -> SQLmodel(" << this->nameModel << "): обновление модели прошло успешно";
    }


    //QSqlQuery querySQL(db);
    //if(querySQL.lastError().isValid()) { qDebug() << " -> SQLmodel(" << this->nameModel << "): setQuery_ERROR: " << querySQL.lastError().text(); }
    qDebug() << " -> SQLmodel(" << this->nameModel << "): roleNames : "<<this->roleNames();
    //qDebug() << " -> SQLmodel: roleNames : " << this->roleNames().values().value(0);

    emit signalUpdateDone(this->nameModel, res, errorMessage);
}




///////////////////////////////////////////////////////////////////
/// метод получения инфы на консоль ///////////////////////////////
void SQLQueryModel::printInfo() {

    qDebug() << "\n *** ИНФОРМАЦИЯ О SQL МОДЕЛИ ***  | thread = " << QThread::currentThreadId();

    int columnsNumber = this->columnCount(); //число столбцов
    QString nameColumn;


    qDebug() << " -> SQLmodel(" << this->nameModel << "):: colimnsNumber = " << columnsNumber;

    //qDebug()<<"type: "<< typeid(roles).name();

    for ( int i=0; i<columnsNumber; i++ ) {
        nameColumn = this->headerData(i, Qt::Horizontal, 0).toString();
        qDebug() << " -> SQLmodel(" << this->nameModel << "): nameColumn = " << nameColumn;
    }
    qDebug() << " -> SQLmodel(" << this->nameModel << "): roleNames: " << this->roleNames();
    qDebug() << " -> SQLmodel(" << this->nameModel << "): roleNames: " << this->roleNames().values().value(0);
    //qDebug()<<"modelDB : record(0)"<<this->record(0)<<"|"; //.value(1).toString()
//    qDebug()<<"modelDB : record(0)"<<this->record(0).value(0)<<"|"; //.value(1).toString()

    //печать SQL запроса, посланного в модель
    qDebug() << " -> SQLmodel(" << this->nameModel << "): query = " << this->query().lastQuery(); //qDebug()<<"query : "<<__query__.lastQuery();
    qDebug() << " -> SQLmodel(" << this->nameModel << "): i_ID = "  << i_ID;

    qDebug() << "***************************** \n";
}
////////////////////////////////////////////////////////////////////





