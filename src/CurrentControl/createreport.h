#ifndef CREATEREPORT_H
#define CREATEREPORT_H

#include <QObject>

#include <QDateTime>

#include <QSqlDatabase>
#include <QSqlQueryModel>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlError>
#include <QtSql>

#include <QString>

#include <QDebug>



class CreateReport : public QObject
{
    Q_OBJECT
public:
    explicit CreateReport(QObject *parent = nullptr);

private:
    QString *Z = nullptr; /// данные идущие в сам отчет (Z1,Z2,..Z64)
    int lengthZ = 0;
    QVariant var_res;

    //void createBatFile(QString str);
    void killProcess(const QString &task);
    void resultQueryOnly(const QString& owner_name, const bool& res, const QVariant& var_res, const QString& messageError);

signals:
    void signalSetQueryOnly(const QString &owner_name, const QString &query); /// сигнал объекту SQL запроса
    void sendToQml(const QString &str);      /// сигнал в Qml интерфейс
    //void signalCreateBatScript(QString str);
    //void signalStartScript();   /// сигнал должен срабатывать после


public slots:
    void setTypeReport(int lengthZ);
    void setZ(const QMap<QString, QVariant> &mapZ);
    void clearZ();
    void showZ();
    void beginCreateReport();
    void beginCreateReport_AccumulatedDose();
    void beginCreateReport1DOZ();

    /// запуск скрипта генерации отчета происходит по сигналу signalStartScript()
    void startScript(QString path);


    void createReport_AccumulatedDose(const int &id, const QDateTime &data_begin, const QDateTime &data_end);
    /// метод вызывается сигналом от SQL запроса после его выполнения и принимает в параметрах рещультаты выполнения
    //void resultQueryOnly(const QString& owner_name, const bool& res, const QVariant& var_res, const QString& messageError);
};

#endif // CREATEREPORT_H
