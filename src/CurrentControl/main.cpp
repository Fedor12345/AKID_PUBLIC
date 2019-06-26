#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QObject>
#include <QQmlContext>
#include <QDebug>
#include <QThread>


#include <../Libs/managerconnectdb.h>
#include <../Libs/sqlquery.h>
#include <../Libs/sqlquerymodel.h>
#include <createreport_test.h>
#include <createreport.h>

#include "cursorshapearea.h"


int main(int argc, char *argv[])
{
    qDebug() << "\n***************START*****************\n";

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    qmlRegisterType<CursorShapeArea>("MyTools", 1, 0, "CursorShapeArea");


    QQmlApplicationEngine engine;

    qDebug() << "main: Process_main id: " << QThread::currentThreadId() << "\n";
    ManagerConnectDB *managerDB = new ManagerConnectDB();
    //qDebug() << "Object 'managerDB' create";


    /// создается SQL запрос и связываетсся через сингалы и слоты с manager
    SQLquery *query1 = new SQLquery();

    QObject::connect(query1,    &SQLquery::signalCheckConnectionDB,
                     managerDB, &ManagerConnectDB::checkConnectionCurrentDB);

    QObject::connect(managerDB, &ManagerConnectDB::signalSendConnectionName,
                     query1,    &SQLquery::checkNameConnection);
    //qDebug() << "Object 'query1' create and connect with 'managerDB'";



    engine.rootContext()->setContextProperty("Query1", query1);
    engine.rootContext()->setContextProperty("managerDB", managerDB);

    engine.rootContext()->setContextProperty("workersModel", managerDB->createModel("","model_PERSON"));

//    engine.rootContext()->setContextProperty("adm_status_Model", managerDB->createModel("","adm_status"));
//    engine.rootContext()->setContextProperty("adm_organisation_org_Model", managerDB->createModel("","adm_organisation_org"));
//    engine.rootContext()->setContextProperty("adm_status_Model", managerDB->createModel("","adm_status"));
//    engine.rootContext()->setContextProperty("adm_status_Model", managerDB->createModel("","adm_status"));
//    engine.rootContext()->setContextProperty("adm_status_Model", managerDB->createModel("","adm_status"));


//(" SELECT STATUS_CODE, STATUS FROM ADM_STATUS ", "adm_status")
//(" SELECT ORGANIZATION_ FROM ADM_ORGANIZATION ", "adm_organisation_org")
//(" SELECT ID_ORGANIZATION, DEPARTMENT FROM ADM_ORGANIZATION WHERE ID = 1 ", "adm_organisation_dep")
//(" SELECT ID_DEPARTMENT_NPP,DEPARTMENT_NPP FROM ADM_DEPARTMENT_NPP ", "adm_department_nnp")


    //CreateReport_test *report = new CreateReport_test();
    CreateReport *report = new CreateReport();

//    /// соединение объекта "создание отчета" с объектом SQL запроса
//    QObject::connect(query1, &SQLquery::signalSendResult,
//                     report, &CreateReport::resultQueryOnly);

//    QObject::connect(report,  &CreateReport::signalSetQueryOnly,
//                     query1,  &SQLquery::setQueryWithName);

    engine.rootContext()->setContextProperty("report", report);


    /// внесены изменения для проверки ветки
    /// внесены еще изменения для проверки ветки

    qDebug() << "\nload qml:";
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;   

    return app.exec();
}
