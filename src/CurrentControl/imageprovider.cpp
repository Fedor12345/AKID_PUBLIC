#include "imageprovider.h"

#include <QDebug>

ImageProvider::ImageProvider(QObject *parent) : QQuickImageProvider(QQuickImageProvider::Pixmap)
{

}

QImage ImageProvider::requestImage(const QString &strId, QSize *ps, const QSize &)
{
//    QStringList lst = strId.split(";");
//    bool bOk = false;
//    int nBrightness = lst.last().toInt(&bOk);
//    QImage img = brightness(QImage(":/" + lst.first()), nBrightness);

//    if (ps) {
//        *ps = img.size();
//    }

//    return img;
}

QPixmap ImageProvider::requestPixmap(const QString &nameImage, QSize *size, const QSize &requestedSize)
{

//    int width = 100;
//    int height = 50;

//    if (size)
//       *size = QSize(width, height);


//    QPixmap pixmap(requestedSize.width() > 0 ? requestedSize.width() : width,
//                   requestedSize.height() > 0 ? requestedSize.height() : height);
//    pixmap.fill(QColor(nameImage).rgba());
//    qDebug() << " requestPixmap = " << pixmap;
//    return pixmap;



    QPixmap pixmap = QPixmap();
    pixmap.loadFromData( this->outByteArray_map[nameImage] );

    qDebug() << " requestPixmap = " << this->outByteArray_map[nameImage].size();

    return pixmap;
}

void ImageProvider::update()
{
    //requestPixmap();
}

void ImageProvider::setByteArray(const QByteArray &outByteArray, const QString &nameImage)
{
    qDebug() << "setByteArray!" << outByteArray.size();
    //this->pixmap = QPixmap();
    outByteArray_map[nameImage] = outByteArray;
    qDebug() << " this->outByteArray_map[nameImage] = " << this->outByteArray_map[nameImage].size() << this->outByteArray_map.size();
    QSize *size = nullptr;
    QSize requestedSize;
    requestPixmap(nameImage, size, requestedSize);
}


//QImage ImageProvider::brightness(const QImage &imgOrig, int n)
//{
//    QImage imgTemp = imgOrig;
//    return imgTemp;
//}
