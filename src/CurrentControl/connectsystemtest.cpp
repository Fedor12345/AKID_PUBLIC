#include "connectsystemtest.h"

ConnectSystemTest::ConnectSystemTest(QObject *parent) : QObject(parent)
{
    this->stop = false;
}

ConnectSystemTest::~ConnectSystemTest() {

    qDebug()<< " Удаление объекта ConnectSystemTest";
}

void ConnectSystemTest::setSequenceQueries(const QMap<QString, QVariant> &scripts, const int maxLenght)
{
    this->stop = false;
    qDebug() << " (t) scripts = " << scripts.values() << QThread::currentThreadId();
//    foreach (QString key, scripts.keys()) {
//        for ( int i = 0; i < scripts.value(key).toList().size(); i++) {
//            qDebug() << " (!) scripts = "  << scripts.value(key).toList().value(i).toString() << " | " << key;
//        }
//    }

    int size = scripts.size();
    //int *intervalTime_ = new int[size];
    unsigned long intervalTime[size];     /// набор интервалов времени
    QString queriesType[size];  /// набор типов запросов
    int nQueries[size];         /// набор числа запросов

    foreach (QString key, scripts.keys()) {
        intervalTime[key.toInt()] = scripts.value(key).toList().value(0).toInt();
        queriesType[key.toInt()]  = scripts.value(key).toList().value(1).toString();
        nQueries[key.toInt()]     = scripts.value(key).toList().value(2).toInt();

//        for ( int i = 0; i < scripts.value(key).toList().size(); i++) {
//            qDebug() << " (!) scripts = "  << scripts.value(key).toList().value(i).toString() << " | " << key;
//        }

    }


    int l = 0;

    while (!this->stop) {
        //QThread::msleep(1000);
        for ( int i = 0; i < size; i++) {
            if(this->stop) break;
            QThread::msleep(intervalTime[i]); //мс
            if(this->stop) break;
            /// если необходимо задавать число запросов за один скрипт то:
            /// emit signalSetQuery(queriesType[i],nQueries[i],l);
            emit signalSetQuery(queriesType[i],1,l);
        }

//        if(this->stop) break;
//        QThread::msleep(intervalTime[0]); //мс
//        if(this->stop) break;
//        emit signalSetQuery(queriesType[0],1,l);

        if(this->stop) break;
        qDebug() << " (t) test: " << l;
        l++;
        if ( maxLenght != 0 ) {
            if ( l >= maxLenght ) break;
        }


    }


}


