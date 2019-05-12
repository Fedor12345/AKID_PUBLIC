#include "waitdb_thread.h"

WaitDB_thread::WaitDB_thread(int numberOfDB)
{
    qDebug() << "WaitDB:            start";
    this->nDB = numberOfDB;
    this->fl_connectionStates = new bool[this->nDB];
    this->fl_connectionStates[0] = false;
    this->fl_connectionStates[1] = false;

    timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &WaitDB_thread::slotTimerAlarm);
    timer->setSingleShot(true);
    //timer->start(5000);
}

WaitDB_thread::~WaitDB_thread()
{

}


void WaitDB_thread::slotTimerAlarm() {
    qDebug() << "\nTIMER ALARM\n";
    this->loop.exit();
    timer->stop();
}

void WaitDB_thread::stopWaitTimer() {
    qDebug() << "\nTIMER STOP fl_connect ="<< this->fl_connect<<"\n";
    timer->stop();
    this->loop.exit();
}



void WaitDB_thread::waitTimer( unsigned int timer,unsigned int mc)
{
    /// timer     * mc    = время ожидания
    /// 10 циклов * 100мс = 1с ожидания
    unsigned int k = 0;
    while (k<timer)
    {
        QThread::msleep(mc); /// миллисекунды
        k++;
        //qDebug() << "k = " << k;
        if(this->fl_connect) { break; }
        //if(this->stopTimer)  { this->stopTimer = false; break; }
    }
    if (k<timer) {
        qDebug() << " - Ожидание было прерванно установившимся подключением к БД!| ~"<<k*mc<<"mc";
    }
    else {
        qDebug() << " - Ожидание подключения завершенно| ~"<<k*mc<<"mc";
    }
}


void WaitDB_thread::waitConnetionDB()
{
    //qDebug()<<"\n**********************************";
     qDebug() << " ->-> WaitDB: waitConnetionDB()  | thread = " << QThread::currentThreadId();

    this->fl_waitConnection = true;
    for ( int i=0; i<this->nDB; i++ ) {
        if(!this->fl_connectionStates[i]) {

            if(this->fl_connect) { //если произошло подключение, то остановить цикл
                qDebug() << "\n ->-> WaitDB:  ПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << " отменяется(!)| fl_connect = " << fl_connect;
                break;
            }
            qDebug() << "\n ->-> WaitDB: ПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << "| fl_connect = " << fl_connect;

            if(!this->fl_connect) {
                //qDebug()<<" ->-> WaitDB: signalConnectionNextDB(" << i << ") -> manager";
                emit signalBlockingGUI();
                emit signalConnectionNextDB(i);
            }

            /// запуск ожидания
            qDebug() << " ->-> WaitDB: run wait timer for the first connection ";
            //waitTimer(100, 50); /// 40циклов * 50мс = 2с ожидания
            timer->start(2000);
            this->loop.exec();
            qDebug() << " ->-> WaitDB: exit timer for the first connection ";
        }
    }
    /// если завершилось время ожидания всех БД и за это время подключение не было установленно, то высылается сообщение менеджеру
    if( !this->fl_connect ) {
        emit signalWaitEnd();
    }

    this->fl_waitConnection = false;
    emit signalUnlockingGUI(); /// послать сигнал GUI о разблокировке элементов
    //qDebug()<<"**********************************\n";

}

void WaitDB_thread::waitConnectionCurrentDB(int currentConnection)
{
    //qDebug()<<"\n**********************************";
    qDebug() << " ->-> WaitDB: waitConnectionCurrentDB()  | thread = " << QThread::currentThreadId();

    int i = 0;
    int checkConn = currentConnection;



    while (i<this->nDB) {
        if(!this->fl_connectionStates[checkConn]) {

            if(this->fl_connect) { //если произошло подключение, то остановить цикл
                qDebug() << "\n_ПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << " отменяется(!)| fl_connect = " << fl_connect;
                break;
            }


            qDebug() << "\n_ПОПЫТКА ПОДКЛЮЧЕНИЯ " << i << "| fl_connect = " << fl_connect;

            if(!this->fl_connect) {
                qDebug()<<"_(wait)signalConnectionNextDB(" << checkConn << ") -> manager";

                emit signalBlockingGUI(); /// послать сигнал GUI о блокировке элементов
                emit signalConnectionNextDB(checkConn);
            }

            /// запуск ожидания
            qDebug() << "! -> run wait timer <- !";
            //waitTimer(100, 50); /// 100циклов * 50мс = 5с ожидания
            timer->start(2000);
            this->loop.exec();
            qDebug() << "! -> exit timer <- !";

       }

//        i++;
//        if(checkConn == this->nDB-1) { checkConn=0; }
//                                else { checkConn++; }\

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


    //qDebug()<<"**********************************\n";

}



//void WaitDB_thread::connetionDB_TRUE()
//{
//    this->fl_connect = true;
//}

