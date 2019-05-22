#include <QVariant>
#include <QMap>
#include <QList>
#include <QDate>

#include <QSqlRecord>
//#include <QEventLoop>

#include "mysqlquery.h"

SQLquery::SQLquery(QString nameModel, QObject *parent) : QObject(parent) {
    this->fl_setQuery = false;
    this->nameModel = nameModel;
}

void SQLquery::setQuery(const QString& query) {
    this->fl_setQuery = true;
    this->querySQL = query;
    this->result_data.clear();

    //qDebug() << "-> ["<<this->nameModel<< "] signalCheckConnectionDB";
    emit signalCheckConnectionDB(); /// отправляем менеджеру сигнал начать попытки подключения
}

void SQLquery::checkNameConnection(QString connectionName) {
    /// т.к. эта функция запускается от сигнала от менеджера при удачном подключении к бд,
    /// необходимо игнорировать выполнение функции, если перед ее запуском не была нажата соответсвующая кнопка
    //qDebug() << "<- ["<< this->nameModel << "] checkNameConnection > fl_setQuery: " << this->fl_setQuery << "   connection name: " << connectionName;

    if(this->fl_setQuery){

        this->connectionName = connectionName;
        if(connectionName != "0"){
            //this->connectionName = connectionName;
//            qDebug () << "1. " << this->querySQL;
//            qDebug () << "2. " << this->connectionName;
            queryExecute();
        } else {
//            qDebug () << "3. " << this->querySQL;
//            qDebug () << "4. " << this->connectionName;
            result_state = false;

            //emit signalGetReady();
            if (evloop.isRunning())
                evloop.exit();        }

        this->fl_setQuery = false;
    }
}

void SQLquery::queryExecute() {
    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    QSqlQuery query(db);
    QMap<QString, QVariant> map;

    QString str = "";

    bool res_bool = false;

    qDebug() << " queryExecute() > ";

    if(!query.exec(this->querySQL)) {
        //Ошибка при выполнении запроса
        qDebug() << this->connectionName + ": error: " + query.lastError().text();
    } else {
        res_bool = true;
        result_data.clear();

//        if(query.first()) {
//            QSqlRecord rec = query.record();
//            for (int i = 0; i < rec.count(); ++i) {
//                map.insert(rec.fieldName(i), query.value(i));
//                result_data.insert(rec.fieldName(i),query.value(i));
//                str = str + "; " + "("+rec.fieldName(i) + ") " + query.value(i).toString();
//            }
//            qDebug() << "   result: " << str;
//            str = "";
////            while (query.next()) {
////                rec = query.record();
////                for (int i = 0; i < rec.count(); ++i) {
////                    str = str + "; " + "("+rec.fieldName(i) + ") " + query.value(i).toString();
////                }
////                qDebug() << "   result: " << str;
////                str = "";
////            }
//        }

        QSqlRecord rec;
        QList<QVariantMap> xxx;
        QVariantMap zzz;

        z_data.clear();

        while (query.next()) {
            rec = query.record();
            for (int i = 0; i < rec.count(); ++i) {
                //map.insert(rec.fieldName(i), query.value(i));
                zzz.insert(rec.fieldName(i), query.value(i));

                result_data.insert(rec.fieldName(i),query.value(i));
                //str = str + "; " + "("+rec.fieldName(i) + ") " + query.value(i).toString();
            }
            xxx.append(zzz);

            z_data.append(zzz);

            zzz.clear();
        }

        //qDebug() << "queryExecute().result: " << str;
        str = "";
    }

    result_state = res_bool;
    //emit signalSendResult(sender_name , res_bool, map);
    emit signalSendResult(sender_name , res_bool, result_data);
    //emit signalGetReady();
    if (evloop.isRunning())
        evloop.exit();
}

//------------------------------------------------------------------------------------
////Метод для вставки записи в базу данных
bool SQLquery::insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map, const bool& flg_async) {
    qDebug() << "\n - RUN insertRecordIntoTable\n";

//    QEventLoop loop1(this);
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop1]() {
//        qDebug() << "insertRecordIntoTable LOOP: get signalGetReady()";
//        if (loop1.isRunning())
//            loop1.exit();
//    });

    sender_name = owner_name;

    QString tstr1 = "INSERT INTO ", tstr2 = "VALUES (";
    tstr1 = tstr1 + tname + " (";

    //подготовка запроса > INSERT INTO table ([field1], ...) VALUES (:param1, ...)
    foreach (QString key, map.keys()) {
        tstr1 = tstr1 + key+",";//tstr1 +"["+ key+"],";

        if (map.value(key).type() == QVariant::DateTime) {
            tstr2 = tstr2 +"TO_DATE('"+ map.value(key).toDateTime().toString("yyyy-MM-dd hh:mm") + "', 'YYYY-MM-DD HH24:MI'),";
            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
        } else {
            tstr2 = tstr2 +"'"+  map.value(key).toString() + "',";
        }
    }

    tstr1.remove (tstr1.length()-1, 1);
    tstr2.remove (tstr2.length()-1, 1);
    tstr1 = tstr1+") "+tstr2+")";

    qDebug() << "query: " << ( flg_async ? "[async]" : "[sync]  ") << tstr1;

    //this->querySQL = tstr1; //!!!
    //queryExecute();

    setQuery(tstr1);

    if (!flg_async) {
        //loop1.exec();    // ждем пока выполнится запрос (signalGetReady)
        if (!evloop.isRunning())
            evloop.exec();
    }

    qDebug() << "\n - EXIT insertRecordIntoTable\n";
    return this->result_state;
}

//----------------------------------------------------------------------------------------
//tname - имя таблицы
//fname - имя поля
//val - значение отбора
int SQLquery::getMaxID(const QString& owner_name, const QString &tname, const QString &fname, const QVariant &val, const bool& flg_async) {

    qDebug() << "\n - RUN getMaxID\n";

//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {loop.exit();});

    sender_name = owner_name;

    QString tstr1 = "";

    if (fname.length() > 0) {
        tstr1 = "SELECT max(ID) MAX_ID FROM " + tname + " WHERE "+fname +" = '" + val.toString()+"'";
    } else {
        tstr1 = "SELECT max(ID) MAX_ID FROM " + tname;
    }

    qDebug() << "   query: " << tstr1;
    //this->querySQL = tstr1; //!!!
    //queryExecute();

    setQuery(tstr1);

    if (!flg_async) {
        //loop.exec();
        if (!evloop.isRunning())
            evloop.exec();
    }

    qDebug() << "\n - EXIT getMaxID\n";

    if ((result_state == true) && (!result_data.isEmpty())) {
            return result_data.value("MAX_ID").toInt();
    }

    return -1;
}

//-------------------------------------------------------------------------------------------
QMap<QString, QVariant> SQLquery::find_record(const QString& owner_name,const QString &sql_query,
                                              const bool& flg_async) {
    qDebug() << " - find_record";

//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {loop.exit();});

    sender_name = owner_name;

//    if (sql_query.length() > 0)
//        setQuery(sql_query);

    if (sql_query.length() > 0) {
        setQuery(sql_query);
        if (!flg_async) {
            //loop.exec();
            if (!evloop.isRunning())
                evloop.exec();
        }
    }

    return result_data;
}

//--------------
QVariantList SQLquery::find_records(const QString &sql_query) {
    qDebug() << " - find_records";

//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {loop.exit();});

    if (sql_query.length() > 0) {
        setQuery(sql_query);
        //loop.exec();
        if (!evloop.isRunning())
            evloop.exec();
    }

    return z_data;
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// Метод для обновления записи из таблицы
bool SQLquery::updateRecord(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map,
                            const bool& flg_async) {

    qDebug() << " - update_record";

    QString tstr1, tstr2;
//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {
//        qDebug() << "updateRecord LOOP: get signalGetReady()";
//        if (loop.isRunning())
//            loop.exit(0);
//    });

    sender_name = owner_name;

    foreach (QString key, map.keys()) {
        if (key != "ID") {

            if (map.value(key).type() == QVariant::DateTime) {
                tstr2 = tstr2 +key+"=TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'),";
                //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
            } else {
                tstr2 = tstr2 +key+"='"+  map.value(key).toString() + "',";
            }

        }
    }
    tstr2.remove (tstr2.length()-1, 1);
    tstr1 = "UPDATE " + tname + " SET " + tstr2 + " WHERE ID = "+map.value("ID").toString();
    //qDebug() << tstr1;

    if (tstr1.length() > 0) {
        setQuery(tstr1);

        if (!flg_async) {
            //loop.exec();
            if (!evloop.isRunning())
                evloop.exec();
        }

        return result_state;
    } else {
        return false;
    }
}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
bool SQLquery::deleteRecord(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map, const bool& flg_async) {
    QString tstr1, tstr2;
//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {
//        qDebug() << "deleterecord LOOP: get signalGetReady()";
//        loop.exit();});

    sender_name = owner_name;

    QString key = map.keys()[0];
    tstr1 = "DELETE FROM " + tname + " WHERE " + key + " = " +map.value(key).toString();
    qDebug() << "deleteRecord: " << tstr1;

    if (tstr1.length() > 0) {
        setQuery(tstr1);

        if (!flg_async) {
            //loop.exec();
            if (!evloop.isRunning())
                evloop.exec();
        }

        return result_state;
    } else {
        return false;
    }

}

//- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
bool SQLquery::setpoint() {
//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {loop.exit();});
    qDebug() << "\n ~ SET SAVEPOINT A ~\n";

    setQuery("SAVEPOINT A");
    //loop.exec();
    if (!evloop.isRunning())
        evloop.exec();

    qDebug() << "\n ~ DONE ~\n";
    return result_state;
}

bool SQLquery::rollback() {
//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {loop.exit();});

    setQuery("ROLLBACK TO SAVEPOINT A");

    //loop.exec();
    if (!evloop.isRunning())
        evloop.exec();

    qDebug() << "rollback transaction";
    return result_state;
}

bool SQLquery::commit() {
//    QEventLoop loop;
//    AutoDisconnect(conn) = connect(this, &SQLquery::signalGetReady, [&loop]() {loop.exit();});

    qDebug() << "\n ~ COMMIT TRANSACTION ~\n";

    setQuery("COMMIT");
    //loop.exec();
    if (!evloop.isRunning())
        evloop.exec();

    qDebug() << "\n ~ DONE ~\n";
    return result_state;
}


