#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H

#include <QObject>
#include <QImage>
#include <QQuickImageProvider>

class ImageProvider : public QObject, public QQuickImageProvider
{
    Q_OBJECT

private:
    //QByteArray outByteArray;
    //QVector<QByteArray> outByteArray_v;
    QMap<QString, QByteArray> outByteArray_map;
    //QPixmap pixmap;

    //QImage brightness(const QImage &imgOrig, int n);

public:
    explicit ImageProvider(QObject *parent = nullptr);
    //ImageProvider();
    QImage requestImage(const QString &, QSize *, const QSize &) override;
    QPixmap requestPixmap(const QString &nameImage, QSize *, const QSize &) override;



//public:
//    explicit ImageProvlder(QObject *parent = nullptr);

signals:

public slots:
    //void setImage(const QPixmap &outPixmap);
    void update();
    void setByteArray(const QByteArray &outByteArray, const QString &nameImage);

};

#endif // IMAGEPROVIDER_H
