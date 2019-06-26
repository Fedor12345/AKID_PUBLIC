#include "../Libs/sqlquery.h"
#include <QVariant>
#include <QMap>
#include <QDate>

//#include <QMutex>

#include <QSqlRecord>


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

// в параметрах указывается SQL запрос и уникальное имя для идентификации этого запроса
void SQLquery::setQueryAndName(const QString &query, const QString &owner_name)
{
    this->sender_name = owner_name;
    this->sender_names.append(owner_name);
    this->setQuery(query);
}


//void SQLquery::setQueryWithName(const QString &owner_name, const QString &query)
//{
//    this->sender_name = owner_name;
//    setQuery(query);
//}



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
        this->iQuery = i;
        query = this->queries.at(i);
//        qDebug() << " -> SQLquery: checkNameConnection: query: " << query;

        if(connectionName != "0")
        {
            queryExecute(query);
        }
        else
        {
            emit signalSendResult(sender_name, false, NULL, "Соединение с БД отстутсвует");
            /// ВЫПОЛНЯТЬ В СЛУЧАЕ ЕСЛИ ИМЯ СОЕДИНЕНИЯ 0
        }
    }
    this->queries.clear();
    this->sender_names.clear();
    this->numberQuery = 0;
    this->iQuery = 0;



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
    int numberOfRecords = 0;

    result_data.clear();

    //qDebug() << " !!!! ПРОВЕРКА " << this->iQuery;
    //qDebug() << " !!!! ПРОВЕРКА " << sender_names.at(this->iQuery);
    QString sender_name_current = sender_names.at(this->iQuery);

    if(!querySQL.exec(query))
    {
        ///Ошибка при выполнении запроса
        str = this->connectionName + ": error: " + querySQL.lastError().text();

        qDebug() << " -> SQLquery: queryExecute:  "  << str << query;
        //result_data.clear();
        emit signalSendResult(sender_names.at(this->iQuery), false, NULL, querySQL.lastError().text());
    }
    else
    {
        qDebug() << " -> SQLquery: queryExecute:  "  << "Запрос прошел: " << sender_name_current << ": " << query;
        query = query.toUpper();
        if(~query.indexOf("SELECT")) {
            QSqlRecord rec;
            if (querySQL.first()) {
                rec = querySQL.record();
                for (int i = 0; i < rec.count(); ++i) {
                    numberOfRecords++;
                    result_data.insert(rec.fieldName(i),querySQL.value(i));
                }
                //qDebug() << " ->1 result_data = " << result_data;
            }
            else {
                emit signalSendResult(sender_name_current, true, NULL, "error: Нет такой записи");
            }
            /// Если запись только одна (число столбцов в результате запроса),
            /// то посылается строка с результатом запроса
            if ( numberOfRecords <= 1 ) {
                querySQL.first();
                //str = querySQL.value(0).toString();
                emit signalSendResult(sender_name_current, true, querySQL.value(0), "");
            }
            /// Если записей много, то посылается объект result_data класса QMap с множеством записей (столбцов)
            else {
                emit signalSendResult(sender_name_current, true, result_data, "");
            }


            /// Если в результате запроса содержится несколько полей (т.е. строк), то необходимо дописать код:
            /// в цикле (по rec.count) объект result_data добавлять в дополнительный массив,
            /// т.к result_data - это запись лишь одной строки
//          bool queryExecuteOK = false;
//            while (querySQL.next()) {
//                queryExecuteOK = true;
//                numberOfRecords = 0;
//                rec = querySQL.record();
//                for (int i = 0; i < rec.count(); ++i) {
//                    numberOfRecords++;
//                    result_data.insert(rec.fieldName(i),querySQL.value(i));
//                }
//            }
//            /// Если не было обноруженно ниодной записи (queryExecuteOK в цикле не сменился на true),
//            /// то послыется сообщение
//            if(!queryExecuteOK) {
//                qDebug() << " -> SQLquery: queryExecute:  " << str << query;
//                emit signalSendResult(sender_name, true, NULL, "error: Нет такой записи");
//            }

        }
        else {
            emit signalSendResult(sender_name_current, true, NULL, "");
        }



    }

}


void SQLquery::checkAddRecord(const QString &owner_name, const QString &query)
{
    //setQuery(query);
    //return true;
}


/// функции Дмитрия

/// определеяет максимальное значение ID в таблице
//tname - имя таблицы
//fname - имя поля
//val - значение отбора
void SQLquery::getMaxID(const QString& owner_name, const QString &tname, const QString &fname, const QVariant &val) {
    //sender_name = owner_name;
    this->sender_name = owner_name;
    this->sender_names.append(owner_name);

    QString tstr1 = "";

    if (fname.length() > 0) {
        tstr1 = "SELECT max(id_person) max_id FROM " + tname + " WHERE "+fname +" = " + val.toString();
    } else {
        tstr1 = "SELECT max(id_person) max_id FROM " + tname;
    }

    qDebug() << " -> SQLquery: getMaxID(): query: " << tstr1;
    setQuery(tstr1);
}


//------------------------------------------------------------------------------------
////Метод для вставки записи в базу данных
bool SQLquery::insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map) {
//    QSqlQuery query;

    //sender_name = owner_name;
    this->sender_name = owner_name;
    this->sender_names.append(owner_name);

    QString tstr1 = "INSERT INTO ", tstr2 = "VALUES (";
    tstr1 = tstr1 + tname + " (";

    //подготовка запроса > INSERT INTO table ([field1], ...) VALUES (:param1, ...)
    foreach (QString key, map.keys()) {
        tstr1 = tstr1 + key + ",";//tstr1 +"["+ key+"],";
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
            tstr2 = tstr2 + "TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'),";
            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
        } else {
            tstr2 = tstr2 + "'" +  map.value(key).toString() + "',";
        }
    }
    tstr1.remove (tstr1.length()-1, 1);
    tstr2.remove (tstr2.length()-1, 1);
    tstr1 = tstr1+") "+tstr2+")";

    qDebug() << " -> SQLquery: insertRecordIntoTable(): query: " << tstr1;

    setQuery(tstr1);

    return true;
}

bool SQLquery::updateRecordIntoTable(const QString &owner_name, const QString &tname, const QMap<QString, QVariant> &map, const QString &idWhere, const int &id)
{
   // return NULL;
    //sender_name = owner_name;
    this->sender_name = owner_name;
    this->sender_names.append(owner_name);

    QString tstr = " UPDATE " + tname + " SET ";


    foreach (QString key, map.keys()) {
        tstr = tstr + key + " = ";
        if (map.value(key).type() == QVariant::DateTime) {
            tstr = tstr + " TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'), ";
            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
        } else {
            tstr = tstr + " '" +  map.value(key).toString() + "',";
        }
    }
    tstr = tstr.remove(tstr.length()-1,1);
    tstr = tstr + " WHERE " + idWhere + " = " + QString::number(id);

    qDebug() << " -> SQLquery: updateRecordIntoTable(): query: " << tstr;

    setQuery(tstr);

    return true;
}
