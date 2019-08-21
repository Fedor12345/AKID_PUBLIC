#ifndef CLIPBOARDPROXY_H
#define CLIPBOARDPROXY_H

#include <QObject>

class QClipboard;

class ClipboardProxy : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString text READ text WRITE setDataText NOTIFY textChanged)
public:
    explicit ClipboardProxy(QClipboard*);

    void setDataText(const QString &text);
    QString text() const;

signals:
    void textChanged();

private:
    QClipboard* clipboard;

public slots:
};

#endif // CLIPBOARDPROXY_H
