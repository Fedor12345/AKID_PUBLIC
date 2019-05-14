#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QObject>
#include <QQmlContext>
#include <QDebug>
#include <QThread>


#include <managerconnectdb.h>
#include <sqlquery.h>
#include <sqlquerymodel.h>
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


    CreateReport_test *report = new CreateReport_test();
    engine.rootContext()->setContextProperty("report", report);


    /// внесены изменения для проверки ветки
    /// внесены еще изменения для проверки ветки

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
