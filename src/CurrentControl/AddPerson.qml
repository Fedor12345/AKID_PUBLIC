import QtQuick 2.0
import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3
import QtQuick.Controls 2.5

//import QtQuick.Shapes 1.12

import QtQuick.Dialogs 1.2

Page {
    id: main_

    clip: true

    property var id_currentPerson: undefined

    //property var model_person
    //property var model_ext_person_list
    property var model_adm_status //:           stackview_mainwindow.model_adm_status
    property var model_adm_assignment //:       stackview_mainwindow.model_adm_assignment
    property var model_adm_organisation //:     stackview_mainwindow.model_adm_organisation
    property var model_adm_department_outer //: stackview_mainwindow.model_adm_department_outer
    property var model_adm_department_inner //: stackview_mainwindow.model_adm_department_inner

    signal signalUpdatePersonsList()


    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "q1__insertNewPerson") {
                if (res) {
                    signalUpdatePersonsList();
                }
            }
        }

    }

    AddWorker {
        anchors.fill: parent
        model_adm_status:           main_.model_adm_status
        model_adm_organisation:     main_.model_adm_organisation
        model_adm_department_outer: main_.model_adm_department_outer
        model_adm_department_inner: main_.model_adm_department_inner
        model_adm_assignment:       main_.model_adm_assignment


        onCreate_confirm: {
            //createNewPerson(data_record)
            console.log("createNewPerson: ");
            Query1.insertRecordIntoTable("q1__insertNewPerson" ,"EXT_PERSON", data_record)
        }
    }

}
