#include "ClipboardProxy.h"

#include <QClipboard>

ClipboardProxy::ClipboardProxy(QClipboard* c) : clipboard(c)
{
    connect(c, &QClipboard::dataChanged, this, &ClipboardProxy::textChanged);
}

void ClipboardProxy::setDataText(const QString &text)
{
    clipboard->setText(text, QClipboard::Clipboard);
}

QString ClipboardProxy::text() const
{
    return clipboard->text();
}
