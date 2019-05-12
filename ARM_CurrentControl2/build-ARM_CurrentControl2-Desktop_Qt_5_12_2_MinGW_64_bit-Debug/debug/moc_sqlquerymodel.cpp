/****************************************************************************
** Meta object code from reading C++ file 'sqlquerymodel.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../ARM_CurrentControl2/sqlquerymodel.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sqlquerymodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_SQLQueryModel_t {
    QByteArrayData data[14];
    char stringdata0[148];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_SQLQueryModel_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_SQLQueryModel_t qt_meta_stringdata_SQLQueryModel = {
    {
QT_MOC_LITERAL(0, 0, 13), // "SQLQueryModel"
QT_MOC_LITERAL(1, 14, 23), // "signalCheckConnectionDB"
QT_MOC_LITERAL(2, 38, 0), // ""
QT_MOC_LITERAL(3, 39, 16), // "signalUpdateDone"
QT_MOC_LITERAL(4, 56, 9), // "nameModel"
QT_MOC_LITERAL(5, 66, 11), // "updateModel"
QT_MOC_LITERAL(6, 78, 5), // "getId"
QT_MOC_LITERAL(7, 84, 3), // "row"
QT_MOC_LITERAL(8, 88, 3), // "get"
QT_MOC_LITERAL(9, 92, 10), // "setQueryDB"
QT_MOC_LITERAL(10, 103, 5), // "query"
QT_MOC_LITERAL(11, 109, 19), // "checkNameConnection"
QT_MOC_LITERAL(12, 129, 8), // "queryStr"
QT_MOC_LITERAL(13, 138, 9) // "printInfo"

    },
    "SQLQueryModel\0signalCheckConnectionDB\0"
    "\0signalUpdateDone\0nameModel\0updateModel\0"
    "getId\0row\0get\0setQueryDB\0query\0"
    "checkNameConnection\0queryStr\0printInfo"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_SQLQueryModel[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      10,   14, // methods
       1,   86, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   64,    2, 0x06 /* Public */,
       3,    1,   65,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    0,   68,    2, 0x0a /* Public */,
       5,    1,   69,    2, 0x0a /* Public */,
       6,    1,   72,    2, 0x0a /* Public */,
       8,    1,   75,    2, 0x0a /* Public */,
       9,    1,   78,    2, 0x0a /* Public */,
      11,    1,   81,    2, 0x0a /* Public */,
      12,    0,   84,    2, 0x0a /* Public */,
      13,    0,   85,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    4,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Int, QMetaType::Int,    7,
    QMetaType::QVariantMap, QMetaType::Int,    7,
    QMetaType::Bool, QMetaType::QString,   10,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::QString,
    QMetaType::Void,

 // properties: name, type, flags
      10, QMetaType::QString, 0x00495003,

 // properties: notify_signal_id
       1,

       0        // eod
};

void SQLQueryModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<SQLQueryModel *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signalCheckConnectionDB(); break;
        case 1: _t->signalUpdateDone((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 2: _t->updateModel(); break;
        case 3: _t->updateModel((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 4: { int _r = _t->getId((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = std::move(_r); }  break;
        case 5: { QVariantMap _r = _t->get((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariantMap*>(_a[0]) = std::move(_r); }  break;
        case 6: { bool _r = _t->setQueryDB((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = std::move(_r); }  break;
        case 7: _t->checkNameConnection((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 8: { QString _r = _t->queryStr();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 9: _t->printInfo(); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (SQLQueryModel::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SQLQueryModel::signalCheckConnectionDB)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (SQLQueryModel::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&SQLQueryModel::signalUpdateDone)) {
                *result = 1;
                return;
            }
        }
    }
#ifndef QT_NO_PROPERTIES
    else if (_c == QMetaObject::ReadProperty) {
        auto *_t = static_cast<SQLQueryModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = _t->queryStr(); break;
        default: break;
        }
    } else if (_c == QMetaObject::WriteProperty) {
        auto *_t = static_cast<SQLQueryModel *>(_o);
        Q_UNUSED(_t)
        void *_v = _a[0];
        switch (_id) {
        case 0: _t->setQueryDB(*reinterpret_cast< QString*>(_v)); break;
        default: break;
        }
    } else if (_c == QMetaObject::ResetProperty) {
    }
#endif // QT_NO_PROPERTIES
}

QT_INIT_METAOBJECT const QMetaObject SQLQueryModel::staticMetaObject = { {
    &QSqlQueryModel::staticMetaObject,
    qt_meta_stringdata_SQLQueryModel.data,
    qt_meta_data_SQLQueryModel,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *SQLQueryModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *SQLQueryModel::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_SQLQueryModel.stringdata0))
        return static_cast<void*>(this);
    return QSqlQueryModel::qt_metacast(_clname);
}

int SQLQueryModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QSqlQueryModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 10)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 10;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 10)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 10;
    }
#ifndef QT_NO_PROPERTIES
   else if (_c == QMetaObject::ReadProperty || _c == QMetaObject::WriteProperty
            || _c == QMetaObject::ResetProperty || _c == QMetaObject::RegisterPropertyMetaType) {
        qt_static_metacall(this, _c, _id, _a);
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 1;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 1;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void SQLQueryModel::signalCheckConnectionDB()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void SQLQueryModel::signalUpdateDone(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
