QT += quick
CONFIG += c++11
QT     += sql

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

DESTDIR =      $${PWD}/../bin

OBJECTS_DIR =  $${DESTDIR}/obj
MOC_DIR =      $${DESTDIR}/moc
UI_DIR =       $${DESTDIR}/ui
RCC_DIR =      $${DESTDIR}/rcc

TARGET = ARM_CurrentControl2
TEMPLATE = app
CODECFORTR = UTF-8

INCLUDEPATH += ../Libs/


SOURCES += \
        main.cpp \
    createreport_test.cpp \
    ../Libs/database.cpp \
    ../Libs/managerconnectdb.cpp \
    ../Libs/sqlquery.cpp \
    ../Libs/sqlquerymodel.cpp \
    ../Libs/waitdb_thread.cpp \
    ../Libs/cursorshapearea.cpp \
    createreport.cpp \
    imageprovider.cpp \
    filemanager.cpp \
    ClipboardProxy.cpp \
    connectsystemtest.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    createreport_test.h \
    ../Libs/database.h \
    ../Libs/managerconnectdb.h \
    ../Libs/sqlquery.h \
    ../Libs/sqlquerymodel.h \
    ../Libs/waitdb_thread.h \
    ../Libs/cursorshapearea.h \
    createreport.h \
    imageprovider.h \
    filemanager.h \
    ClipboardProxy.h \
    connectsystemtest.h


DISTFILES +=
