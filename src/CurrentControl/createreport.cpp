#include "createreport.h"

#include <QMap>
#include <QDate>
#include <QSqlRecord>


CreateReport::CreateReport(QObject *parent) : QObject(parent)
{

}

void CreateReport::startScript(QString path)
{
    //system("taskkill /F /IM имя")
    QProcess p;
    qDebug() << "path = " << path;
    path = path + "/report_2.bat";  //path + "/run_1.1.bat"  // path = path + "/report_test.bat";
    qDebug() << "path = " << path;
    p.startDetached("cmd.exe", QStringList() << "/c" << path);
    //p.startDetached("cmd.exe", QStringList() << "/c" << "taskkill /F /IM IM ARM_CurrentControl2.exe");
    if(p.waitForStarted())
    {
        p.waitForFinished();
        qDebug() << p.readAllStandardOutput();
    }
    else
        qDebug() << "Failed to start";
    // process.waitForStarted(-1);
    // process.waitForFinished(-1);
}

void CreateReport::killProcess(const QString &task)
{
    QString comand = "taskkill /F /IM " + task;
    system(comand.toUtf8());
}


/// работа с массивом данных Z

/// задать размер массива данных Z
void CreateReport::setTypeReport(int lengthZ)
{
    this->Z = new QString[lengthZ+1];
    this->lengthZ = lengthZ;
    this->Z[0] = "-";
}
/// заполнить данными массив Z
void CreateReport::setZ(const QMap<QString, QVariant> &mapZ)
{
    qDebug() << " mapZ = " << mapZ.values();
    QString key_;
    foreach (QString key, mapZ.keys()) {
        key_ = key;
        key_.remove("Z");
        qDebug() << " key_ = " << key_ << mapZ.values(key); //mapZ.value(key);
        this->Z[key_.toInt()] = mapZ.value(key).toString();
    }
}
/// отобразить содержимое массива Z
void CreateReport::showZ() {
    if (this->lengthZ <= 0) return;
    if (this->Z == nullptr) return;

    qDebug() << " --------- Z: --------- " << this->lengthZ;
    for ( int i = 0; i <= this->lengthZ; i++) {
        qDebug() << "Z" + QString::number(i) << " -- " << this->Z[i];
    }
    qDebug() << " ---------------------- ";
}

/// начало создания отчета
void CreateReport::beginCreateReport()
{
    /// разбор информации из нулевого элемента массива Z
    QString data0 = Z[0];
    QString str0 = "";
    QString sex = "";
    int age = 0;
    int deltaDate = 0;

    sex = data0.at(0);

    int i = 2;
    while(data0.at(i)!="|") {
        str0 = str0 + data0.at(i); //.toUpper().unicode()
        i++;
    }
    age = str0.toInt();
    str0 = data0.at(++i);
    deltaDate = str0.toInt();

    qDebug() << "createReport = " << sex << age << deltaDate;

    //QString::number(a);
    float a = 0;


    /// Z9 Z10 Z11
    this->Z[9] =QString().setNum( Z[21].toFloat() + Z[22].toFloat() + Z[23].toFloat() + Z[24].toFloat() );
    a = 50 - Z[9].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[10] = QString().setNum(a);
            Z[11] = "0";
        }
        else {
            Z[10] = "0";
            a = abs(a);
            Z[11] = QString().setNum(a);
        }
    }
    else {
        Z[10] = "-";
        Z[11] = "-";
    }
    a = 0;

    /// Z12 Z13 Z14
    this->Z[12] = this->Z[12] = QString().setNum( Z[25].toFloat() + Z[26].toFloat() + Z[27].toFloat() + Z[28].toFloat() + Z[29].toFloat() + Z[30].toFloat() );
    a = 150 - Z[12].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[13] = QString().setNum(a);
            Z[14] = "0";
        }
        else {
            Z[13] = "0";
            a = abs(a);
            Z[14] = QString().setNum(a);
        }
    }
    else {
        Z[13] = "-";
        Z[14] = "-";
    }
    a = 0;

    /// Z15 Z16 Z18
    this->Z[15] = QString().setNum( Z[31].toFloat() + Z[32].toFloat() + Z[33].toFloat() + Z[34].toFloat() + Z[35].toFloat() + Z[36].toFloat() );
    a = 500 - Z[15].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[16] = QString().setNum(a);
            Z[17] = "0";
        }
        else {
            Z[16] = "0";
            a = abs(a);
            Z[17] = QString().setNum(a);
        }
    }
    else {
        Z[16] = "-";
        Z[17] = "-";
    }
    a = 0;

    /// Z18 Z19 Z20
    this->Z[18] = QString().setNum( Z[37].toFloat() + Z[38].toFloat() + Z[39].toFloat() + Z[40].toFloat() + Z[41].toFloat() + Z[42].toFloat() );
    a = 1 - Z[18].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[19] = QString().setNum(a);
            Z[20] = "0";
        }
        else {
            Z[19] = "0";
            a = abs(a);
            Z[20] = QString().setNum(a);
        }
    }
    else {
        Z[19] = "-";
        Z[20] = "-";
    }
    a = 0;


    //////////////////////////////
    /// Z45
    Z[45] = QString().setNum( Z[43].toFloat() + Z[44].toFloat() );
    /// Z47
    Z[47] = Z[46];

    /// Z50 Z51 Z52
    Z[50] = QString().setNum( Z[48].toFloat() + Z[49].toFloat() );
    a = 300 - Z[50].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[51] = QString().setNum(a);
            Z[52] = "0";
        }
        else {
            Z[51] = "0";
            a = abs(a);
            Z[52] = QString().setNum(a);
        }
    }
    else {
        Z[51] = "-";
        Z[52] = "-";
    }
    a = 0;

    /// Z53
    Z[53] = Z[48];

    /// Z56 Z54 Z55
    Z[56] = QString().setNum( Z[53].toFloat() + Z[54].toFloat() + Z[55].toFloat() );
    a = 400 - Z[56].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[57] = QString().setNum(a);
            Z[58] = "0";
        }
        else {
            Z[57] = "0";
            a = abs(a);
            Z[58] = QString().setNum(a);
        }
    }
    else {
        Z[57] = "-";
        Z[58] = "-";
    }
    a = 0;


    /// Z60
    Z[60] = Z[55];

    /// Z61 Z62 Z63
    Z[61] = QString().setNum( Z[59].toFloat() + Z[60].toFloat() );
    a = 450 - Z[61].toFloat();
    if (deltaDate == 1 || deltaDate == 2) {
        if (a >= 0) {
            Z[62] = QString().setNum(a);
            Z[63] = "0";
        }
        else {
            Z[62] = "0";
            a = abs(a);
            Z[63] = QString().setNum(a);
        }
    }
    else {
        Z[62] = "-";
        Z[63] = "-";
    }
    a = 0;


    QString data_str = "";
    for ( int i = 1; i <= this->lengthZ; i++ ) {
        data_str = data_str + Z[i] + "; ";
    }
    qDebug() << "data_str ==" << data_str;


    QString path = qApp->applicationDirPath();

    QString nameFile = path + "/query_2.txt"; //"/report_test.txt";
    QFile file(nameFile);
    if (!file.open(QIODevice::WriteOnly)) {
        // error message0
        qDebug()<<"File " + nameFile + " not open";
    } else {
        qDebug()<<"File " + nameFile + " open";

        QTextStream stream(&file);
        stream.setCodec("UTF-8"); //"UTF-8")
        stream << trUtf8("\n");
        QString txt = data_str;
        //QString txt_h = column_str;
        //stream « tr(txt_h.toUtf8().data())«tr("\n");
//        stream << tr(txt.toUtf8().data());
        stream << trUtf8(txt.toUtf8().data());
        stream.flush();

        emit sendToQml(data_str);

        file.close();
    }

    killProcess("WINWORD.EXE");
    startScript(path); ///запускаем скрипт создания отчета




}







void CreateReport::createReport_AccumulatedDose(const int &id, const QDateTime &data_begin, const QDateTime &data_end) {
    Z = new QString[64];

    QString data_str;
    QString column_str;

    //QString data_begin_ = data_begin.toString();

//    QString string = data_begin.toString(); //"Tuesday, 23 April 12 22:51:41";
//    QString format = "d.MMMM.yy";
//    QString data_begin_inDB = QDateTime::fromString(string, format).toString();

    QString data_begin_inDB = data_begin.toString("dd.MM.yyyy");
    QString data_end_inDB   = data_end.toString("dd.MM.yyyy");

    QString querySQL_one = " SELECT * FROM EXT_DOSE WHERE "
                           " ID_PERSON IN (" + QString::number(id) + ") AND "
                           " BURN_DATE >= TO_DATE('" + data_begin_inDB + "','DD/MM/YY') ";
                           " BURN_DATE <= TO_DATE('" + data_end_inDB   + "','DD/MM/YY') ";

    querySQL_one         = " SELECT ID_PERSON, DATE_FROM, DATE_UNTIL FROM EXT_DOSE WHERE "
//                           " ID_PERSON IN (" + QString::number(id) + ") AND "
                           " BURN_DATE >= TO_DATE('" + data_begin_inDB + "','DD/MM/YY') ";
                           " BURN_DATE <= TO_DATE('" + data_end_inDB   + "','DD/MM/YY') ";


    //TO_DATE('23/04/49', 'DD/MM/YY')

    QString querySQL_model = "";

    //qDebug() << " querySQL_model = "  << data_begin << data_begin.date() << data_begin.toString("dd.MM.yyyy") <<  querySQL_model;
    signalSetQueryOnly("createReport", querySQL_one);




//    QSqlDatabase db0 = QSqlDatabase::database("machine 0", false);
//    QSqlQuery querySQL(db0);
//    QString str = "";

//    if(!querySQL.exec(querySQL_one)) {
//        str = "error: " + querySQL.lastError().text();
//    }
//    else
//    {
////        if(querySQL.first())//query->next();
////        {
////            str = querySQL.value(0).toString();
////        }
////        else {
////            str = "error: Нет такой записи";

////        }

//        QMap<QString, QVariant> result_data;    //набор данных
//        QSqlRecord rec;
//        while (querySQL.next()) {
//            rec = querySQL.record();
//            for (int i = 0; i < rec.count(); ++i) {
//                result_data.insert(rec.fieldName(i),querySQL.value(i));
//            }
//            foreach (QVariant value, result_data)
//                qDebug() << " --> " << value.value<QString>();
//        }

//        qDebug() << " -> " << str;


//    }



    return;





//    QString querySQL_model = " Select SUM_DOSE FROM TABLE_DOZNARYAD "
//                             " LEFT JOIN TABLE_BRIGADE_CON ON TABLE_BRIGADE_CON.ID_DOZNARYAD = TABLE_DOZNARYAD.ID "
//                       " LEFT JOIN EXT_PERSON        ON EXT_PERSON.ID_PERSON           = TABLE_BRIGADE_CON.ID_WORKER"
//                       " WHERE EXT_PERSON.PERSON_NUMBER IN ("+QString::number(id)+") ";


    QSqlDatabase db = QSqlDatabase::database("machine 0", false);
    QSqlQuery query(db);
    query.exec(querySQL_one);
    double result = 0;
    if(query.next())//query->next(); first
    {
        result = result + query.value(0).toDouble();
        qDebug() << "доза = " << query.value(0).toDouble();
    }
    qDebug() << "сумма по всем дозам для выбранного сотрудника = " << result;

    QSqlQueryModel* model = new QSqlQueryModel();
    model->setQuery(querySQL_model,db);
    if (model->lastError().isValid())
        qDebug() << model->lastError();

    int i_query = 0;
    for (int i = 0; i<12; i++) {
        if (i == 1) {
            QDate val = model->record(0).value(i).toDate();
            QString val2 = QString::number(val.day()) + "." + QString::number(val.month()) + "." + QString::number(val.year());
            data_str = data_str + val2 + "; ";
        }
        else if (i == 5) {
            QString val = model->record(0).value(i).toString();
            if ( val == "0") {
                data_str = data_str + "M; ";
            }
            else if( val == "1") {
                data_str = data_str + "Ж; ";
            }
        }
        else if (i == 7) {
            data_str = data_str + QString::number(result) + "; ";

        }

        else data_str = data_str + model->record(0).value(i).toString()+ "; ";


        //qDebug() << "data_str_i = " << data_str;

        column_str = column_str + model->headerData(i_query, Qt::Horizontal, 0).toString() + "; ";
        i_query++;
    }

    qDebug() << "column_str ==" << column_str;
    qDebug() << "data_str ==" << data_str;


    QString path = qApp->applicationDirPath();

    QString nameFile = path + "/query_1.1.txt"; //"/report_test.txt";
    QFile file(nameFile);
    if (!file.open(QIODevice::WriteOnly)) {
        // error message0
        qDebug()<<"File " + nameFile + " not open";
    } else {
        qDebug()<<"File " + nameFile + " open";

        QTextStream stream(&file);
        stream.setCodec("UTF-8"); //"UTF-8")
        stream << trUtf8("\n");
        QString txt = data_str;
        QString txt_h = column_str;
        //stream « tr(txt_h.toUtf8().data())«tr("\n");
//        stream << tr(txt.toUtf8().data());
        stream << trUtf8(txt.toUtf8().data());
        stream.flush();

        emit sendToQml(data_str);

        file.close();
    }

    killProcess("WINWORD.EXE");
    startScript(path); ///запускаем скрипт создания отчета


}


void CreateReport::resultQueryOnly(const QString &owner_name, const bool &res, const QVariant &var_res, const QString &messageError)
{
    this->var_res = var_res;
    //return var_res;
}
