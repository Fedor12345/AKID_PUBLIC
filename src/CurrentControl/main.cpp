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
#include "imageprovider.h"

#include "filemanager.h"
#include "ClipboardProxy.h"



int main(int argc, char *argv[])
{
    qDebug() << "\n***************START*****************\n";

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

//    app.setOrganizationName("Some Organization");
    app.setOrganizationDomain("someorganization.com");
//    app.setApplicationName("Application");

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

    //engine.rootContext()->setContextProperty("workersModel", managerDB->createModel("","m__model_PERSON"));

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

    engine.rootContext()->setContextProperty("report", report);


    /// Для предоставления ихображения из C++ в Qml создается объект класса ImageProvider,
    /// в который через сигнал от fileManager посылается побитовые данные фото (загруженные из БД))
    /// старый вариант: (в который через сигнал от query1 посылается побитовые данные фото (загруженные из БД))
    ImageProvider *imagePovider = new ImageProvider();

    /// Отрпаляем в qml объект файлового манаджера
    FileManager *fileManager = new FileManager();
    QObject::connect(fileManager,  &FileManager::signalSendImageToProvider,
                     imagePovider, &ImageProvider::setByteArray);

//    /// соединение объекта CreateReport с объектом FileManager
//    QObject::connect(report, &CreateReport::signalSendResult,
//                     report, &CreateReport::resultQueryOnly);

    engine.rootContext()->setContextProperty("FileManager", fileManager);
    engine.addImageProvider(QLatin1String("images"), imagePovider);


    /// Объект для буфера обмена
    engine.rootContext()->setContextProperty("clipboard",
    new ClipboardProxy(QGuiApplication::clipboard()));




    qDebug() << "\nload qml:";
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;   

    return app.exec();
}
