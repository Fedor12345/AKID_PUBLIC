/****************************************************************************
** Meta object code from reading C++ file 'managerconnectdb.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.1)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../managerconnectdb.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'managerconnectdb.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.1. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_ManagerConnectDB_t {
    QByteArrayData data[29];
    char stringdata0[492];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_ManagerConnectDB_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_ManagerConnectDB_t qt_meta_stringdata_ManagerConnectDB = {
    {
QT_MOC_LITERAL(0, 0, 16), // "ManagerConnectDB"
QT_MOC_LITERAL(1, 17, 25), // "signalWaitAllConnectionDB"
QT_MOC_LITERAL(2, 43, 0), // ""
QT_MOC_LITERAL(3, 44, 29), // "signalWaitConnectionCurrentDB"
QT_MOC_LITERAL(4, 74, 19), // "signalConnectionDB0"
QT_MOC_LITERAL(5, 94, 19), // "signalConnectionDB1"
QT_MOC_LITERAL(6, 114, 17), // "signalBlockingGUI"
QT_MOC_LITERAL(7, 132, 18), // "signalUnlockingGUI"
QT_MOC_LITERAL(8, 151, 24), // "signalSendConnectionName"
QT_MOC_LITERAL(9, 176, 14), // "connectionName"
QT_MOC_LITERAL(10, 191, 20), // "signalSendGUI_status"
QT_MOC_LITERAL(11, 212, 7), // "message"
QT_MOC_LITERAL(12, 220, 21), // "currentConnectionName"
QT_MOC_LITERAL(13, 242, 6), // "status"
QT_MOC_LITERAL(14, 249, 16), // "signalSetQueryDB"
QT_MOC_LITERAL(15, 266, 21), // "signalSetQueryModelDB"
QT_MOC_LITERAL(16, 288, 20), // "checkAllConnectionDB"
QT_MOC_LITERAL(17, 309, 24), // "checkConnectionCurrentDB"
QT_MOC_LITERAL(18, 334, 12), // "connectionDB"
QT_MOC_LITERAL(19, 347, 17), // "connectionDB_TRUE"
QT_MOC_LITERAL(20, 365, 18), // "connectionDB_FALSE"
QT_MOC_LITERAL(21, 384, 18), // "connectionDB_BEGIN"
QT_MOC_LITERAL(22, 403, 17), // "connectionIsEmpty"
QT_MOC_LITERAL(23, 421, 10), // "setQueryDB"
QT_MOC_LITERAL(24, 432, 15), // "setQueryModelDb"
QT_MOC_LITERAL(25, 448, 11), // "setLoginPwd"
QT_MOC_LITERAL(26, 460, 11), // "createModel"
QT_MOC_LITERAL(27, 472, 9), // "str_query"
QT_MOC_LITERAL(28, 482, 9) // "nameModel"

    },
    "ManagerConnectDB\0signalWaitAllConnectionDB\0"
    "\0signalWaitConnectionCurrentDB\0"
    "signalConnectionDB0\0signalConnectionDB1\0"
    "signalBlockingGUI\0signalUnlockingGUI\0"
    "signalSendConnectionName\0connectionName\0"
    "signalSendGUI_status\0message\0"
    "currentConnectionName\0status\0"
    "signalSetQueryDB\0signalSetQueryModelDB\0"
    "checkAllConnectionDB\0checkConnectionCurrentDB\0"
    "connectionDB\0connectionDB_TRUE\0"
    "connectionDB_FALSE\0connectionDB_BEGIN\0"
    "connectionIsEmpty\0setQueryDB\0"
    "setQueryModelDb\0setLoginPwd\0createModel\0"
    "str_query\0nameModel"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_ManagerConnectDB[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
      21,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
      10,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,  119,    2, 0x06 /* Public */,
       3,    1,  120,    2, 0x06 /* Public */,
       4,    2,  123,    2, 0x06 /* Public */,
       5,    2,  128,    2, 0x06 /* Public */,
       6,    0,  133,    2, 0x06 /* Public */,
       7,    0,  134,    2, 0x06 /* Public */,
       8,    1,  135,    2, 0x06 /* Public */,
      10,    3,  138,    2, 0x06 /* Public */,
      14,    0,  145,    2, 0x06 /* Public */,
      15,    0,  146,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
      16,    0,  147,    2, 0x0a /* Public */,
      17,    0,  148,    2, 0x0a /* Public */,
      18,    1,  149,    2, 0x0a /* Public */,
      19,    1,  152,    2, 0x0a /* Public */,
      20,    1,  155,    2, 0x0a /* Public */,
      21,    1,  158,    2, 0x0a /* Public */,
      22,    0,  161,    2, 0x0a /* Public */,
      23,    0,  162,    2, 0x0a /* Public */,
      24,    0,  163,    2, 0x0a /* Public */,
      25,    2,  164,    2, 0x0a /* Public */,
      26,    2,  169,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    2,    2,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    2,    2,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    9,
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::Bool,   11,   12,   13,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString, QMetaType::QString,    2,    2,
    QMetaType::QObjectStar, QMetaType::QString, QMetaType::QString,   27,   28,

       0        // eod
};

void ManagerConnectDB::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<ManagerConnectDB *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signalWaitAllConnectionDB(); break;
        case 1: _t->signalWaitConnectionCurrentDB((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 2: _t->signalConnectionDB0((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 3: _t->signalConnectionDB1((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2]))); break;
        case 4: _t->signalBlockingGUI(); break;
        case 5: _t->signalUnlockingGUI(); break;
        case 6: _t->signalSendConnectionName((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 7: _t->signalSendGUI_status((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< bool(*)>(_a[3]))); break;
        case 8: _t->signalSetQueryDB(); break;
        case 9: _t->signalSetQueryModelDB(); break;
        case 10: _t->checkAllConnectionDB(); break;
        case 11: _t->checkConnectionCurrentDB(); break;
        case 12: _t->connectionDB((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 13: _t->connectionDB_TRUE((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 14: _t->connectionDB_FALSE((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 15: _t->connectionDB_BEGIN((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 16: _t->connectionIsEmpty(); break;
        case 17: _t->setQueryDB(); break;
        case 18: _t->setQueryModelDb(); break;
        case 19: _t->setLoginPwd((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2]))); break;
        case 20: { QObject* _r = _t->createModel((*reinterpret_cast< const QString(*)>(_a[1])),(*reinterpret_cast< const QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< QObject**>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (ManagerConnectDB::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalWaitAllConnectionDB)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalWaitConnectionCurrentDB)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)(QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalConnectionDB0)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)(QString , QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalConnectionDB1)) {
                *result = 3;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalBlockingGUI)) {
                *result = 4;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalUnlockingGUI)) {
                *result = 5;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)(QString );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalSendConnectionName)) {
                *result = 6;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)(QString , QString , bool );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalSendGUI_status)) {
                *result = 7;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalSetQueryDB)) {
                *result = 8;
                return;
            }
        }
        {
            using _t = void (ManagerConnectDB::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&ManagerConnectDB::signalSetQueryModelDB)) {
                *result = 9;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject ManagerConnectDB::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_ManagerConnectDB.data,
    qt_meta_data_ManagerConnectDB,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *ManagerConnectDB::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *ManagerConnectDB::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_ManagerConnectDB.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int ManagerConnectDB::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 21)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 21;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 21)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 21;
    }
    return _id;
}

// SIGNAL 0
void ManagerConnectDB::signalWaitAllConnectionDB()
{
    QMetaObject::activate(this, &staticMetaObject, 0, nullptr);
}

// SIGNAL 1
void ManagerConnectDB::signalWaitConnectionCurrentDB(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}

// SIGNAL 2
void ManagerConnectDB::signalConnectionDB0(QString _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
}

// SIGNAL 3
void ManagerConnectDB::signalConnectionDB1(QString _t1, QString _t2)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
}

// SIGNAL 4
void ManagerConnectDB::signalBlockingGUI()
{
    QMetaObject::activate(this, &staticMetaObject, 4, nullptr);
}

// SIGNAL 5
void ManagerConnectDB::signalUnlockingGUI()
{
    QMetaObject::activate(this, &staticMetaObject, 5, nullptr);
}

// SIGNAL 6
void ManagerConnectDB::signalSendConnectionName(QString _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 6, _a);
}

// SIGNAL 7
void ManagerConnectDB::signalSendGUI_status(QString _t1, QString _t2, bool _t3)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)), const_cast<void*>(reinterpret_cast<const void*>(&_t2)), const_cast<void*>(reinterpret_cast<const void*>(&_t3)) };
    QMetaObject::activate(this, &staticMetaObject, 7, _a);
}

// SIGNAL 8
void ManagerConnectDB::signalSetQueryDB()
{
    QMetaObject::activate(this, &staticMetaObject, 8, nullptr);
}

// SIGNAL 9
void ManagerConnectDB::signalSetQueryModelDB()
{
    QMetaObject::activate(this, &staticMetaObject, 9, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
