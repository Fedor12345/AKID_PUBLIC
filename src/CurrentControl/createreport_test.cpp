#include "createreport_test.h"

#include <QDateTime>



CreateReport_test::CreateReport_test(QObject *parent) : QObject(parent)
{

}

///////////////////////////////////////////////
///запуск скрипта создания отчета
void CreateReport_test::startScript(QString path)
{
    //system("taskkill /F /IM имя")
    QProcess p;
    qDebug() << "path = " << path;
    path = path + "/run_1.1.bat";   // path = path + "/report_test.bat";
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

void CreateReport_test::killProcess(QString task)
{
    QString comand = "taskkill /F /IM " + task;
    system(comand.toUtf8());
}

//void CreateReport_test::createReport(const int &id, const int &numberPerson){}

void CreateReport_test::createReport(const int &id)
{
    QString data_str;
    QString column_str;
    //QString querySQL = " SELECT * FROM PATIENT WHERE ID_PATIENT IN ("+QString::number(i_EMPLOYEE)+")"; //MESURING_2
//    QString querySQL = " SELECT * FROM EMPLOYEE WHERE ID_EMPLOYEE IN ("+QString::number(id)+")";

//    QString querySQL = " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC "
//                       " FROM TEK_PERSON WHERE ID_PERSON IN ("+QString::number(id)+") "; //FROM WORKERS

//    QString querySQL = " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC "
//                       " FROM EXT_PERSON WHERE ID_PERSON IN ("+QString::number(id)+") "; //FROM WORKERS

    //for (int i; i< numberPerson; i++) {}

//    QString querySQL = " SELECT SNILS, BIRTH_DATE, "
//                       " ADM_ASSIGNEMENT.ASSIGNEMENT_CODE, ADM_ASSIGNEMENT.ASSIGNEMENT,"
//                       " STATUS_CODE, SEX,"
//                       " OT_YEAR.BETA, OT_YEAR.GAMMA, OT_YEAR.NEUTRON, OT_YEAR.HP007, OT_YEAR.HP3, OT_YEAR.SICH " //, OT_YEAR.EFFECTIVE_DOSE
//                       " FROM EXT_PERSON "
//                       " LEFT JOIN ADM_ASSIGNEMENT ON EXT_PERSON.ID_ASSIGNEMENT = ADM_ASSIGNEMENT.ID_ASSIGNEMENT "
//                       " LEFT JOIN OT_YEAR ON OT_YEAR.ID_PERSON = EXT_PERSON.ID_PERSON "
//                       " WHERE EXT_PERSON.ID_PERSON IN ("+QString::number(id)+") "; //FROM WORKERS


    QString querySQL = " SELECT SNILS, BIRTH_DATE, "
                       " ADM_ASSIGNEMENT.ASSIGNEMENT_CODE, ADM_ASSIGNEMENT.ASSIGNEMENT,"
                       " STATUS_CODE, SEX,"
                       " OT_YEAR.BETA, "
                    // " OT_YEAR.GAMMA, "
                       " OT_YEAR.NEUTRON, OT_YEAR.HP007, OT_YEAR.HP3, OT_YEAR.SICH " //, OT_YEAR.EFFECTIVE_DOSE
                       " FROM EXT_PERSON "
                       " LEFT JOIN ADM_ASSIGNEMENT ON EXT_PERSON.ID_ASSIGNEMENT = ADM_ASSIGNEMENT.ID "
                       " LEFT JOIN OT_YEAR         ON OT_YEAR.ID_PERSON         = EXT_PERSON.ID_PERSON "
                       " WHERE EXT_PERSON.PERSON_NUMBER IN ("+QString::number(id)+") "; //FROM WORKERS

    QString querySQL2 =" Select SUM_DOSE FROM TABLE_DOZNARYAD "
                       " LEFT JOIN TABLE_BRIGADE_CON ON TABLE_BRIGADE_CON.ID_DOZNARYAD = TABLE_DOZNARYAD.ID "
                       " LEFT JOIN EXT_PERSON        ON EXT_PERSON.ID_PERSON           = TABLE_BRIGADE_CON.ID_WORKER"
                       " WHERE EXT_PERSON.PERSON_NUMBER IN ("+QString::number(id)+") ";





    QSqlDatabase db = QSqlDatabase::database("machine 0", false);
    QSqlQuery query(db);
    query.exec(querySQL2);
    double result = 0;
    while(query.next())//query->next(); first
    {
        result = result + query.value(0).toDouble();
        qDebug() << "доза = " << query.value(0).toDouble();
    }
    qDebug() << "сумма по всем дозам для выбранного сотрудника = " << result;

    QSqlQueryModel* model = new QSqlQueryModel();
    model->setQuery(querySQL,db);
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
