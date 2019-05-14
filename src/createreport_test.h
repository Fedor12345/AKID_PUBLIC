#ifndef CREATEREPORT_TEST_H
#define CREATEREPORT_TEST_H

#include <QObject>

#include <QSqlDatabase>
#include <QSqlQueryModel>
#include <QSqlQuery>
#include <QSqlRecord>
#include <QSqlError>
#include <QtSql>

#include <QString>

#include <QDebug>


class CreateReport_test : public QObject
{
    Q_OBJECT
public:
    explicit CreateReport_test(QObject *parent = nullptr);
    //~CreateReport_test();
    //CreateReport_test();

private:
    void startScript(QString path);

signals:
    void sendToQml(QString str);

public slots:
    void createReport(const int &id);
    //void createReport(const int &id, const int &numberPersons);

};

#endif // CREATEREPORT_TEST_H
