#include "../Libs/sqlquery.h"
#include <QVariant>
#include <QMap>
#include <QDate>
#include <QVariant>

//#include <QMutex>

#include <QCoreApplication>

#include <QSqlRecord>

#include <QPixmap>
//#include <QByteArray>
//#include <QBuffer>
//#include <QScreen>

#include <QFile>


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
    this->byteValues.append(this->byteValues_tmp);
    this->numberQuery++;


    //this->type = "usual"; // если тип запроса usual, то он никак специально не обрабатывается
    this->byteValues_tmp.clear();

    clearqueriesGroup();

    //(at(this->iQuery)
    qDebug() << " -> SQLquery( " << this->sender_names.last() << " ): setQuery(): query: " << query;
    emit signalCheckConnectionDB(this->sender_names.last());   /// отправляем менеджеру сигнал начать попытки подключения
    /// this->sender_names.last() - имя запроса, добавленного в конец очереди
    //queryExecute();



}

/// перегрузка функции в случае, если вопросы необходимо выполнить в группе
void SQLquery::setQuery(const QString &query, const bool &isGroup)
{
    this->fl_setQuery = true;
    this->query = query;

    if(isGroup) { this->queriesGroup.append(query); this->isGroup = isGroup; }
    else        { clearqueriesGroup(); }

    emit signalCheckConnectionDB(this->sender_names.at(this->iQuery));   /// отправляем менеджеру сигнал начать попытки подключения
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



    /// !!!!!!!!! ПЕРЕПРОВЕРИТЬ !!!!!!!!!!!!!!!!!!

    /// НОВЫЙ АЛГОРИТМ:
    /// каждый запрос из списка будет запускаться с проверкой соединения
    /// Т.е. возникает цикл,
    /// где this->iQuery - счетчик, а условие выхода if(!this->fl_setQuery) { return; }

    query = this->queries.at(this->iQuery);

    if ( connectionName != "0" )
    {
        queryExecute(query);
    }
    else
    {
        emit signalSendResult(sender_name, false, NULL, "Соединение с БД отстутсвует");
        /// ВЫПОЛНЯТЬ В СЛУЧАЕ ЕСЛИ ИМЯ СОЕДИНЕНИЯ 0
    }

    ////////////////////////////////////////////////////////////
    if ( this->iQuery >= this->numberQuery ) {
        qDebug() << " (!)SQL последний запрос " << this->iQuery << " = " << this->numberQuery;
        this->queries.clear();
        this->sender_names.clear();
        this->byteValues.clear();
        this->numberQuery = -1;
        this->iQuery = 0;
        this->fl_setQuery = false;
    }
    else {
        this->iQuery++;
        qDebug() << " (!)SQL Очередь запросов: " << this->iQuery << " из " << this->numberQuery << " | " << this->sender_names.at(this->iQuery);
        emit signalCheckConnectionDB(this->sender_names.at(this->iQuery));   /// отправляем менеджеру сигнал начать попытки подключения
        for (int i=0;i<sender_names.length();i++){
            qDebug() << " (!)SQL Запросы: " <<this->sender_names.at(i);
        }

    }
    ////////////////////////////////////////////////////////////
    //this->fl_setQuery = false;
    //return;



//    if (this->iQuery < this->queries.length()-1) {
//        emit signalCheckConnectionDB(this->sender_names.at(this->iQuery));   /// отправляем менеджеру сигнал начать попытки подключения
//        return;
//    }

    /// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


    /// СТАРЫЙ АЛГОРИТМ:
    /// после проверки соединения в бд посылается сразу пачка sql запросов,
    /// т.е. каждый из них по отдельности не ожидает ответа от БД
//    for ( int i = 0; i < this->queries.length(); i++ )
//    {
//        this->iQuery = i;
//        query = this->queries.at(i);
////        qDebug() << " -> SQLquery: checkNameConnection: query: " << query;

//        if(connectionName != "0")
//        {
//            queryExecute(query);
//        }
//        else
//        {
//            emit signalSendResult(sender_name, false, NULL, "Соединение с БД отстутсвует");
//            /// ВЫПОЛНЯТЬ В СЛУЧАЕ ЕСЛИ ИМЯ СОЕДИНЕНИЯ 0
//        }
//    }


//    this->queries.clear();
//    this->sender_names.clear();
//    this->byteValues.clear();
//    this->numberQuery = -1;
//    this->iQuery = 0;

//    /// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//    /// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


//    this->fl_setQuery = false;

////    if(this->isNewName){
////        emit signalCheckConnectionDB(this->sender_names.at(this->iQuery));
////    }


}

void SQLquery::queryExecute(QString query)
{
    //qDebug() << "queryExecute";
    QSqlDatabase db = QSqlDatabase::database(this->connectionName, false);
    QSqlQuery querySQL(db);

    result_data.clear();
    QString sender_name_current = sender_names.at(this->iQuery);
    //QString type = this->types.at(this->iQuery);
    QString message = "";
    QVariant value;


    querySQL.prepare( query );

    /// Проверяем длинну массива this->byteValues,
    /// если больше нуля, то значит, что в строке запроса имеются не только текстовые данные
    /// и их необходимо вытащить из this->byteValues
    if (this->byteValues.size()>0) {
        QString str = ":byteValue_";
        //if (this->numberQuery <= this->byteValues.size()) { }
        for ( int i =  0 ; i < this->byteValues[this->iQuery].size() ; i ++ ) {
            querySQL.bindValue( str + QString::number(i), this->byteValues[this->iQuery][i], QSql::In | QSql::Binary  );
        }
    }

    if(!querySQL.exec()) //query
    {
        ///Ошибка при выполнении запроса
        QString str = this->connectionName + ": error: " + querySQL.lastError().text();
        qDebug() << " -> SQLquery(" << this->sender_names.at(this->iQuery) << " ): queryExecute:  "  << str << query;

        emit signalSendResult(this->sender_names.at(this->iQuery), false, NULL, querySQL.lastError().text());
    }
    else
    {
        qDebug() << " -> SQLquery(" << this->sender_names.at(this->iQuery) << " ): queryExecute:  "  << "Запрос прошел: " << query;

        int numberOfRecords = 0;

        query = query.toUpper();
        if(~query.indexOf("SELECT")) {           
            QSqlRecord rec;
            if (querySQL.first()) {                 
                rec = querySQL.record();
                /// Если полей много, то посылается объект result_data ( value = result_data ) класса QMap с множеством полей (столбцов)
                for (int i = 0; i < rec.count(); ++i) {
                    numberOfRecords++;

                    if ( querySQL.value(i).type() == QVariant::ByteArray) {
                        QByteArray outByteArray = querySQL.value(i).toByteArray();
                        if ( outByteArray.size() == 0) {
                            message = "Внимание! Тип данных - файл: пустой; размер = " + QString::number(outByteArray.size());
                        }
                        result_data.insert(rec.fieldName(i),outByteArray);
                    }
//                    else if (querySQL.value(i).type() == QVariant::Date) {

//                        result_data.insert(rec.fieldName(i),querySQL.value(i));
//                    }
                    else {
                        result_data.insert(rec.fieldName(i),querySQL.value(i));
                    }
                }
                value = result_data;
            }
            else {
                //emit signalSendResult(sender_name_current, true, NULL, "error: Нет такой записи");
                value = NULL;
                message ="error: Нет такой записи";
            }

            /// Если поле только одно (число столбцов в результате запроса),
            /// то посылается строка с результатом запроса
            if ( numberOfRecords <= 1 ) {
                querySQL.first();
                value = querySQL.value(0);

                //////////////////////////////////////////////////////////////
                if ( querySQL.value(0).type() == QVariant::ByteArray) {
                    qDebug() << " test image!: ";

                    QByteArray outByteArray = querySQL.value(0).toByteArray();
                    value = outByteArray;
                    if ( outByteArray.size() == 0) {
                        value = 0;
                        message = "Внимание! Тип данных - файл: пустой; размер = " + QString::number(outByteArray.size());
                    }

                    /*
                    qDebug() << " test image type: " << querySQL.value(0).type() << outByteArray.size();
                    emit signalSendImageToProvider(outByteArray, "photo_person");
                    value = "photo_person";
                    if ( outByteArray.size() == 0) {
                        value = 0;
                        message = "Внимание! Тип данных - файл: пустой; размер = " + QString::number(outByteArray.size());
                    }

                    ///сохранение полученного изображения на диск
                    QPixmap outPixmap = QPixmap();
                    outPixmap.loadFromData( outByteArray );

                    QFile file("photo_2.jpg");
                    file.open(QIODevice::WriteOnly);

                    outPixmap.save(&file, "JPG");
                    QString path = QCoreApplication::applicationDirPath() + "/photo_2.jpg" ;

//                    value = path;
                    */

                }
                //////////////////////////////////////////////////////////////
                //emit signalSendResult(sender_name_current, true, value, message);
            }


            /// ИТОГ:
            /// Если полей (столбцов) много:              value = result_data
            /// Если поле одно:                           value = querySQL.value(0);
            ///                                           value = 0 (если запись пуста)
            emit signalSendResult(sender_name_current, true, value, message);



            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            /// Если в результате запроса содержится несколько записей (т.е. строк), то необходимо дописать код: (ИЛИ НЕ НУЖНО, ПОТОМУ ЧТО ДЛЯ ЭТОГО ЕСТЬ МОДЕЛИ)
            /// в цикле (по rec.count) объект result_data добавлять в дополнительный массив,
            /// т.к result_data - это запись лишь одной строки

        }
        /// Если в SQL запросе не содержалось слова SELECT, то генерируется сигнал с положительным результатом выполнения и пустым значением в праметре результата
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


/// определеяет максимальное значение ID в таблице
///tname - имя таблицы
///fname - имя поля
///val - значение отбора
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

    qDebug() << " -> SQLquery( " << this->sender_names.at(this->iQuery) << " ): getMaxID(): query: " << tstr1;
    setQuery(tstr1);
}


//------------------------------------------------------------------------------------
////Метод для вставки записи в базу данных
bool SQLquery::insertRecordIntoTable(const QString& owner_name, const QString &tname, const QMap<QString, QVariant> &map) {
//    QSqlQuery query;

    //sender_name = owner_name;
    this->sender_name = owner_name;
    this->sender_names.append(owner_name);
//    if ( type != "img" || type != "file" ) {}
//    this->type = type;

    QString tstr1 = "INSERT INTO ", tstr2 = "VALUES (";
    tstr1 = tstr1 + tname + " (";

    int iByteValue = 0;
    bool isURL = false;
    QVector<QByteArray> byteValues_0;

    //подготовка запроса > INSERT INTO table ([field1], ...) VALUES (:param1, ...)
    foreach (QString key, map.keys()) {
        tstr1 = tstr1 + key + ",";

        if (map.value(key).type() == QVariant::DateTime) {
            tstr2 = tstr2 + "TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'),";
            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
        }
        /// Если в данных присутсвует двоичные данные, то заносим их в массив byteValues_tmp
        else if (map.value(key).type() == QVariant::ByteArray) {
            qDebug() << " в апросе присутствует QVariant::ByteArray ";
            QByteArray inByteArray = map.value(key).toByteArray();
            //byteValues_0.append(inByteArray);
            byteValues_tmp.append(inByteArray);
            QString str_byteValue = ":byteValue_" + QString::number(iByteValue) + ",";
            iByteValue++;

            tstr2 = tstr2 + str_byteValue;
            //qDebug() << "tstr2 = " << tstr2;
        }
        /// УДАЛИТЬ
        /// Если в данных обнаруживается одна или несолкьо URL ссылок, то в массив this->byteValues отправляюется массив (QVector)
        /// с побитовыми данными, выгруженные по данному адрессу
//        else if (map.value(key).type() == QVariant::Url) {
//            isURL = true;
//            qDebug() << "ЕСТЬ URL:" << map.value(key); // << map.value(key).toString();

//            QString urlFile = map.value(key).toString();
//            if ( ~urlFile.indexOf("file:///") ) urlFile.remove("file:///");
//            QFile file(urlFile);
//            //QFile file("C:/Users/test/Desktop/1530661187194959677.jpg");
//            if (!file.open(QIODevice::ReadOnly))  {
//                qDebug() << "УКАЗАННЫЙ ФАЙЛ (изображение) НЕ БЫЛ НАЙДЕН";
//                //return false;
//            }
//            QByteArray inByteArray = file.readAll();
//            byteValues_0.append(inByteArray);
//            //byteValues[this->numberQuery+1].append(inByteArray);
//            //byteValues[this->numberQuery+1][0] = inByteArray;
//            QString str_byteValue = ":byteValue_" + QString::number(iByteValue) + ",";
//            iByteValue++;
//            file.close();

//            tstr2 = tstr2 + str_byteValue;
//            qDebug() << "tstr2 = " << tstr2;
//        }


        else {
            tstr2 = tstr2 + "'" +  map.value(key).toString() + "',";
        }
    }

    //if (isURL) this->byteValues.append(byteValues_0);

    tstr1.remove (tstr1.length()-1, 1);
    tstr2.remove (tstr2.length()-1, 1);
    tstr1 = tstr1+") "+tstr2+")";

    qDebug() << " -> SQLquery( " << this->sender_names.at(this->iQuery) << " ): insertRecordIntoTable(): query: " << tstr1;

    setQuery(tstr1);

    return true;
}

bool SQLquery::updateRecordIntoTable(const QString &owner_name, const QString &tname, const QMap<QString, QVariant> &map, const QString &idWhere, const int &id)
{
    this->sender_name = owner_name;
    this->sender_names.append(owner_name);

    int iByteValue = 0;

    QString tstr = " UPDATE " + tname + " SET ";


    foreach (QString key, map.keys()) {
        tstr = tstr + key + " = ";
        if (map.value(key).type() == QVariant::DateTime) {
            tstr = tstr + " TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'), ";
            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
        }
        /// Если в данных присутсвует двоичные данные, то заносим их в массив byteValues_tmp
        else if (map.value(key).type() == QVariant::ByteArray) {
            qDebug() << " в апросе присутствует QVariant::ByteArray ";
            QByteArray inByteArray = map.value(key).toByteArray();
            //byteValues_0.append(inByteArray);
            byteValues_tmp.append(inByteArray);
            QString str_byteValue = ":byteValue_" + QString::number(iByteValue) + ",";
            iByteValue++;

            tstr = tstr + str_byteValue;
            //qDebug() << "tstr = " << tstr;
        }


        else {
            tstr = tstr + " '" +  map.value(key).toString() + "',";
        }
    }
    tstr = tstr.remove(tstr.length()-1,1);
    tstr = tstr + " WHERE " + idWhere + " = " + QString::number(id);

    qDebug() << " -> SQLquery( " << this->sender_names.at(this->iQuery) << " ): updateRecordIntoTable(): query: " << tstr;

    setQuery(tstr);

    return true;
}

//void SQLquery::insertImageIntoTable(const QString &owner_name, const QString &tname,const QString &Vname, const QString addressImg)
//{
//    this->sender_name = owner_name;
//    this->sender_names.append(owner_name);

//    QString tstr1 = "INSERT INTO " + tname + " (";
//    QString tstr2 = "VALUES (";


////    foreach (QString key, map.keys()) {
////        tstr1 = tstr1 + key + ",";
////        if (map.value(key).type() == QVariant::DateTime) {
////            tstr2 = tstr2 + "TO_DATE('"+ map.value(key).toDate().toString(Qt::ISODate) + "', 'YYYY-MM-DD'),";
////            //TO_DATE('2019-03-01 06:40:00', 'YYYY-MM-DD HH24:MI:SS')
////        } else {
////            tstr2 = tstr2 + "'" +  map.value(key).toString() + "',";
////        }
////    }
//    tstr1.remove (tstr1.length()-1, 1);
//    tstr2.remove (tstr2.length()-1, 1);
//    tstr1 = tstr1+") "+tstr2+")";

//    qDebug() << " -> SQLquery: insertRecordIntoTable(): query: " << tstr1;

//    setQuery(tstr1);


//}
