#include "Cursorshapearea.h"

CursorShapeArea::CursorShapeArea(QQuickItem *parent) :  //: QObject(parent)
    QQuickItem(parent), m_currentShape(-1)
{

}

Qt::CursorShape CursorShapeArea::cursorShape() const
{
  return cursor().shape();
}


void CursorShapeArea::setCursorShape(Qt::CursorShape cursorShape)
{
    if (m_currentShape == (int) cursorShape)
        return;

    //QCursor cursor_1;
    setCursor(cursorShape);
    emit cursorShapeChanged();

    m_currentShape = cursorShape;
}
