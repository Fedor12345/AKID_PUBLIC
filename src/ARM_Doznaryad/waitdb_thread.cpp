#include "waitdb_thread.h"

WaitDB_thread::WaitDB_thread(int numberOfDB) {
    qDebug() << "WaitDB:            start";
    this->nDB = numberOfDB;
    this->fl_connectionStates = new bool[this->nDB];
    this->fl_connectionStates[0] = false;
    this->fl_connectionStates[1] = false;

    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &WaitDB_thread::slotTimerAlarm);
    timer->setSingleShot(true);
}

WaitDB_thread::~WaitDB_thread() {

}

void WaitDB_thread::slotTimerAlarm() {
    qDebug() << "\nTIMER ALARM\n";
    if (loop.isRunning())
        loop.exit(0);
    //timer->stop();
}

void WaitDB_thread::stopWaitTimer() {
    qDebug() << "\nTIMER STOP fl_connect ="<< this->fl_connect<<"\n";
    timer->stop();
    if (loop.isRunning())
        loop.exit(0);
}

void WaitDB_thread::waitConnetionDB() {
//    qDebug()<<"\n**********************************";
//    qDebug() << "WaitDB_thread: Thread = " << QThread::currentThreadId();

    this->fl_waitConnection = true;
    //qDebug() << " --- 0. set TRUE!!!";
    for ( int i=0; i<this->nDB; i++ ) {
        if(!this->fl_connectionStates[i]) {

            if(this->fl_connect) { //если произошло подключение, то остановить цикл
                //qDebug() << "\nПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << " отменяется(!)| fl_connect = " << fl_connect;
                break;
            }
            //qDebug() << "\nПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << "| fl_connect = " << fl_connect;

            if(!this->fl_connect) {
                //qDebug()<<"(wait)signalConnectionNextDB(" << i << ") -> manager";
                emit signalBlockingGUI();
                emit signalConnectionNextDB(i);
            }

            /// запуск ожидания
            //qDebug() << "! -> run wait timer 0 <- !";
            if (!timer->isActive())
                timer->start(5000);  // 5 сек ожидания

            if (!loop.isRunning())
                loop.exec();
            //qDebug() << "! -> exit timer 0 <- !";
        }
    }
    /// если завершилось время ожидания всех БД и за это время подключение не было установленно, то высылается сообщение менеджеру
    if( !this->fl_connect ) {
        emit signalWaitEnd();
    }

    this->fl_waitConnection = false;
    //qDebug() << " --- 0. set FALSE!!!";
    emit signalUnlockingGUI(); /// послать сигнал GUI о разблокировке элементов
    //qDebug()<<"**********************************\n";
}

void WaitDB_thread::waitConnectionCurrentDB(int currentConnection) {
    //qDebug() << "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ WaitDB.waitConnectionCurrentDB [" << currentConnection << "] ~ ~ ~ ~ ~ ~ ~ ~ ~ ~";

    int i = 0;
    int checkConn = currentConnection;

    while (i<this->nDB) {
        if(!this->fl_connectionStates[checkConn]) {

            //qDebug() << "ПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << "| fl_connect = " << fl_connect;

            if(this->fl_connect) { //если произошло подключение, то остановить цикл
                //qDebug() << "    попытка подключения - BREAK!";
                break;
            } else {
                //qDebug()<<"-> WaitDB.signalConnectionNextDB(" << checkConn << ") to manager";

                /// запуск ожидания
                //qDebug() << "! -> run wait timer <- !";
                if (!timer->isActive()) {
                    qDebug() << "start waitConection timer";
                    timer->start(5000); // 5 сек ожидания
                }

                emit signalBlockingGUI(); /// послать сигнал GUI о блокировке элементов
                emit signalConnectionNextDB(checkConn);

                if (!loop.isRunning()) {
                    qDebug() << "run lop.exec()";
                    loop.exec();
                }
                qDebug() << "exit waitConnection timer";
            }
        }

        i++;
        if(checkConn == 1) {
            checkConn=0;
        } else {
            checkConn=1;
        }
    }

    /// если завершилось время ожидания всех БД и за это время подключение не было установленно, то высылается сообщение менеджеру
    if( !this->fl_connect ) {
        emit signalWaitEnd();
    }

    emit signalUnlockingGUI(); /// послать сигнал GUI о разблокировке элементов
}


