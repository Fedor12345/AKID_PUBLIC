#include "createreport_test.h"

CreateReport_test::CreateReport_test(QObject *parent) : QObject(parent)
{

}

///////////////////////////////////////////////
///запуск скрипта создания отчета
void CreateReport_test::startScript(QString path)
{
    QProcess p;
    qDebug() << "path = " << path;
    path = path + "/report_test.bat";
    qDebug() << "path = " << path;
    p.startDetached("cmd.exe", QStringList() << "/c" << path);
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

    QString querySQL = " SELECT SNILS, BIRTH_DATE, SEX, "
                       " ADM_ASSIGNEMENT.ASSIGNEMENT_CODE, ADM_ASSIGNEMENT.ASSIGNEMENT,"
                       " STATUS_CODE,"
                       " OT_YEAR.BETA, OT_YEAR.GAMMA, OT_YEAR.NEUTRON, OT_YEAR.HP007, OT_YEAR.HP3, OT_YEAR.SICH " //, OT_YEAR.EFFECTIVE_DOSE
                       " FROM EXT_PERSON "
                       " LEFT JOIN ADM_ASSIGNEMENT ON EXT_PERSON.ID_ASSIGNEMENT = ADM_ASSIGNEMENT.ID_ASSIGNEMENT "
                       " LEFT JOIN OT_YEAR ON OT_YEAR.ID_PERSON = EXT_PERSON.ID_PERSON "
                       " WHERE EXT_PERSON.ID_PERSON IN ("+QString::number(id)+") "; //FROM WORKERS


    QSqlDatabase db = QSqlDatabase::database("name0", false);
    QSqlQuery query(db);
    QSqlQueryModel* model = new QSqlQueryModel();
    model->setQuery(querySQL,db);
    if (model->lastError().isValid())
        qDebug() << model->lastError();

    int i_query = 0;
    for (int i = 0; i<12; i++) {
    //while (model->record(0).value(i_query).toBool()) {
        //qDebug()«query->record(0).value(i_query).toBool();
        data_str = data_str + model->record(0).value(i).toString()+ "; ";
        qDebug() << "data_str_i = " << data_str;
//        if(i_query==1 || i_query==2) {
//            data_str = data_str + " ";
//        }
//        else if(i_query == 3) {
//            data_str = data_str + "; ";
//        }
//        else {
//            data_str = data_str + "; ";
//        }
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
        stream.setCodec("UTF-8");
        stream << tr("\n");
        QString txt = data_str;
        QString txt_h = column_str;
        //stream « tr(txt_h.toUtf8().data())«tr("\n");
        stream << tr(txt.toUtf8().data());
        stream.flush();

        emit sendToQml(data_str);

        file.close();
    }

    startScript(path); ///запускаем скрипт создания отчета


}
