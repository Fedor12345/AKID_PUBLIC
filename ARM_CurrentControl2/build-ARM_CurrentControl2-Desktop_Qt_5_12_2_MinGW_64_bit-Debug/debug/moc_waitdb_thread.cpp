/****************************************************************************
** Meta object code from reading C++ file 'waitdb_thread.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.12.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../../ARM_CurrentControl2/waitdb_thread.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'waitdb_thread.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.12.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_WaitDB_thread_t {
    QByteArrayData data[8];
    char stringdata0[129];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_WaitDB_thread_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_WaitDB_thread_t qt_meta_stringdata_WaitDB_thread = {
    {
QT_MOC_LITERAL(0, 0, 13), // "WaitDB_thread"
QT_MOC_LITERAL(1, 14, 22), // "signalConnectionNextDB"
QT_MOC_LITERAL(2, 37, 0), // ""
QT_MOC_LITERAL(3, 38, 13), // "signalWaitEnd"
QT_MOC_LITERAL(4, 52, 17), // "signalBlockingGUI"
QT_MOC_LITERAL(5, 70, 18), // "signalUnlockingGUI"
QT_MOC_LITERAL(6, 89, 15), // "waitConnetionDB"
QT_MOC_LITERAL(7, 105, 23) // "waitConnectionCurrentDB"

    },
    "WaitDB_thread\0signalConnectionNextDB\0"
    "\0signalWaitEnd\0signalBlockingGUI\0"
    "signalUnlockingGUI\0waitConnetionDB\0"
    "waitConnectionCurrentDB"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_WaitDB_thread[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       4,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   44,    2, 0x06 /* Public */,
       3,    0,   47,    2, 0x06 /* Public */,
       4,    0,   48,    2, 0x06 /* Public */,
       5,    0,   49,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       6,    0,   50,    2, 0x0a /* Public */,
       7,    1,   51,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::Int,    2,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void, QMetaType::Int,    2,

       0        // eod
};

void WaitDB_thread::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<WaitDB_thread *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->signalConnectionNextDB((*reinterpret_cast< int(*)>(_a[1]))); break;
        case 1: _t->signalWaitEnd(); break;
        case 2: _t->signalBlockingGUI(); break;
        case 3: _t->signalUnlockingGUI(); break;
        case 4: _t->waitConnetionDB(); break;
        case 5: _t->waitConnectionCurrentDB((*reinterpret_cast< int(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        {
            using _t = void (WaitDB_thread::*)(int );
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&WaitDB_thread::signalConnectionNextDB)) {
                *result = 0;
                return;
            }
        }
        {
            using _t = void (WaitDB_thread::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&WaitDB_thread::signalWaitEnd)) {
                *result = 1;
                return;
            }
        }
        {
            using _t = void (WaitDB_thread::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&WaitDB_thread::signalBlockingGUI)) {
                *result = 2;
                return;
            }
        }
        {
            using _t = void (WaitDB_thread::*)();
            if (*reinterpret_cast<_t *>(_a[1]) == static_cast<_t>(&WaitDB_thread::signalUnlockingGUI)) {
                *result = 3;
                return;
            }
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject WaitDB_thread::staticMetaObject = { {
    &QObject::staticMetaObject,
    qt_meta_stringdata_WaitDB_thread.data,
    qt_meta_data_WaitDB_thread,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *WaitDB_thread::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *WaitDB_thread::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_WaitDB_thread.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int WaitDB_thread::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void WaitDB_thread::signalConnectionNextDB(int _t1)
{
    void *_a[] = { nullptr, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void WaitDB_thread::signalWaitEnd()
{
    QMetaObject::activate(this, &staticMetaObject, 1, nullptr);
}

// SIGNAL 2
void WaitDB_thread::signalBlockingGUI()
{
    QMetaObject::activate(this, &staticMetaObject, 2, nullptr);
}

// SIGNAL 3
void WaitDB_thread::signalUnlockingGUI()
{
    QMetaObject::activate(this, &staticMetaObject, 3, nullptr);
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE
