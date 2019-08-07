#include "../Libs/sqlquery.h"
#include <QVariant>
#include <QMap>
#include <QDate>

#include <QMutex>


SQLquery::SQLquery(QObject *parent) : QObject(parent)
{
    qDebug() << "SQLquery:          start";
    this->fl_setQuery = false;
}

void SQLquery::setQuery(const QString &query)
{
    this->fl_setQuery = true;
    this->query = query;
    this->queries.append(query);
    this->numberQuery++;

    clearqueriesGroup();

    emit signalCheckConnectionDB();   /// отправляем менеджеру сигнал начать попытки подключения
    //queryExecute();
}

/// перегрузка функции в случае, если вопросы необходимо выполнить в группе
void SQLquery::setQuery(const QString &query, const bool &isGroup)
{
    this->fl_setQuery = true;
    this->query = query;

    if(isGroup) { this->queriesGroup.append(query); this->isGroup = isGroup; }
    else        { clearqueriesGroup(); }

    emit signalCheckConnectionDB();   /// отправляем менеджеру сигнал начать попытки подключения
    //queryExecute();
}

/// очищает список вопросов
void SQLquery::clearqueriesGroup(){
    this->queriesGroup.clear();
    this->isGroup = false;
}


void SQLquery::checkNameConnection(QString connectionName) //, bool isNewName
{
    /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
    /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка

    if(!this->fl_setQuery) { return; }


    QString query;
    //qDebug() << " -> SQLquery: checkNameConnection:  " << isNewName;
    /// если вопрос входит в группу из вопросов
//    if (this->isGroup) {
//        /// проверка поменялось ли имя соединения
//        if(this->connectionName!=connectionName){
//            this->isNewName = true;
//            this->iQueryGroup = 0;
//        }
//        /// если имя соединения было измененно для вопроса из группы вопросов(хотя бы один раз),
//        /// то прогоняем все запросы из списка queriesGroup с начала
//        if(this->isNewName){
//            query = this->queriesGroup.at(this->iQueryGroup);
//            this->iQueryGroup++;
//            if(this->iQueryGroup==queriesGroup.size()) {
//                this->isNewName = false;
//            }
//        }
//    }
//    else {
//        query = this->query;
//    }


    this->connectionName = connectionName;

    for ( int i = 0; i < this->queries.length(); i++ )
    {
        query = this->queries.at(i);
        qDebug() << " -> SQLquery: checkNameConnection: query: " << query;

        if(connectionName != "0")
        {
            queryExecute(query);
        }
        else
        {
            /// ВЫПОЛНЯТЬ В СЛУЧАЕ ЕСЛИ ИМЯ СОЕДИНЕНИЯ 0
        }
    }
    this->queries.clear();
    this->numberQuery = 0;



    this->fl_setQuery = false;

    if(this->isNewName){
        emit signalCheckConnectionDB();
    }


}

void SQLquery::queryExecute(QString query)
{
    //qDebug() << "queryExecute";
    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    QSqlQuery querySQL(db);
    QString str = "";

    if(!querySQL.exec(query))
    {
        ///Ошибка при выполнении запроса
        str = this->connectionName + ": error: " + querySQL.lastError().text();
        qDebug() << " -> SQLquery: queryExecute:  "  << str << query;
        emit signalSendResult(sender_name, false, NULL);
    }
    else
    {
        if(querySQL.first())//query->next();
        {
            bool fl = false;
            str = querySQL.value(0).toString();
            int i = 1;
            while(!fl) {
                if(querySQL.value(i) == QVariant()){
                     fl = true;
                     break;
                }
                str = str + "; " + querySQL.value(i).toString();
                i++;
            }

            //str = this->connectionName + ": " + str; // query->record();
            qDebug() << " -> SQLquery: queryExecute:  " << this->connectionName << ": " << str << query;   //.numRowsAffected();
            if(i>1) {
                emit signalSendResult(sender_name, true, str); }
            else {
                emit signalSendResult(sender_name, true, querySQL.value(0));
            }

        }
        else {
            str = this->connectionName + ": error: " + "Нет такой записи";
            qDebug() << " -> SQLquery: queryExecute:  " << str << query;
            emit signalSendResult(sender_name, true, NULL);
        }


    }

}



/// функции Дмитрия

/// определеяет максимальное значение ID в таблице
//tname - имя таблицы
//fname - имя поля
//val - значение отбора
void SQLquery::getMaxID(const QString& owner_name, const QString &tname, const QString &fname, const QVariant &val) {
    sender_name = owner_name;

    QString tstr1 = "";

    if (fname.length() > 0) {
        tstr1 = "SELECT max(id_person) max_id FROM " + tname + " WHERE "+fname +" = " + val.toString();
    } else {
        tstr1 = "SELECT max(id_person) max_id FROM " + tname;
    }

    qDebug() << " + query: " << tstr1;
    setQuery(tstr1);
}


//------------------------------------------------------------------------------------
////Метод для вставки записи в базу данных
bool SQLquery::insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map) {
//    QSqlQuery query;

    sender_name = owner_name;

    QString tstr1 = "INSERT INTO ", tstr2 = "VALUES (";
    tstr1 = tstr1 + tname + " (";

    //подготовка запроса > INSERT INTO table ([field1], ...) VALUES (:param1, ...)
    foreach (QString key, map.keys()) {
        tstr1 = tstr1 + key+",";//tstr1 +"["+ key+"],";
//        tstr2 = tstr2 +"'"+ map.value(key).toString() + "',";

//        switch (map.value(key).type()) {
//        case QVariant::Date:
//            //query.bindValue(":"+key, map.value(key).toDate());
//            break;
//        case QVariant::Double:
//            tstr2 = tstr2 +"'"+  map.value(key).toString() + "',";//map.value(key).toString().replace(".",",")
//            break;
//        default:
//            tstr2 = tstr2 +"'"+ map.value(key).toString() + "',";
//        }


        if (map.value(key).type() == QVariant::DateTime) {
            tstr2 = tstr2 +"TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'),";
            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
        } else {
            tstr2 = tstr2 +"'"+  map.value(key).toString() + "',";
        }
    }
    tstr1.remove (tstr1.length()-1, 1);
    tstr2.remove (tstr2.length()-1, 1);
    tstr1 = tstr1+") "+tstr2+")";

    qDebug() << " + query: " << tstr1;

    setQuery(tstr1);

    return true;
}
