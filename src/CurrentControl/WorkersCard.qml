import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

Page {
    id: main_
    property int space_margin: 15

    property var model_adm_status //:           stackview_mainwindow.model_adm_status
    property var model_adm_assignment //:       stackview_mainwindow.model_adm_assignment
    property var model_adm_organisation //:     stackview_mainwindow.model_adm_organisation
    property var model_adm_department_outer //: stackview_mainwindow.model_adm_department_outer
    property var model_adm_department_inner //: stackview_mainwindow.model_adm_department_inner

    signal currentPersonChange(var id_currentPerson, var fio_currentPerson, var sex, var staff_type, var age)

    function workerModelQuery(id_person){
        workersModel.query = " SELECT
                               ID_PERSON, W_SURNAME, W_NAME, W_PATRONYMIC, PERSON_NUMBER,
                               SEX, BIRTH_DATE, DOSE_BEFORE_NPP,DOSE_CHNPP, IKU_YEAR, IKU_MONTH,
                               WEIGHT, HEIGHT, DATE_ON, DATE_OFF, EMERGENCY_DOSE,DISABLE_RADIATION,
                               ID_TLD, STAFF_TYPE,

                               PASSPORT_NUMBER, PASSPORT_GIVE,
                               PASSPORT_DATE, POLICY_NUMBER, SNILS,
                               HOME_ADDRESS, HOME_TEL,
                               WORK_TEL,MOBILE_TEL, WORK_ADDRESS, E_MAIL,

                               adm_status.STATUS,

                               ADM_ORGANIZATION.ORGANIZATION_,
                               ADM_DEPARTMENT_INNER.DEPARTMENT_INNER,
                               ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER,
                               ADM_ASSIGNEMENT.ASSIGNEMENT

                               FROM ext_person
                               LEFT JOIN adm_status           ON ext_person.STATUS_CODE         = adm_status.STATUS_CODE
                               LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID
                               LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID
                               LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID
                               LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID

                               WHERE ext_person.ID_PERSON = " + id_person;
    }



//    Component.onCompleted: {
//        workersModel.query = " SELECT
//                               ID_PERSON, W_SURNAME, W_NAME, W_PATRONYMIC, PERSON_NUMBER,
//                               SEX, BIRTH_DATE, DOSE_BEFORE_NPP,DOSE_CHNPP, IKU_YEAR, IKU_MONTH,
//                               WEIGHT, HEIGHT, DATE_ON, DATE_OFF, EMERGENCY_DOSE,DISABLE_RADIATION,
//                               ID_TLD, STAFF_TYPE,

//                               PASSPORT_NUMBER, PASSPORT_GIVE,
//                               PASSPORT_DATE, POLICY_NUMBER, SNILS,
//                               HOME_ADDRESS, HOME_TEL,
//                               WORK_TEL,MOBILE_TEL, WORK_ADDRESS, E_MAIL,

//                               adm_status.STATUS,

//                               ADM_ORGANIZATION.ORGANIZATION_,
//                               ADM_DEPARTMENT_INNER.DEPARTMENT_INNER,
//                               ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER,
//                               ADM_ASSIGNEMENT.ASSIGNEMENT

//                               FROM ext_person
//                               LEFT JOIN adm_status           ON ext_person.STATUS_CODE         = adm_status.STATUS_CODE
//                               LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID
//                               LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID
//                               LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID
//                               LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID

//                               WHERE ext_person.ID_PERSON = " + 1;

//    }



    Label {
        anchors.centerIn: parent
        text:"workerCard_&"
    }

    Item {
        id: modeles
        property var model_ext_person_list: managerDB.createModel(" SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD FROM EXT_PERSON ORDER BY W_SURNAME", "ext_person" )
    }

    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "WorkersCard") {
                if (res) {
                    modeles.model_ext_person_list.updateModel();
                }
            }

        }
    }


    Connections {
        target: workersModel
        onSignalUpdateDone: {
            if(nameModel=="model_PERSON")
            {
                if (workersModel.rowCount() > 0) {
                    // информация о работе
                    //doznarad_position.text = workersModel.get(0)["doznarad_position"]
                    txt_organization.text = workersModel.get(0)["ORGANIZATION_"]
                    if( workersModel.get(0)["STAFF_TYPE"]==="Командировачный" )
                    { txt_department.text   = workersModel.get(0)["DEPARTMENT_OUTER"] }
                    else if ( workersModel.get(0)["STAFF_TYPE"]==="Персонал АЭС" )
                    { txt_department.text   = workersModel.get(0)["DEPARTMENT_INNER"] }
                    txt_assignement.text  = workersModel.get(0)["ASSIGNEMENT"]


                    var str = "";

                    // персональная информация
                    txt_fio.text        = workersModel.get(0)["W_NAME"] + " " + workersModel.get(0)["W_SURNAME"] + " " + workersModel.get(0)["W_PATRONYMIC"]
                    txt_pn.text         = workersModel.get(0)["PERSON_NUMBER"]
                    txt_staff_type.text = workersModel.get(0)["STAFF_TYPE"]
                    txt_tld.text        = workersModel.get(0)["ID_TLD"]
                    txt_status.text     = workersModel.get(0)["STATUS"]

//                    txt_iku_month.text = workersModel.get(0)["IKU_MONTH"]
//                    txt_iku_year.text  = workersModel.get(0)["IKU_YEAR"]

//                    txt_dose_before_npp.text = workersModel.get(0)["DOSE_BEFORE_NPP"]
//                    txt_dose_chnpp.text      = workersModel.get(0)["DOSE_CHNPP"]

//                    str = workersModel.get(0)["DATE_ON"]
//                     var options = {
//                       year: 'numeric',
//                       month: 'long',
//                       day: 'numeric'
//                     };
//                     str.toLocaleString("ru", options)
//                    txt_date_on.text  = str.getDate() + "." + (str.getMonth()+1)  + "." + str.getFullYear()   //String(workersModel.get(0)["DATE_ON"]).substring(0,20)
//                    str = workersModel.get(0)["DATE_OFF"]
//                    txt_date_off.text = str.getDate() + "." + (str.getMonth()+1)  + "." + str.getFullYear()


                    if( workersModel.get(0)["EMERGENCY_DOSE"] === "1" ) {
                        txt_emergency_dose.is = true;
                    }
                    else if( workersModel.get(0)["EMERGENCY_DOSE"] === "0" )
                    {
                        txt_emergency_dose.is = false;
                    }

                    if(workersModel.get(0)["DISABLE_RADIATION"] === "1") {
                        nw_disable_radiation.is = true;
                    }
                    else if( workersModel.get(0)["DISABLE_RADIATION"] === "0" )
                    {
                        nw_disable_radiation.is = false;
                    }




                    //3
                    txt_gender.text   = (workersModel.get(0)["SEX"] === "M") ? "М" : "Ж"
                    str = workersModel.get(0)["BIRTH_DATE"]
                    txt_birthday.text = str.getDate() + "." + (str.getMonth()+1) + "." + str.getFullYear()
                    txt_weight.text   = workersModel.get(0)["WEIGHT"]
                    txt_height.text   = workersModel.get(0)["HEIGHT"]

                    //txt_pass_serial.text  = workersModel.get(0)["passport_series"]
                    txt_pass_number.text  = workersModel.get(0)["PASSPORT_NUMBER"]
                    txt_pass_whoget.text  = workersModel.get(0)["PASSPORT_GIVE"]
                     str = workersModel.get(0)["PASSPORT_DATE"]
                    ///ДАТА РАСКОМЕНТИРОВАТЬ txt_pass_dateget.text = str.getDate() + "." +(str.getMonth()+1)  + "." + str.getFullYear()

//                    txt_medical_number.text = workersModel.get(0)["POLICY_NUMBER"]
//                    txt_medical_series.text = workersModel.get(0)["SNILS"]

                    txt_snils.text = workersModel.get(0)["SNILS"]

                    txt_mobile_phone.text = workersModel.get(0)["MOBILE_TEL"]
                    txt_home_address.text = workersModel.get(0)["HOME_ADDRESS"]
                    txt_home_phone.text = workersModel.get(0)["HOME_TEL"]

                    txt_work_phone.text = workersModel.get(0)["WORK_TEL"]
                    txt_work_address.text = workersModel.get(0)["WORK_ADDRESS"]
                    txt_work_email.text = workersModel.get(0)["E_MAIL"]


                    /// генерируется сигнал о изменении выбранного сотрудника из спсика
                    var sex = (txt_gender.text === "М") ? "M" : "F"  /// txt_gender.text === "М", тут М на кириллице
                    var age = 25; /// ДОДЕЛАТЬ ОПРЕДЕЛЕНИЕ ВОЗРАСТА ВЫБРАННОГО СОТРУДНИКА
                    currentPersonChange(list_Persons.id_currentPerson, list_Persons.fio_currentPerson, sex, txt_staff_type.text, age)


                }

            }

        }

    }


    // добавление нового сотрудника в бд
    function createNewPerson(map_data) {
        console.log("createNewPerson: ");
        Query1.insertRecordIntoTable("WorkersCard" ,"EXT_PERSON", map_data) //wc_query.map_data

    }

    // обновление данных сотрудника в бд
    function updateOldPerson(map_data,id_person) {
        console.log("updateOldPerson: ",id_person);
        Query1.updateRecordIntoTable("WorkersCard" ,"EXT_PERSON", map_data, "ID_PERSON", id_person) //wc_query.map_data

    }

    Popup {
        id:popup_AddWorker
        width: addworker.width + padding*2
        height: addworker.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

//        Loader {
//            id:loaderAddWorker
//            sourceComponent: (popup_AddWorker.open()) ? redSquare : undefined//
//        }

//        Component {
//               id: redSquare
//               AddWorker {
//                   id: addworker
//                   onCreate_cancel: {
//                       popup_AddWorker.close();
//                       loaderAddWorker.sourceComponent = undefined;
//                   }
//                   onCreate_confirm: {
//                       popup_AddWorker.close()
//                       loaderAddWorker.sourceComponent = undefined;
//                       createNewPerson(data_record)
//                   }
//               }

//           }

        AddWorker {
            id: addworker
            model_adm_status:           main_.model_adm_status
            model_adm_organisation:     main_.model_adm_organisation
            model_adm_department_outer: main_.model_adm_department_outer
            model_adm_department_inner: main_.model_adm_department_inner
            model_adm_assignment:       main_.model_adm_assignment

            onCreate_cancel: {
                popup_AddWorker.close();
                //loaderAddWorker.sourceComponent = undefined;
            }
            onCreate_confirm: {
                popup_AddWorker.close()
                //loaderAddWorker.sourceComponent = undefined;
                createNewPerson(data_record)
            }
        }


    }



    Popup {
        id: popup_UpdateWorker
        width: updateWorker.width + padding*2
        height: updateWorker.height + padding*2

        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        UpdateWorker {
            id: updateWorker
            model_worker: workersModel
            model_adm_status:           main_.model_adm_status
            model_adm_organisation:     main_.model_adm_organisation
            model_adm_department_outer: main_.model_adm_department_outer
            model_adm_department_inner: main_.model_adm_department_inner
            model_adm_assignment:       main_.model_adm_assignment
            onUpdate_cancel: {
                popup_UpdateWorker.close();
            }
            onUpdate_confirm: {
                popup_UpdateWorker.close()
                updateOldPerson(data_record, id_person)
            }
        }


    }


/// группа основных элементов данных
Item {
    id: main_2
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.rightMargin: 260
    anchors.top: parent.top
    anchors.bottom: parent.bottom

    Frame {
        id:frame_wmenu

        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: space_margin
        padding: 1
        topPadding: 1
        bottomPadding: 1
        leftPadding: 10

        background: Rectangle {
            anchors.fill: parent
            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7
            //border.width: 1
        }


        Row {
            id: row
            spacing: 10
            ToolButton {
                text: "Новый сотрудник"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                onClicked: {
                    popup_AddWorker.open()
                }
            }
            ToolSeparator {}
            ToolButton {
                text: "Редактировать"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                onClicked: {
                    popup_UpdateWorker.open()
                    updateWorker.setDatePerson();
                    //popup_wait.open()
                }
            }
            ToolButton {
                text: "Снять с контроля"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                enabled: false
            }
            ToolSeparator {}
            ToolButton {
                text: "Удалить"
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 14
                flat: true
                enabled: false
            }
            ToolSeparator {}
        }

        MyFindField {
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 9
            ffwidth: 230
            ffheight: 30
            flg_f: true

            ffbackground: Rectangle {
                anchors.fill: parent
                radius: 5
                color: "White"
                border.color: "DarkGray"
            }

            onId_recChanged: {
                if (id_rec !== -1) {
                    //popup_wait.open()
                    console.log("-!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!--!->");
                    main_.workerModelQuery(id_rec)
//                    workersModel.query = " SELECT
//                                           ID_PERSON, W_SURNAME, W_NAME, W_PATRONYMIC, PERSON_NUMBER,
//                                           SEX, BIRTH_DATE, DOSE_BEFORE_NPP,DOSE_CHNPP, IKU_YEAR, IKU_MONTH,
//                                           WEIGHT, HEIGHT, DATE_ON, DATE_OFF, EMERGENCY_DOSE,DISABLE_RADIATION,
//                                           ID_TLD, STAFF_TYPE,

//                                           PASSPORT_NUMBER, PASSPORT_GIVE,
//                                           PASSPORT_DATE, POLICY_NUMBER, SNILS,
//                                           HOME_ADDRESS, HOME_TEL,
//                                           WORK_TEL,MOBILE_TEL, WORK_ADDRESS, E_MAIL,

//                                           adm_status.STATUS,

//                                           ADM_ORGANIZATION.ORGANIZATION_,
//                                           ADM_DEPARTMENT_INNER.DEPARTMENT_INNER,
//                                           ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER,
//                                           ADM_ASSIGNEMENT.ASSIGNEMENT

//                                           FROM ext_person
//                                           LEFT JOIN adm_status           ON ext_person.STATUS_CODE         = adm_status.STATUS_CODE
//                                           LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID
//                                           LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID
//                                           LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID
//                                           LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID

//                                           WHERE ext_person.ID_PERSON = " + id_rec;
                }
            }
        }



    }

    Frame {
        id: frame_who
        anchors.left: parent.left
        anchors.top: frame_wmenu.bottom
        anchors.margins: space_margin
        anchors.right: parent.right

        padding: 1
        topPadding: 1
        bottomPadding: 1

        height: 150 //implicitContentHeight
        //width: 670


        background: Rectangle {
            anchors.fill: parent
            color: "White" // "#eaeaea" //"#d6d6d6"//"White"
            border.color: "#9E9E9E" //"LightGray"
            //radius: 7
        }

        Item {
            anchors.fill: parent

            Column {
                anchors.fill: parent
                spacing: 0

                Row {
                    //id: row1
                    //Layout.fillWidth: true
                    //                anchors.left: parent.left
                    //                anchors.right: parent.right
                    spacing: 20
                    padding: 10

                    Rectangle {
                        width: 115
                        height: 130

                        //                    border.color: "Silver"
                        //                    color: Material.color(Material.BlueGrey, Material.Shade100)
                        border.color: "LightGray"
                        //color: "aliceblue"//"whitesmoke"
                        Image {
                            opacity: 0.2
                            sourceSize.height: 100
                            sourceSize.width: 100
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            source: "icons/face.svg"

                        }
                    }

                    Column {
                        spacing: 10
                        padding: 0
                        topPadding: 0
                        Text {
                            id: txt_fio
                            text: ".."
                            font.family: "Tahoma"
                            font.pixelSize: 28
                            color: Material.color(Material.DeepOrange) //"midnightblue"//"#333333"//"steelblue"
                        }
                        Row {
                            id: row1
                            //leftPadding: 10
                            Column {
                                //width: 110
                                spacing: 5
                                rightPadding: 10
                                Label {
                                    text: "Табельный №"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: "black"
                                }
                                Label {
                                    text: "№ ТЛД"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: "black"
                                }
                                Label {
                                    text: "Тип персонала"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: "black"
                                }
                                Label {
                                    text: "Статус"
                                    //anchors.right: parent.right
                                    font.pixelSize: 14
                                    color: "black"
                                }
                            }
                            Column {
                                width: 220
                                spacing: 5
                                Text {
                                    id: txt_pn
                                    text: ".."
                                    font.pixelSize: 14
                                    color: "darkslategrey"
                                }
                                Text {
                                    id: txt_tld
                                    text: ".."
                                    font.pixelSize: 14
                                    color: "darkslategrey"
                                }
                                Text {
                                    id: txt_staff_type
                                    text: ".."//"Основной персонал АЭС"
                                    font.pixelSize: 14
                                    color: "darkslategrey"
                                }
                                Text {
                                    id: txt_status
                                    text: ".."//"Работал весь отчетный год"
                                    font.pixelSize: 14
                                    color: "darkslategrey"
                                }
                            }


                        }
                    }

                }
            }

            Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 50
                anchors.verticalCenter: parent.verticalCenter
                width: 370
                height: 70
                border.color: "#9E9E9E" //"LightGray"
                radius: 4

                Item {
                    anchors.fill: parent
                    anchors.margins: 10

                    Item {
                        id: txt_emergency_dose
                        property bool is: false

                        anchors.left:   parent.left
                        anchors.right:  parent.right
                        anchors.top:    parent.top
                        anchors.bottom: parent.verticalCenter


                        Label {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Признак получения аварийной дозы"
                            font.pixelSize: 14
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 51
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (txt_emergency_dose.is) ? "Transparent" : "LightGray"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Нет")
                                font.pixelSize: 14
                                opacity: (txt_emergency_dose.is) ? 0.3 : 1.0
                                //font.bold: (txt_emergency_dose.is) ? false : true
                            }
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (txt_emergency_dose.is) ? "LightGray" : "Transparent"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Да")
                                font.pixelSize: 14
                                opacity: (txt_emergency_dose.is) ? 1.0 : 0.3
                                //font.bold: (txt_emergency_dose.is) ? true : false
                            }
                        }
                    }

                    Item {
                        id: nw_disable_radiation
                        property bool is: false

                        anchors.left:   parent.left
                        anchors.right:  parent.right
                        anchors.top:    parent.verticalCenter
                        anchors.bottom: parent.bottom

                        Label {
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Статус запрета с ИИИ"
                            font.pixelSize: 14
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            anchors.rightMargin: 51
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (nw_disable_radiation.is) ? "Transparent" : "LightGray"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Нет")
                                font.pixelSize: 14
                                opacity: (nw_disable_radiation.is) ? 0.3 : 1.0
                                //font.bold: (txt_emergency_dose.is) ? false : true
                            }
                        }
                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            height: parent.height
                            width: 50
                            color: "Transparent"
                            border.color: (nw_disable_radiation.is) ? "LightGray" : "Transparent"
                            Text {
                                anchors.centerIn: parent
                                text: qsTr("Да")
                                font.pixelSize: 14
                                opacity: (nw_disable_radiation.is) ? 1.0 : 0.3
                                //font.bold: (txt_emergency_dose.is) ? true : false
                            }
                        }
                    }




                }
            }
        }



    }


//    Frame {
//        id: frame_dose_summary
//        anchors.left: parent.left
//        anchors.top: frame_who.bottom
//        anchors.right: parent.right
//        anchors.margins: space_margin

//        padding: 1
//        topPadding: 10
//        bottomPadding: 10
//        leftPadding: 10

//        //height: 90
//        background: Rectangle {
//            anchors.fill: parent
//            color: "White"
//            border.color: "LightGray"
//            //radius: 7
//        }

//        Row {
//            Column {
//                width: 100
//                spacing: 5
//                rightPadding: 10
//                Label {
//                    text: "ИКУ (в год)"
//                    //anchors.right: parent.right
//                    font.pixelSize: 14
//                    color: "black"
//                }
//                Label {
//                    text: "ИКУ (в месяц)"
//                    //anchors.right: parent.right
//                    font.pixelSize: 14
//                    color: "black"
//                }

//            }
//            Column {
//                width: 100
//                spacing: 5
//                Row {
//                    spacing: 5
//                    TextEdit {
//                        id: txt_iku_year
//                        font.bold: true
//                        color: Material.color(Material.LightGreen)
//                        selectByMouse: true
//                        selectionColor: Material.color(Material.Red)
//                        text: ".."
//                        font.pixelSize: 15
//                    }
//                    Text {
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: qsTr("мЗв")
//                        font.pixelSize: 14
//                    }
//                }

//                Row {
//                    spacing: 5
//                    TextEdit {
//                        id: txt_iku_month
//                        font.bold: true
//                        color: Material.color(Material.LightGreen)
//                        selectByMouse: true
//                        selectionColor: Material.color(Material.Red)
//                        text: ".."
//                        font.pixelSize: 15
//                    }
//                    Text {
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: qsTr("мЗв")
//                        font.pixelSize: 14
//                    }
//                }
//            }

//            Column {
//                //anchors.bottom: parent.bottom
//                width: 180
//                spacing: 5
//                rightPadding: 10
//                Label {
//                    text: "Доза до АЭС"
//                    font.pixelSize: 14
//                    color: "black"
//                }
//                Label {
//                    text: "Доза, полученная на ЧАЭС"
//                    font.pixelSize: 14
//                    color: "black"
//                }
//            }
//            Column {
//                //anchors.bottom: parent.bottom
//                width: 100
//                spacing: 5
//                rightPadding: 10

//                Row {
//                    spacing: 5
//                    TextEdit {
//                        id: txt_dose_before_npp
//                        font.bold: true
//                        color: Material.color(Material.LightGreen)
//                        selectByMouse: true
//                        selectionColor: Material.color(Material.Red)
//                        text: ".."
//                        font.pixelSize: 15
//                    }
//                    Text {
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: qsTr("мЗв")
//                        font.pixelSize: 14
//                    }
//                }

//                Row {
//                    spacing: 5
//                    TextEdit {
//                        id: txt_dose_chnpp
//                        font.bold: true
//                        color: Material.color(Material.LightGreen)
//                        selectByMouse: true
//                        selectionColor: Material.color(Material.Red)
//                        text: ".."
//                        font.pixelSize: 15
//                    }
//                    Text {
//                        anchors.verticalCenter: parent.verticalCenter
//                        text: qsTr("мЗв")
//                        font.pixelSize: 14
//                    }
//                }


//            }


//            Column {
//                //anchors.bottom: parent.bottom
//                width: 170
//                spacing: 5
//                rightPadding: 10
//                Label {
//                    text: "Дата постановки на учет"// "Дата следущего котроля на СИЧ"
//                    //anchors.right: parent.right
//                    font.pixelSize: 14
//                    color: "black"
//                }
//                Label {
//                    text: "Дата снятия с учета" //"Тип следующего контроля на СИЧ"
//                    //anchors.right: parent.right
//                    font.pixelSize: 14
//                    color: "black"
//                }
//            }
//            Column {
//                //anchors.bottom: parent.bottom
//                //width: 230
//                spacing: 5
//                rightPadding: 10

//                TextEdit {
//                    id: txt_date_on
//                    font.bold: true
//                    color: Material.color(Material.LightGreen)
//                    selectByMouse: true
//                    selectionColor: Material.color(Material.Red)
//                    text: ".."
//                    font.pixelSize: 15
//                }
//                TextEdit {
//                    id: txt_date_off
//                    font.bold: true
//                    color: Material.color(Material.LightGreen)
//                    selectByMouse: true
//                    selectionColor: Material.color(Material.Red)
//                    text: ".."
//                    font.pixelSize: 15
//                }

//            }
//        }

//    }



    Frame {
        id: frame_tabbar
        anchors.left: parent.left
        anchors.top: frame_who.bottom  //frame_dose_summary.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: space_margin

        padding: 1
        topPadding: 1
        bottomPadding: 1

        background: Rectangle {
            anchors.fill: parent
            color: "White"
            border.color: "LightGray"
            //radius: 7
        }


        TabBar {
            id: tabbar_workerinfo
            width: parent.width
            currentIndex: 1
            font.pixelSize: 14
            background: Rectangle { color: "#eeeeee" }
            property int tbwidth: 300
            TabButton {
                text: "Информация о работе"
                width: implicitWidth
                //enabled: false



            }
            TabButton {
                text: "Персональная информация"
                width: implicitWidth

            }
            TabButton {
                text: "Информация по дозам"
                width: implicitWidth
                //enabled: false
            }
            TabButton {
                text: "Зоны контроля"
                width: implicitWidth
                enabled: false
            }
        }

        StackLayout {
            anchors.bottom: parent.bottom
            anchors.top: tabbar_workerinfo.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            currentIndex: tabbar_workerinfo.currentIndex

            Item {
                id: wtab1
                Pane {
                    id: wtab1_aboutwork
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: 60
                    padding: 5
                    //enabled: false
                    background: Rectangle {
                        anchors.fill: parent
                        color: "White"
                        border.color: "transparent"
                        //radius: 7
                    }
//                    Row {
//                        spacing: 5
//                        Label {
//                            text: "Дознаряд:"
//                        }
//                        Rectangle {
//                            width: 150
//                            height: 20
//                            color: Material.color(Material.Lime)
//                            Label {
//                                id: doznarad_position
//                                anchors.centerIn: parent
//                                font.bold: true
//                                color: Material.color(Material.Teal)
//                            }

//                        }
//                    }

                    Row {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        spacing: 20
                        Column {
                            spacing: 5
                            Label {
                                text: "Организация"
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_organization
                                font.pixelSize: 15
                                font.bold: true
                                color: Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                            }
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            height: 30
                            width: 1
                            color: "LightGray"
                        }

                        Column {
                            spacing: 5
                            Label {
                                text: "Подразделение"
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_department
                                font.bold: true
                                color: Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                                font.pixelSize: 15
                            }
                        }

                        Rectangle {
                            anchors.verticalCenter: parent.verticalCenter
                            height: 30
                            width: 1
                            color: "LightGray"
                        }

                        Column {
                            spacing: 5
                            Label {
                                text: "Должность"
                                font.pixelSize: 15
                            }
                            TextEdit {
                                id: txt_assignement
                                font.bold: true
                                color: Material.color(Material.Teal)
                                selectByMouse: true
                                selectionColor: Material.color(Material.Red)
                                text: "-----"
                                font.pixelSize: 15
                            }
                        }

                    }


                }




                Rectangle {
                    id: wtab1_tableheader
                    height: 30
                    anchors.top: wtab1_aboutwork.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    color: Material.color(Material.BlueGrey, Material.Shade100)
                    border.color: "LightGray"

                    Label {
                        text: "История работы"
                        anchors.verticalCenter: parent.verticalCenter
                        //anchors.right: parent.right
                        font.pixelSize: 16
                        color: "Black"
                        leftPadding: 10
                    }
                    Row {
                        anchors.right: parent.right
                        rightPadding: 10
                        spacing: 10
                        ToolButton {
                            text: "Добавить историю"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            flat: true
                            height: 30
                        }
                        ToolSeparator {height: 30}
                        ToolButton {
                            text: "Редактировать историю"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            flat: true
                            height: 30
                        }
                        ToolSeparator {height: 30}
                        ToolButton {
                            text: "Удалить"
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 12
                            flat: true
                            height: 30
                        }
                    }
                }

                Pane {
                    id:wtab1_history_work

                    anchors.top: wtab1_tableheader.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    padding: 0

                    TableView {
                        id: workers_table
                        anchors.fill: parent
                        columnSpacing: 1
                        rowSpacing: 1
                        clip: true

                        model: workersModel

//                        topMargin: header.implicitHeight
//                        Text {
//                            id: header
//                            text: "A table header"
//                        }


                        delegate: Rectangle {
                            implicitWidth: 100
                            implicitHeight: 50
                            Text {
                                //text: (heading==true) ? "Дата принятия на контроль"  : W_NAME
                            }
                        }
                    }

//                    MyTableView {
//                        id: workers_table
//                        anchors.fill: parent

//                        listview_header: ListModel {
//                            ListElement { name: "Принят на контроль"; width_val: 150;  trole: "" }
//                            ListElement { name: "Снят с контроля";    width_val: 150;  trole: ""}
//                            ListElement { name: "Место работы";       width_val: 350; trole: ""}
//                            ListElement { name: "Должность";          width_val: 250; trole: ""}
//                        }
//                    }
                }
            }

            Item {
                id: wtab2
                Pane {
                    id: wtab2_passport
                    anchors.fill: parent
                    padding: 5
                    property int sizeHeader: 14
                    property int sizeTxt: 14
                    property int heightAll: 60
                    property int widthAll: 400

                    background: Rectangle {
                        anchors.fill: parent
                        color: "White"
                        //border.color: "transparent"
                        //radius: 7
                    }
                    Column {
                        spacing: 20
                        Row {
                            spacing: 20
                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Личные данные"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Пол:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_gender
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Родился:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit  {
                                            id: txt_birthday
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Вес:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_weight
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            leftPadding: 10
                                            text: "Рост:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_height
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                    }
                                }
                            }

                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  480
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Паспортные данные"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                        //font.bold: true
                                    }

                                    Rectangle {
                                        height: 1
                                        width: 480
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Серия:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_pass_serial
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }

                                        Label {
                                            text: "Номер:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            leftPadding: 10
                                        }
                                        TextEdit {
                                            id: txt_pass_number
                                            font.pixelSize: wtab2_passport.sizeTxt
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                        Column {
                                            Row {
                                                spacing: 5
                                                Label {
                                                    text: "Выдан:"
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    leftPadding: 10
                                                }
                                                TextEdit {
                                                    id: txt_pass_whoget
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    font.bold: true
                                                    color: Material.color(Material.Teal)
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                            }

                                            Row {
                                                spacing: 5
                                                Label {
                                                    text: "Дата выдачи:"
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    leftPadding: 10
                                                }
                                                TextEdit {
                                                    id: txt_pass_dateget
                                                    font.pixelSize: wtab2_passport.sizeTxt
                                                    font.bold: true
                                                    color: Material.color(Material.Teal)
                                                    selectByMouse: true
                                                    selectionColor: Material.color(Material.Red)
                                                }
                                            }

                                        }


                                        }


                                }
                            }
                        }

                        Row {
                            spacing: 20
//                            Rectangle {
//                                height: wtab2_passport.heightAll
//                                width:  400
//                                //border.color: "LightGray"
//                                Column {
//                                    spacing: 5
//                                    Label {
//                                        text: "Данные медицинского полиса"
//                                        verticalAlignment: Text.AlignVCenter
//                                        height: 25
//                                        font.pixelSize: wtab2_passport.sizeHeader
//                                        color: "Black"
//                                        leftPadding: 10
//                                    }
//                                    Rectangle {
//                                        height: 1
//                                        width: 400
//                                        color: "LightGray"
//                                    }
//                                    Row {
//                                        leftPadding: 10
//                                        spacing: 5

//                                        Label {
//                                            text: "Номер:"
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                        }
//                                        TextEdit {
//                                            id: txt_medical_number
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                            font.bold: true
//                                            color: Material.color(Material.Teal)
//                                            selectByMouse: true
//                                            selectionColor: Material.color(Material.Red)
//                                        }

//                                        Label {
//                                            leftPadding: 10
//                                            text: "Серия:(снилс)"
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                        }
//                                        TextEdit  {
//                                            id: txt_medical_series
//                                            font.pixelSize: wtab2_passport.sizeTxt
//                                            font.bold: true
//                                            color: Material.color(Material.Teal)
//                                            selectByMouse: true
//                                            selectionColor: Material.color(Material.Red)
//                                        }

//                                    }
//                                }
//                            }

                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "СНИЛС"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }
                                    Row {
                                        leftPadding: 10
                                        spacing: 5

                                        Label {
                                            text: "Номер:"
                                            font.pixelSize: wtab2_passport.sizeTxt
                                        }
                                        TextEdit {
                                            id: txt_snils
                                            font.pixelSize: 14
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                        }
                                    }
                                }
                            }



                        }


                        Row {
                            spacing: 20
                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Дом"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }

                                    Column {
                                        spacing: 5
                                        Row {
                                            leftPadding: 10
                                            spacing: 5

                                            Label {
                                                text: "Дом. телефон:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                            }
                                            TextEdit {
                                                id: txt_home_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }

                                            Label {
                                                text: "Моб. телефон:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_mobile_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }

                                        Row {
                                            spacing: 5
                                            Label {
                                                text: "Адрес:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_home_address
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }
                                    }

                                }
                            }


                            Rectangle {
                                height: wtab2_passport.heightAll
                                width:  400
                                //border.color: "LightGray"
                                Column {
                                    spacing: 5
                                    Label {
                                        text: "Работа"
                                        verticalAlignment: Text.AlignVCenter
                                        height: 25
                                        font.pixelSize: wtab2_passport.sizeHeader
                                        color: "Black"
                                        leftPadding: 10
                                    }
                                    Rectangle {
                                        height: 1
                                        width: 400
                                        color: "LightGray"
                                    }

                                    Column {
                                        spacing: 5
                                        Row {
                                            leftPadding: 10
                                            spacing: 5

                                            Label {
                                                text: "Раб. телефон:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                            }
                                            TextEdit {
                                                id: txt_work_phone
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }

                                            Label {
                                                text: "Эл. почта:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_work_email
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }

                                        Row {
                                            spacing: 5
                                            Label {
                                                text: "Адрес:"
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                leftPadding: 10
                                            }
                                            TextEdit {
                                                id: txt_work_address
                                                font.pixelSize: wtab2_passport.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                            }
                                        }
                                    }
                                }
                            }
                        }

                    }



                }


            }

            Item {
                id: wtab3
                Pane {
                    id: wtab3_doze
                    anchors.fill: parent
                    padding: 5
                    property int sizeHeader: 14
                    property int sizeTxt: 14
                    property int heightAll: 60
                    property int widthAll: 400

                    background: Rectangle {
                        anchors.fill: parent
                        color: "White"
                        //border.color: "transparent"
                        //radius: 7
                    }
//                   Column {
//                       spacing: 20
//                       Row {
//                           spacing: 30
//                           Column {
//                               Text {
//                                   text: "Дата постановки на учет"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_date_on
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                           Column {
//                               Text {
//                                   text: "Дата снятия с учета"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_date_off
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                       }

//                       Rectangle {
//                           height: 1
//                           width: 400
//                           color: "LightGray"
//                       }

//                       Column {
//                           spacing: 20
//                           Row {
//                               spacing: 10
//                               Item {
//                                   height: parent.height
//                                   width: 180
//                                   Text {
//                                       text: "Доза до АЭС"
//                                       font.pixelSize: 14
//                                   }
//                               }

//                               TextEdit {
//                                   id: nw_dose_before_npp
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 16
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                               Text {
//                                   text: qsTr("мЗв")
//                                   font.pixelSize: 14
//                               }
//                           }
//                           Row {
//                               spacing: 10
//                               Item {
//                                   height: parent.height
//                                   width: 180
//                                   Text {
//                                       text: "Доза, полученная на ЧАЭС"
//                                       font.pixelSize: 14
//                                   }
//                               }
//                               TextEdit {
//                                   id: nw_dose_chnpp
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 16
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                               Text {
//                                   text: qsTr("мЗв")
//                                   font.pixelSize: 14
//                               }
//                           }
//                       }

//                       Rectangle {
//                           height: 1
//                           width: 400
//                           color: "LightGray"
//                       }

//                       Row {
//                           spacing: 30
//                           Column {
//                               Text {
//                                   text: "Годовой ИКУ, мЗв"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_iku_year
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                           Column {
//                               Text {
//                                   text: "Месячный ИКУ, мЗв"
//                                   font.pixelSize: 14
//                               }
//                               TextEdit {
//                                   id: nw_iku_month
//                                   font.bold: true
//                                   color: Material.color(Material.Teal)
//                                   selectByMouse: true
//                                   selectionColor: Material.color(Material.Red)
//                                   text: "---"
//                                   font.pixelSize: 15
//                                   //horizontalAlignment: Text.AlignHCenter
////                                   onTextEdited: {
////                                       if (text.length === 1) text = text.toUpperCase()
////                                   }
//                               }
//                           }
//                       }

//                       Rectangle {
//                           height: 1
//                           width: 400
//                           color: "LightGray"
//                       }




//                   }


                }

            }

            Item {
                id: wtab4
                Label {
                    text: "tab 4"
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }


}


/// Список всех сотрудников
Rectangle {
    id: allPersons
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 15
    width: 240

    color: "#f7f7f7"
    border.color: "LightGray"


    Rectangle {
        id: header_allPersons
        anchors.top: parent.topr
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        border.color: "LightGray"
        Text {
            anchors.centerIn: parent
            text: qsTr("Список сотрудников")
            font.pixelSize: 12
        }
    }
    Item {
        id: body_allPersons
        anchors.top: header_allPersons.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        ListView {
            id: list_Persons
            anchors.fill: parent
            anchors.margins: 5
            currentIndex: -1 //0
            property string id_currentPerson: modeles.model_ext_person_list.getFirstColumnInt(currentIndex)
            property string fio_currentPerson:
            {
                var str;
                str = modeles.model_ext_person_list.getCurrentDate(1,currentIndex) + " " +
                      modeles.model_ext_person_list.getCurrentDate(2,currentIndex) + " " +
                      modeles.model_ext_person_list.getCurrentDate(3,currentIndex);
                return str;
            }

//            onCurrentIndexChanged: {
//                stackview_mainwindow.id_currentPerson = modeles.model_ext_person_list.getFirstColumnInt(list_Persons.currentIndex)
//            }

//            Component.onCompleted: {
//                list_Persons.id_currentPerson = id_currentPerson //modeles.model_ext_person_list.getFirstColumnInt(list_Persons.currentIndex)
//                //timer_persons.restart()
//                //timer_persons0.restart()
//            }


            highlightFollowsCurrentItem: true
            model: modeles.model_ext_person_list
//                ListModel {
//                ListElement {
//                    name: "Name A"
//                    number: "1113264"
//                }
//                ListElement {
//                    name: "Name B"
//                    number: "4564564"
//                }
//                ListElement {
//                    name: "Name C"
//                    number: "4654564"
//                }
//            }

            ScrollBar.vertical: ScrollBar {
                policy: "AlwaysOn"
            }

            clip: true
            delegate:
                ItemDelegate {
                width: 210; height: 60
                Row {
                    spacing: 5
                    Rectangle {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 15
                        color: "transparent"
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.right: parent.right
                            //anchors.rightMargin: 5
                            text: index
                            font.pixelSize: 15
                            color: "#999999"
                        }
                    }

                    Rectangle {
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: 1
                        color: "Lightgray"
                    }
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 5
                    Column {
                        Text {
                            text: W_NAME + " " + W_SURNAME + " " + W_PATRONYMIC
                            font.pixelSize: 14
                            color: {
                             if (list_Persons.currentIndex == index) { "#FF5722" }
                             else { "#4c4c4c" }
                            }
                            //font.bold: true
                        }
                        Text {
                            text: "Таб. № " + PERSON_NUMBER
                            font.pixelSize: 10
                            color: "#777777"
                        }
                        Text {
                            text: "ТЛД № " + ID_TLD
                            font.pixelSize: 10
                            color: "#777777"
                        }
                    }

                }

                onClicked: {
                    if (list_Persons.currentIndex !== index) {
                        list_Persons.currentIndex = index
                    }
                    list_Persons.id_currentPerson = modeles.model_ext_person_list.getFirstColumnInt(index)
                    timer_persons.restart()
                }
            }

            highlight: Rectangle {
                color: "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                border.color: "#FF5722"
//                Image {
//                    id: idrop
//                    width: 24
//                    height: 24
//                    source: "icons/arrow-down-drop.svg"
//                    sourceSize.height: 24
//                    sourceSize.width: 24
//                    fillMode: Image.Stretch
//                    rotation: 90
//                    anchors.right: parent.right
//                    anchors.verticalCenter: parent.verticalCenter

//                }
            }
            highlightMoveDuration: 400
        }

        Timer {
            id: timer_persons0
            interval: 100
            repeat: false
            onTriggered: {
                list_Persons.id_currentPerson = modeles.model_ext_person_list.getFirstColumnInt(0);
            }
        }


        Timer {
            id: timer_persons
            interval: 410
            repeat: false
            onTriggered: {
                main_.workerModelQuery(list_Persons.id_currentPerson)
//                workersModel.query = " SELECT
//                                       ID_PERSON, W_SURNAME, W_NAME, W_PATRONYMIC, PERSON_NUMBER,
//                                       SEX, BIRTH_DATE, DOSE_BEFORE_NPP,DOSE_CHNPP, IKU_YEAR, IKU_MONTH,
//                                       WEIGHT, HEIGHT, DATE_ON, DATE_OFF, EMERGENCY_DOSE,DISABLE_RADIATION,
//                                       ID_TLD, STAFF_TYPE,

//                                       PASSPORT_NUMBER, PASSPORT_GIVE,
//                                       PASSPORT_DATE, POLICY_NUMBER, SNILS,
//                                       HOME_ADDRESS, HOME_TEL,
//                                       WORK_TEL,MOBILE_TEL, WORK_ADDRESS, E_MAIL,

//                                       adm_status.STATUS,

//                                       ADM_ORGANIZATION.ORGANIZATION_,
//                                       ADM_DEPARTMENT_INNER.DEPARTMENT_INNER,
//                                       ADM_DEPARTMENT_OUTER.DEPARTMENT_OUTER,
//                                       ADM_ASSIGNEMENT.ASSIGNEMENT

//                                       FROM ext_person
//                                       LEFT JOIN adm_status           ON ext_person.STATUS_CODE         = adm_status.STATUS_CODE
//                                       LEFT JOIN ADM_ORGANIZATION     ON ext_person.ID_ORGANIZATION     = ADM_ORGANIZATION.ID
//                                       LEFT JOIN ADM_DEPARTMENT_INNER ON ext_person.ID_DEPARTMENT_INNER = ADM_DEPARTMENT_INNER.ID
//                                       LEFT JOIN ADM_DEPARTMENT_OUTER ON ext_person.ID_DEPARTMENT_OUTER = ADM_DEPARTMENT_OUTER.ID
//                                       LEFT JOIN ADM_ASSIGNEMENT      ON ext_person.ID_ASSIGNEMENT      = ADM_ASSIGNEMENT.ID

//                                       WHERE ext_person.ID_PERSON = " + list_Persons.id_currentPerson;


             }
        }

    }



}


}
