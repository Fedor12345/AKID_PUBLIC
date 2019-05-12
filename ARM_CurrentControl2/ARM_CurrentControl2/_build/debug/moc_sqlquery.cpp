/****************************************************************************
** Meta object code from reading C++ file 'sqlquery.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../sqlquery.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sqlquery.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_SQLquery_t {
    QByteArrayData data[18];
    char stringdata0[181];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_SQLquery_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_SQLquery_t qt_meta_stringdata_SQLquery = {
    {
QT_MOC_LITERAL(0, 0, 8), // "SQLquery"
QT_MOC_LITERAL(1, 9, 23), // "signalCheckConnectionDB"
QT_MOC_LITERAL(2, 33, 0), // ""
QT_MOC_LITERAL(3, 34, 16), // "signalSendResult"
QT_MOC_LITERAL(4, 51, 10), // "owner_name"
QT_MOC_LITERAL(5, 62, 3), // "res"
QT_MOC_LITERAL(6, 66, 7), // "var_res"
QT_MOC_LITERAL(7, 74, 8), // "setQuery"
QT_MOC_LITERAL(8, 83, 5), // "query"
QT_MOC_LITERAL(9, 89, 7), // "isGroup"
QT_MOC_LITERAL(10, 97, 12), // "clearQueries"
QT_MOC_LITERAL(11, 110, 19), // "checkNameConnection"
QT_MOC_LITERAL(12, 130, 8), // "getMaxID"
QT_MOC_LITERAL(13, 139, 5), // "tname"
QT_MOC_LITERAL(14, 145, 5), // "fname"
QT_MOC_LITERAL(15, 151, 3), // "val"
QT_MOC_LITERAL(16, 155, 21), // "insertRecordIntoTable"
QT_MOC_LITERAL(17, 177, 3) // "map"

    },
    "SQLquery\0signalCheckConnectionDB\0\0"
    "signalSendResult\0owner_name\0res\0var_res\0"
    "setQuery\0query\0isGroup\0clearQueries\0"
    "checkNameConnection\0getMaxID\0tname\0"
    "fname\0val\0insertRecordIntoTable\0map"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_SQLquery[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       8,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   54,    2, 0x06 /* Public */,
       3,    3,   55,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       7,    1,   62,    2, 0x0a /* Public */,
       7,    2,   65,    2, 0x0a /* Public */,
      10,    0,   70,    2, 0x0a /* Public */,
      11,    1,   71,    2, 0x0a /* Public */,
      12,    4,   74,    2, 0x0a /* Public */,
      16,    3,   83,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool, QMetaType::QVariant,    4,    5,    6,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    8,
    QMetaType::Void, QMetaType::QString, QMetaType::Bool,    8,    9,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QVariant,    4,   13,   14,   15,
    QMetaType::Bool, QMetaType::QString, QMetaType::QString, QMetaType::QVariantMap,    4,   13,   17,

       0        // eod
};

void SQLquery::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<SQLquery *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signalCheckConnectionDB(); break;
        case 1: _t->signalSendResult((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2])),(*reinterpret_cast< const QVariant(*)>(_a[3]))); break;
        case 2: _t->setQuery((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 3: _t->setQuery((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const bool(*)>(_a[2]))); break;
        case 4: _t->clearQueries(); break;
        case 5: _t->checkNameConnection((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 6: _t->getMaxID((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QString(*)>(_a[3])),(*reinterpret_cast< const QVariant(*)>(_a[4]))); break;
        case 7: { bool _r = _t->insertRecordIntoTable((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])),(*reinterpret_cast< const QMap<QString,QVariant>(*)>(_a[3])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (SQLquery::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SQLquery::signalCheckConnectionDB)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (SQLquery::*)(const QString & , const bool & , const QVariant & );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SQLquery::signalSendResult)) {
                *result = 1;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject SQLquery::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_SQLquery.data,
    qt_meta_data_SQLquery,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *SQLquery::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SQLquery::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_SQLquery.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int SQLquery::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 8)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 8;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 8)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 8;
    }
    return _id;
}

// SIGNAL 0
void SQLquery::signalCheckConnectionDB()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void SQLquery::signalSendResult(const QString & _t1, const bool & _t2, const QVariant & _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
