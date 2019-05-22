#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "mysqlquery.h"
#include <sqlquerymodel.h>
#include <managerconnectdb.h>

int main(int argc, char *argv[]) {

    //qmlRegisterType<SqlQueryModel>("Foo", 1, 0, "SqlQueryModel");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Подключение к БД, добавление записей, удаление записей
    ManagerConnectDB * managerDB = new ManagerConnectDB();
    engine.rootContext()->setContextProperty("managerDB", managerDB);
    engine.rootContext()->setContextProperty("dozModel", managerDB->createModel("", "model_doz1"));

    // Объявляем и инициализируем модель запрос
    SQLquery *query1 = new SQLquery("JQ1");
    SQLquery *query2 = new SQLquery("JQ2");

    QObject::connect(query1, &SQLquery::signalCheckConnectionDB, managerDB, &ManagerConnectDB::checkConnectionCurrentDB);
    QObject::connect(managerDB, &ManagerConnectDB::signalSendConnectionName, query1, &SQLquery::checkNameConnection);
    engine.rootContext()->setContextProperty("justquery", query1);

    QObject::connect(query2, &SQLquery::signalCheckConnectionDB, managerDB, &ManagerConnectDB::checkConnectionCurrentDB);
    QObject::connect(managerDB, &ManagerConnectDB::signalSendConnectionName, query2, &SQLquery::checkNameConnection);
    engine.rootContext()->setContextProperty("justquery2", query2);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
