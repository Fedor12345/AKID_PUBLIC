#include "filemanager.h"

#include <QVariant>
#include <QMap>
#include <QDate>

#include <QCoreApplication>
#include <QFile>
#include <QPixmap>


FileManager::FileManager(QObject *parent) : QObject(parent)
{

}


//////////////////////////////////////////////////////////////////////////////////////////
/// Q_PROPERTY

QString FileManager::pathFile()
{
    return this->_pathFile;
}

QByteArray FileManager::qByteArray_file()
{
    return this->_qByteArray_file;
}



QString FileManager::textFromFile()
{
    this->_textFromFile = this->_qByteArray_file;
    return this->_textFromFile;
}

int FileManager::fileLenght()
{
    return this->_fileLenght;
}





void FileManager::setPathFile(const QString &path)
{
    this->_pathFile = path;
    loadFileToQML(path);

    emit signalSendPathFile();
}

/// Q_PROPERTY
//////////////////////////////////////////////////////////////////////////////////////////


void FileManager::deleteQByteArray_file(const QString &path)
{
    this->_qByteArray_file.clear();
    emit signalSendFileToQML();
}


void FileManager::deleteTextFromFile(const QString &path)
{
    this->_textFromFile.clear();
    emit signalSendfileLenghtToQML();
}

/// в параметр _fileLenght задается размер загруженного файла
void FileManager::setFileLenght(const int &lenght)
{
    this->_fileLenght = lenght;
}


/// загрузка файла в QByteArray по указанному адресу и отправка его в QML через сигнал
void FileManager::loadFileToQML(const QString &path)
{
    QByteArray inByteArray = loadFile(path);
    this->_qByteArray_file = inByteArray;
    this->setFileLenght(inByteArray.length());

    //emit signalSendFileToQML();  //emit signalSendFileToQML(inByteArray);


    qDebug() << " loadFileToQML: path: " << path;
    qDebug() << " file:" <<  this->_qByteArray_file.size() << "byte";
}

/// загрузка файла в QByteArray по указанному адресу
QByteArray FileManager::loadFile(const QString &path)
{
    QByteArray inByteArray;
    QString urlFile = path;
    if ( ~urlFile.indexOf("file:///") ) urlFile.remove("file:///");
    QFile file(urlFile);  /// QFile file("C:/Users/test/Desktop/1530661187194959677.jpg");

    if (!file.open(QIODevice::ReadOnly))  {
        qDebug() << "УКАЗАННЫЙ ФАЙЛ НЕ БЫЛ НАЙДЕН";
        inByteArray.clear();
        return inByteArray;
    }

    inByteArray = file.readAll();
    file.close();

    return inByteArray;

    /// тут кому-нибудь какой-нибудь сигнал с полученными двоичными данными inByteArray
    //emit signalSendByteArray(inByteArray);
}

///// загрузка данных в виде текста из файла
//QString FileManager::loadTextFromFile(const QString &path)
//{
//    QString urlFile = path;
//    if ( ~urlFile.indexOf("file:///") ) urlFile.remove("file:///");
//    QFile file(urlFile);  /// QFile file("C:/Users/test/Desktop/1530661187194959677.jpg");

//    if (!file.open(QIODevice::ReadOnly))  {
//        qDebug() << "УКАЗАННЫЙ ФАЙЛ НЕ БЫЛ НАЙДЕН";
//        //return false;
//    }

//    QString str = file.readAll();
//    file.close();

//    return str;
//}



/// пересылка изображения в формате QByteArray в ImageProvider, чтобы QML мог отобразить картинку
void FileManager::loadByteArrayToImageProvider(const QByteArray &qByteArray, const QString &nameImage)
{
    emit signalSendImageToProvider(qByteArray, nameImage);
}


/// сохранение файла на диск
void FileManager::saveFile(const QByteArray &qByteArray_var, const QString &path, const QString &fileName, const QString &type)
{
    /// открывается файл с заданным именем и типом
    QString nameFile = fileName + "." + type;
    if ( path != "" ) {
        nameFile = path + "/" + nameFile;
    }
    QFile file(nameFile);
    if ( !file.open(QIODevice::WriteOnly) )      //   | QIODevice::Text)
        return;


    /// работа с картинками
    if ( type == "jpg")  //  || type == "png"
    {
        QPixmap outPixmap = QPixmap();
        outPixmap.loadFromData( qByteArray_var );
        outPixmap.save( &file, "JPG" );
        //QString path = QCoreApplication::applicationDirPath();
    }
    /// работа с текстовым файлом
    else if ( type == "txt" )
    {
        QTextStream out(&file);
        out << qByteArray_var;
    }
    /// работа с произольным типом файла
    else
    {
        file.write(qByteArray_var);
    }

    file.close();
}





/////

void FileManager::sendToCpp(QByteArray qByteArray_var)
{
    qDebug() << " (!) size = " << qByteArray_var.size();
}




