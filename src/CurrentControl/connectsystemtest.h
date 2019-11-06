#ifndef CONNECTSYSTEMTEST_H
#define CONNECTSYSTEMTEST_H

#include <QObject>
//#include <QSqlDatabase>

#include <QThread>
#include <QDebug>

class ConnectSystemTest : public QObject
{
    Q_OBJECT
public:
    explicit ConnectSystemTest(QObject *parent = nullptr);
    ~ConnectSystemTest();

    bool stop;

signals:
    //void signalQuery();
    void signalSetQuery(const QString &typeQuery, const int &nQuery, const int &numberIteration);


public slots:
    void setSequenceQueries(const QMap<QString, QVariant> &scripts, const int maxLenght);


};

#endif // CONNECTSYSTEMTEST_H
