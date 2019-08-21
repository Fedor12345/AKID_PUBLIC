#ifndef FILEMANAGER_H
#define FILEMANAGER_H

#include <QObject>

#include <QDebug>
#include <QByteArray>


class FileManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString pathFile            READ pathFile         WRITE setPathFile   NOTIFY signalSendPathFile)
    Q_PROPERTY(QByteArray qByteArray_file  READ qByteArray_file                      NOTIFY signalSendFileToQML)
    Q_PROPERTY(QString textFromFile        READ textFromFile                         NOTIFY signalSendTextFromFileToQML)
    Q_PROPERTY(int fileLenght              READ fileLenght                           NOTIFY signalSendfileLenghtToQML)

    //Q_PROPERTY(QByteArray qByteArray_file READ qByteArray_file WRITE loadFileToQML NOTIFY signalSendFileToQML)


private:
    /// загрузка файла в QByteArray по указанному адресу
    QByteArray loadFile(const QString &path);
    void loadFileToQML(const QString &path);
    void setFileLenght(const int &lenght);
    //QString loadTextFromFile(const QString &path);

    /// Q_PROPERTY
    QString _pathFile;
    QByteArray _qByteArray_file;
    QString _textFromFile;
    int _fileLenght;
    /// Q_PROPERTY

public:
    explicit FileManager(QObject *parent = nullptr);


     /// Q_PROPERTY
     QString pathFile();
     void setPathFile(const QString &path);

     QByteArray qByteArray_file();

     QString textFromFile();

     int fileLenght();
     /// Q_PROPERTY


signals:
    void signalSendImageToProvider(const QByteArray &outByteArray, const QString &nameImage);

    /// Q_PROPERTY
    void signalSendPathFile();
    void signalSendFileToQML();  // (QByteArray qByteArray);
    void signalSendTextFromFileToQML();
    void signalSendfileLenghtToQML();
    /// Q_PROPERTY


public slots:
    /// сохранение файла на диск
    void saveFile(const QByteArray &qByteArray_var, const QString &path, const QString &fileName, const QString &type);

    /// очистка побитового массива от данных из файла
    void deleteQByteArray_file(const QString &path);

    /// очистка строки с данными из файла
    void deleteTextFromFile(const QString &path);

    /// загрузка файла с ИЗОБРАЖЕНИЕМ в QByteArray по указанному адресу
    //void loadFileIMG(const QString &path);

    /// пересылка изображения в формате QByteArray в ImageProvider, чтобы QML мог отобразить картинку
    void loadByteArrayToImageProvider(const QByteArray &qByteArray, const QString &nameImage);

//    QByteArray qByteArray  (const QString &path) const;

    /// тесты
    void sendToCpp(QByteArray qByteArray_var);

};

#endif // FILEMANAGER_H
