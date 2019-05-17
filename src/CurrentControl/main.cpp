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


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qDebug() << "main: Process_main id: " << QThread::currentThreadId();
    ManagerConnectDB *managerDB = new ManagerConnectDB();



    /// создается SQL запрос и связываетсся через сингалы и слоты с manager
    SQLquery *query1 = new SQLquery();

    QObject::connect(query1,    &SQLquery::signalCheckConnectionDB,
                     managerDB, &ManagerConnectDB::checkConnectionCurrentDB);

    QObject::connect(managerDB, &ManagerConnectDB::signalSendConnectionName,
                     query1,    &SQLquery::checkNameConnection);



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


    CreateReport_test *report = new CreateReport_test();
    engine.rootContext()->setContextProperty("report", report);


    /// внесены изменения для проверки ветки
    /// внесены еще изменения для проверки ветки

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
