#ifndef CURSORSHAPEAREA_H
#define CURSORSHAPEAREA_H

//#include <QDeclarativeItem>
#include <QObject>
#include <QQuickItem>
#include <QCursor>

class CursorShapeArea : public QQuickItem  // QObject
{
    Q_OBJECT

    Q_PROPERTY(Qt::CursorShape cursorShape READ cursorShape WRITE setCursorShape NOTIFY cursorShapeChanged)


public:
    //explicit CursorShapeArea(QObject *parent = nullptr);

    explicit CursorShapeArea(QQuickItem *parent = 0);

      Qt::CursorShape cursorShape() const;
      Q_INVOKABLE void setCursorShape(Qt::CursorShape cursorShape);

public:
      int m_currentShape;


signals:
      void cursorShapeChanged();


public slots:
};

#endif // CURSORSHAPEAREA_H
