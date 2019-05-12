#ifndef WAITDB_THREAD_H
#define WAITDB_THREAD_H

#include <QObject>
#include <QThread>
#include <QDebug>

#include <QTimer>
#include <QEventLoop>


class WaitDB_thread : public QObject
{
    Q_OBJECT
public:
    WaitDB_thread(int numberOfDB);
    ~WaitDB_thread();

//переменные и методы
public:
    bool fl_connect = false; /// (глобальная переменная) true - есть соединение (значение меняет поток с БД)
    bool *fl_connectionStates;
    bool fl_waitConnection = false;
    int nDB;   /// количество БД, к которым будут выполняться попытки подключений
    //bool dbIsCreate = false;

    bool stopTimer = false; /// останавливает таймер ожидания, когда true

private:
    void waitTimer(unsigned int timer, unsigned int mc);

    QTimer *timer;
    QEventLoop loop;

signals:
    void signalConnectionNextDB(int); //(QString, QString, QString, QString);
    void signalWaitEnd(); /// срабатывает если завершилось время ожидания всех БД
    //void signalConnectionStopDB();

    void signalBlockingGUI();
    void signalUnlockingGUI();

    //void signalConnectionDB();

public slots:
    void waitConnetionDB();
    void waitConnectionCurrentDB(int);

    void slotTimerAlarm();
    void stopWaitTimer();
};

#endif // WAITDB_THREAD_H
