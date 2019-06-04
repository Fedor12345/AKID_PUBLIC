import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12

Item {
    //id: item3
    id: main_AddWorker
    height: 800//550
    width:  900//690

    //property bool isOk: true

    property var model_adm_status
    property var model_adm_organisation
    property var model_adm_department_outer
    property var model_adm_department_inner
    property var model_adm_assignment



    signal create_confirm(var data_record)
    signal create_cancel()

    function clearfields() {
        nw_name.text = ""
        nw_surname.text = ""
        nw_patronymic.text = ""

        nw_birthday.ready = false
        nw_gender.currentIndex = 0

        nw_weight.text = "0"
        nw_hieght.text = "0"

        nw_personalNumber.text = ""
        nw_tld.text = ""

//        nw_iku_year.text = "0,0"
//        nw_iku_month.text = "0,0"

        nw_pass_number.text = ""
        nw_pass_date.ready = false
        nw_passportGive.text = ""
        nw_SNILS.text = ""

        nw_homeTel.text = ""
        nw_mobileTel.text = ""
        nw_homeAdress.text = ""
        nw_eMail.text = ""
        nw_workTel.text = ""
        nw_workTel_2.text = ""
        nw_workAdress.text = ""
        nw_eMailWork.text = ""



        ///дозы
        nw_dose_before_npp.text = "0"
        nw_dose_chnpp.text = "0"
        nw_iku_year.text = "0"
        nw_iku_month.text = "0"
        nw_Au.text = "0"
        nw_Iu.text = "0"
        nw_emergency_dose.currentIndex = -1
        nw_disable_radiation.currentIndex = -1
    }


    Item {
        id: modeles

//        property var model_adm_status:           managerDB.createModel(" SELECT STATUS_CODE, STATUS  FROM ADM_STATUS ",                       "adm_status")
//        property var model_adm_organisation:     managerDB.createModel(" SELECT ID, ORGANIZATION_    FROM ADM_ORGANIZATION ",                 "adm_organisation")
//        property var model_adm_department_outer: managerDB.createModel(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID = 0", "adm_department_outer")
//        property var model_adm_department_inner: managerDB.createModel(" SELECT ID, DEPARTMENT_INNER FROM ADM_DEPARTMENT_INNER ",             "adm_department_inner")
//        property var model_adm_assignment:       managerDB.createModel(" SELECT ID, ASSIGNEMENT      FROM ADM_ASSIGNEMENT ",                  "adm_department_nnp")

        //property var model_adm_organisation_org: managerDB.createModel(" SELECT ORGANIZATION_        FROM ADM_ORGANIZATION ",              "adm_organisation_org")
        //property var model_adm_organisation_dep: managerDB.createModel(" SELECT ID, DEPARTMENT       FROM ADM_ORGANIZATION WHERE ID = 1 ", "adm_organisation_dep")
        //property var model_adm_department_nnp:   managerDB.createModel(" SELECT ID, DEPARTMENT_NPP   FROM ADM_DEPARTMENT_NPP ",            "adm_department_nnp")


    }

    Connections {
        id: wc_query
        target: Query1

        property int num_step: 0

        //(const QString& owner_name, const bool& res)
        onSignalSendResult: {
            if (owner_name === "AddWorker") {
                if (res === true) {
                    if (wc_query.num_step === 0) {
                        if(var_res > 0) {
                            //результат = var_res
                            nw_tf_pn_header.color = "indianred"
                            //ok_button.enabled = false
                        } else {
                            nw_tf_pn_header.color = "black"
                            //ok_button.enabled = true
                        }
                    }
                } else {
                    //ошибка выполнения запроса
                }
            }

            //проверка есть ли в БД запись с таким же табельным номером
            if(owner_name == "isPersonalNumber") {
                if ( var_res > 0 ) { nw_personalNumber.color = "#ff0000" } // краный
                else               { nw_personalNumber.color = "#008000" } // зеленный
            }
            //проверка есть ли в БД запись с таким же ТЛД
            if(owner_name == "isIDTLD") {
                if ( var_res > 0 ) { nw_tld.color = "#ff0000" }
                else               { nw_tld.color = "#008000" }
            }
        }
    }

    Rectangle {
        id: header_rectangle
        color: "indianred"
        width: parent.width
        height: 40
        Label {
            id: header_caption
            text: "Добавление нового сотрудника"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize: 16
            color: "White"
            font.bold: true
        }
    }

    Frame {
        //id: frame_tabbar
        anchors.left: parent.left
        anchors.top: header_rectangle.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
//        anchors.margins: 10

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
            id: tabbar_addNewPerson
            width: parent.width
            currentIndex: 0
            font.pixelSize: 14
            background: Rectangle { color: "#eeeeee" }
            property int tbwidth: 300
//            TabButton {
//                text: "Общая информация"
//                width: implicitWidth
//            }
            TabButton {
                text: "Персональная информация"
                width: implicitWidth
            }
            TabButton {
                text: "Контактная информация"
                width: implicitWidth
            }
            TabButton {
                text: "Информация по дозам"
                width: implicitWidth
            }
//            TabButton {
//                text: "Зоны контроля"
//                width: implicitWidth
//            }
        }


        StackLayout {
            anchors.bottom: parent.bottom
            anchors.top: tabbar_addNewPerson.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            currentIndex: tabbar_addNewPerson.currentIndex
            Item {
                Pane {
                    id: pane_pesonalInfo
                    anchors.fill: parent
                    //                    background: Rectangle {
                    //                        anchors.fill: parent
                    //                        color: "green"
                    //                        border.color: "transparent"
                    //                        //radius: 7
                    //                    }



                    //ОСНОВНОЙ СТОЛБЕЦ ДЛЯ ВСЕХ ЭЛЕМЕНТОВ
                    Column {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        // ПЕРВАЯ ПОЛОСА ДАННЫХ
                        // (ФОТО; ФИО; ДАТА РОЖДЕНИЯ; ПОЛ; ВЕС; РОСТ)
                        RowLayout {
                            anchors.left: parent.left
                            anchors.right: parent.right

                            spacing: 10

                            //ФОТО
                            Rectangle {
                                width: 135
                                height: 155
                                id: photo_frame
                                //                    anchors.top: parent.top
                                //                    anchors.left: parent.left
                                //                    anchors.margins: 10

                                border.color: "LightGray"
                                //color: "aliceblue"//"whitesmoke"
                                radius: 2
                                //anchors.leftMargin: 10
                                Image {
                                    anchors.top: parent.top
                                    anchors.topMargin: 18
                                    opacity: 0.2
                                    sourceSize.height: 120
                                    sourceSize.width: 120
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    source: "icons/face.svg"

                                }
                            }

                            // ФИО
                            // ДАТА РОЖДЕНИЯ; ПОЛ; ВЕС; РОСТ
                            Frame {
                                id: first_step_frame
                                Layout.maximumHeight : 155
                                // Layout.alignment: /*Qt.AlignRight  |*/  Qt.AlignLeft
                                Layout.fillWidth: true


                                background: Rectangle {
                                    anchors.fill: parent
                                    color: "White"
                                    border.color: "LightGray"
                                    radius: 2
                                }

                                Column {
                                    spacing: 10
                                    RowLayout {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        Layout.fillWidth: true
                                        Layout.leftMargin: 0//10
                                        Layout.topMargin: 10
                                        spacing: 25
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Фамилия"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_surname
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Имя"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_name
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Отчество"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_patronymic
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }

                                    }

                                    RowLayout {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        Layout.fillWidth: true
                                        Layout.leftMargin: 0//10
                                        Layout.topMargin: 10
                                        spacing: 25

                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Дата рождения"
                                                font.pixelSize: 14
                                            }

                                            MyCalendar {
                                                id: nw_birthday
                                                date_val: new Date()
                                                enabled: false //true
                                            }
                                        }
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Пол"
                                                font.pixelSize: 14
                                            }

                                            ComboBox {
                                                id: nw_gender
                                                width: 135
                                                flat: false
                                                font.pixelSize: 16
                                                model: ["Мужчина", "Женщина"]
                                            }
                                        }

                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            spacing: 5
                                            Text {
                                                text: "Вес"
                                                anchors.left: parent.left
                                                //anchors.horizontalCenter: parent.horizontalCenter
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                spacing: 10
                                                TextField {
                                                    id: nw_weight
                                                    width: 60
                                                    //height: 48
                                                    horizontalAlignment: Text.AlignHCenter
                                                    text: "0"
                                                    font.pixelSize: 16
                                                    selectByMouse: true
                                                    validator: IntValidator {
                                                        bottom: 0
                                                    }
                                                }
                                                Text {
                                                    text: "кг"
                                                    font.pixelSize: 16
                                                    bottomPadding: 6
                                                    anchors.bottom: parent.bottom
                                                }
                                            }
                                        }

                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            spacing: 5
                                            Text {
                                                text: "Рост"
                                                anchors.left: parent.left
                                                //anchors.horizontalCenter: parent.horizontalCenter
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                anchors.horizontalCenter: parent.horizontalCenter
                                                spacing: 10
                                                TextField {
                                                    id: nw_hieght
                                                    width: 60
                                                    //height: 48
                                                    horizontalAlignment: Text.AlignHCenter
                                                    text: "0"
                                                    font.pixelSize: 16
                                                    selectByMouse: true
                                                    validator: IntValidator {
                                                        bottom: 0
                                                    }
                                                }
                                                Text {
                                                    text: "см"
                                                    font.pixelSize: 16
                                                    bottomPadding: 6
                                                    anchors.bottom: parent.bottom
                                                }
                                            }
                                        }
                                    }
                                }

                            }
                        }



                        Frame {
                            //Layout.maximumHeight : 155
                            // Layout.alignment: /*Qt.AlignRight  |*/  Qt.AlignLeft
                            //Layout.fillWidth: true
                            anchors.left: parent.left
                            anchors.right: parent.right

                            background: Rectangle {
                                anchors.fill: parent
                                color: "White"
                                border.color: "LightGray"
                                radius: 2
                            }

                            Column {
                                spacing: 10
                                anchors.fill: parent
                                RowLayout {
                                    spacing: 20

                                    Column {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        Text {
                                            id: label_personalNumber
                                            text: "Табельный №"
                                            font.pixelSize: 14
                                            color: {
                                                if(nw_personalNumber.length === 0) { return "#ff0000" } //красный
                                                else { return nw_personalNumber.color}
                                            }
                                        }
                                        TextField {
                                            id: nw_personalNumber
                                            property bool isOk: (color == "#008000") ? true : false
                                            width: 100
                                            font.pixelSize: 16
                                            horizontalAlignment: Text.AlignHCenter
                                            selectByMouse: true
                                            onTextEdited: {
                                               if (text.length > 0) { timer_personalNumber.restart() }
                                               else { color = "#ff0000" }
                                               // if (text.length === 1) text = text.toUpperCase()
                                            }
                                        }
                                        Timer {
                                            id: timer_personalNumber
                                            interval: 500
                                            repeat: false
                                            onTriggered: {
                                                 if (nw_personalNumber.text.length > 0)
                                                 { Query1.setQueryAndName(" Select PERSON_NUMBER FROM EXT_PERSON WHERE PERSON_NUMBER = " + nw_personalNumber.text, "isPersonalNumber"); }

                                             }
                                        }
                                    }

                                    Column {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        Text {
                                            id: label_tld
                                            text: "№ ТЛД"
                                            font.pixelSize: 14
                                            color: {
                                                if(nw_tld.length === 0) { return "#ff0000"  } //красный
                                                else { return nw_tld.color}
                                            }
                                        }
                                        TextField {
                                            id: nw_tld
                                            property bool isOk: (color == "#008000") ? true : false
                                            width: 100
                                            font.pixelSize: 16
                                            horizontalAlignment: Text.AlignHCenter
                                            selectByMouse: true
                                            onTextEdited: {
                                                if (text.length > 0) { timer_tld.restart();}
                                                else { color = "#ff0000" }
                                                //if (text.length === 1) text = text.toUpperCase()
                                            }
                                        }
                                        Timer {
                                            id: timer_tld
                                            interval: 500
                                            repeat: false
                                            onTriggered: {
                                                 if (nw_tld.text.length > 0)
                                                 { Query1.setQueryAndName(" Select ID_TLD FROM EXT_PERSON WHERE ID_TLD = " + nw_tld.text, "isIDTLD"); }

                                             }
                                        }
                                    }


                                    Column {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        Text {
                                            text: "Статус"
                                            font.pixelSize: 14
                                        }
                                        ComboBox {
                                            id: nw_statusCode
                                            width: 320
                                            flat: false
                                            font.pixelSize: 16
                                            //property var model_:
                                            property var id_status: 1 //"STATUS_CODE"

                                            model: main_AddWorker.model_adm_status //modeles.model_adm_status
                                                //managerDB.createModel(" SELECT STATUS FROM ADM_STATUS ", "adm_status")
//                                                  ["Работал весь учетный год",
//                                                "Прикомандирован в отчетном году",
//                                                "Уволился в отчетном году",
//                                                "Вышел на пенсию в отчетном году",
//                                                "Умер в отчетном году"]

                                            textRole: "STATUS"
                                           // onCurrentIndexChanged: {id_status = model.getId(currentIndex)}
                                        }
                                    }

                                    Column {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        Text {
                                            text: "Тип персонала"
                                            font.pixelSize: 14
                                        }
                                        ComboBox {
                                            id: nw_staffType
                                            width: 200
                                            flat: false
                                            font.pixelSize: 16
                                            //property var model_:

                                            model: ["Персонал АЭС", "Командировачный"]
                                        }
                                    }

                                }

                                RowLayout {
                                    spacing: 20

                                    Column {
                                        id: column_organization
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        enabled: (nw_staffType.currentIndex==0) ? false : true
                                        Text {
                                            text: "Организация"
                                            font.pixelSize: 14
                                        }
                                        Row {
                                            spacing: 5
                                            ComboBox {
                                                id: nw_organisation
                                                width: 170
                                                flat: false
                                                font.pixelSize: 16
                                                model:  main_AddWorker.model_adm_organisation //modeles.model_adm_organisation
                                                    //["001", "002"]
                                                    //(nw_staffType.currentIndex==0) ? ["АЭС"] : modeles.model_adm_organisation
                                                textRole:  "ORGANIZATION_" //(nw_staffType.currentIndex==0) ? "" : "ORGANIZATION_"
                                                displayText:  (nw_staffType.currentIndex==0) ? "АЭС" : currentText

                                                //меняется содержание списка "Подразделения" в зависмисоти от выбранного названия оргнанизации
                                                onCurrentTextChanged: {
                                                    //console.log(" >>>>> currentText = ", nw_organisation.currentText, " ", currentIndex)
                                                    if( nw_staffType.currentIndex == 1 )
                                                        var id_org = main_AddWorker.model_adm_organisation.getId(currentIndex) //modeles.model_adm_organisation.getId(currentIndex)
                                                        if( id_org >= 0 ) {
                                                            main_AddWorker.model_adm_department_outer.setQueryDB(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID_ORGANIZATION = '" + id_org + "'");
                                                            //modeles.model_adm_department_outer.setQueryDB(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID_ORGANIZATION = '" + id_org + "'");
                                                            nw_department_outer.currentIndex = -1
                                                        }

                                                }
                                            }
                                            Button {
                                                id: nw_addOrganisation
                                                height: 45
                                                width: 35
                                                text: "+"
                                                //font.bold: true
                                                font.pixelSize: 40
                                                onClicked: {popup_addOrganisation.open()}

                                                Popup {
                                                    id: popup_addOrganisation
                                                    //x: -200// parent.x
                                                    y: parent.y
                                                    width: 570
                                                    height: 100
                                                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
                                                    Row {
                                                        anchors.centerIn: parent
                                                        spacing: 10
                                                        Column {
                                                            Label { text: "Организация"}
                                                            TextField {
                                                                id: txt_addOrganization
                                                                width: 230
                                                            }
                                                        }

                                                        Column {
                                                            Label { text: "Отдел"}
                                                            TextField {
                                                                id: txt_addDepartment
                                                                width: 230
                                                            }
                                                        }
                                                        Button {
                                                            height: 75
                                                            width: 65
                                                            text: "+"
                                                            //font.bold: true
                                                            font.pixelSize: 40
                                                            onClicked: { // SELECT ORGANIZATION_ FROM ADM_ORGANIZATION
                                                                var query = " INSERT INTO ADM_ORGANIZATION VALUES ("
                                                                               + "'" + txt_addOrganization.text + "', "
                                                                               + "'" + txt_addDepartment.text   + "') ";
                                                                Query1.setQuery(query);
                                                                popup_addOrganisation.close();
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }


                                    }

                                    Column {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        //enabled: (nw_staffType.currentIndex==0) ? false : true
                                        Text {
                                            text: "Подразделение"
                                            font.pixelSize: 14
                                        }
                                        Row {
                                            spacing: 5                                            
                                            ComboBox {
                                                id: nw_department_inner
                                                width: 180
                                                flat: false
                                                font.pixelSize: 16
                                                visible: (nw_staffType.currentIndex==0) ? true : false
                                                model: //["01","02"]
                                                    main_AddWorker.model_adm_department_inner
                                                    //modeles.model_adm_department_inner  //.setQueryDB(" SELECT STATUS_CODE, ADM_STATUS FROM ADM_STATUS ")
                                                textRole: "DEPARTMENT_INNER"
                                            }

                                            ComboBox {
                                                id: nw_department_outer
                                                width: 180
                                                flat: false
                                                font.pixelSize: 16
                                                visible: (nw_staffType.currentIndex==0) ? false : true
                                                model: //["1", "2"]
                                                       main_AddWorker.model_adm_department_outer
                                                       //modeles.model_adm_department_outer
                                                textRole: "DEPARTMENT_OUTER"
                                            }
//                                            Button {
//                                                id: nw_addDepartment
//                                                height: 45
//                                                width: 35
//                                                text: "+"
//                                                //font.bold: true
//                                                font.pixelSize: 40
//                                                onClicked: {popup_addDepartment.open()}

//                                                Popup {
//                                                    id: popup_addDepartment
//                                                    x: - 200
//                                                    width: 300
//                                                    height: 50
//                                                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
//                                                    Row {
//                                                        anchors.centerIn: parent
//                                                        spacing: 10
//                                                        TextField {
//                                                            width: 230
//                                                        }
//                                                        Button {
//                                                            height: 45
//                                                            width: 35
//                                                            text: "+"
//                                                            //font.bold: true
//                                                            font.pixelSize: 40
//                                                            onClicked: {
//                                                                popup_addDepartment.close()
//                                                            }
//                                                        }
//                                                    }
//                                                }
//                                            }

                                        }





                                    }

                                    Column {
                                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                        //enabled: (nw_staffType.currentIndex==0) ? false : true
                                        Text {
                                            text: "Должность"
                                            font.pixelSize: 14
                                        }
                                        Row {
                                            spacing: 5
                                            ComboBox {
                                                id: nw_assignment
                                                width: 200
                                                flat: false
                                                font.pixelSize: 16

                                                model: main_AddWorker.model_adm_assignment //modeles.model_adm_assignment
                                                textRole: "ASSIGNEMENT"
                                            }
                                        }





                                    }


                                }

                            }

                        }



                        Frame {
                            //Layout.maximumHeight : 155
                            // Layout.alignment: /*Qt.AlignRight  |*/  Qt.AlignLeft
                            //Layout.fillWidth: true
                            anchors.left: parent.left
                            anchors.right: parent.right

                            background: Rectangle {
                                anchors.fill: parent
                                color: "White"
                                border.color: "LightGray"
                                radius: 2
                            }

                            Row {
                                anchors.fill: parent
                                spacing: 10
                                Column {
                                    spacing: 10

                                    Text {
                                        text: qsTr("Паспорт")
                                        font.pixelSize: 14
                                    }
                                    RowLayout {
                                        spacing: 20
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Номер"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_pass_number
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }

                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Дата выдачи"
                                                font.pixelSize: 14
                                            }
                                            MyCalendar {
                                                id: nw_pass_date
                                                date_val: new Date()
                                                enabled: false //true
                                            }
                                        }
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Кем выдан"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_passportGive
                                                font.pixelSize: 16
                                                width: 250
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }

                                    }


                                }

                                ToolSeparator {
                                    height: 100
                                    contentItem: Rectangle {
                                        implicitWidth: parent.vertical ? 1 : 24
                                        implicitHeight: parent.vertical ? 24 : 1
                                        color: "LightGray"
                                    }
                                }

                                Column {
                                    spacing: 10
                                    Text {
                                        text: qsTr("Снилс")
                                        font.pixelSize: 14
                                    }

                                    RowLayout {
                                        spacing: 20
                                        Column {
                                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                            Text {
                                                text: "Номер"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_SNILS
                                                font.pixelSize: 16
                                                width: 200
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
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
                Pane {
                    id: pane_contactInfo
                    anchors.fill: parent

                    //ОСНОВНОЙ СТОЛБЕЦ ДЛЯ ВСЕХ ЭЛЕМЕНТОВ
                    Column {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10
                        RowLayout {
                            anchors.left: parent.left
                            anchors.right: parent.right

                            spacing: 10
                            Frame {
                                //Layout.maximumHeight : 155
                                // Layout.alignment: /*Qt.AlignRight  |*/  Qt.AlignLeft
                                Layout.fillWidth: true

                                background: Rectangle {
                                    anchors.fill: parent
                                    color: "White"
                                    border.color: "LightGray"
                                    radius: 2
                                }
                                Column {
                                    //Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    spacing: 30
                                    Text {
                                        text: "Контакты и место работы"
                                    }
                                    RowLayout {
                                        Column {
                                            Text {
                                                text: "Дом. тел."
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_homeTel
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Моб. тел."
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_mobileTel
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Дом. адрес"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_homeAdress
                                                font.pixelSize: 16
                                                width: 300
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Эл. почта"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_eMail
                                                font.pixelSize: 16
                                                width: 200
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }

                                    }

                                    RowLayout {
                                        Column {
                                            Text {
                                                text: "Раб. тел. 1"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_workTel
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Раб. тел. 2"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_workTel_2
                                                font.pixelSize: 16
                                                width: 150
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Раб. адрес"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_workAdress
                                                font.pixelSize: 16
                                                width: 300
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Эл. почта"
                                                font.pixelSize: 14
                                            }
                                            TextField {
                                                id: nw_eMailWork
                                                font.pixelSize: 16
                                                width: 200
                                                horizontalAlignment: Text.AlignHCenter
                                                selectByMouse: true
                                                onTextEdited: {
                                                    if (text.length === 1) text = text.toUpperCase()
                                                }
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
                Pane {
                    id: pane_doseInfo
                    anchors.fill: parent

                    //ОСНОВНОЙ СТОЛБЕЦ ДЛЯ ВСЕХ ЭЛЕМЕНТОВ
                    Column {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10
                        RowLayout {
                            anchors.left: parent.left
                            anchors.right: parent.right

                            spacing: 10
                            Frame {
                                //Layout.maximumHeight : 155
                                // Layout.alignment: /*Qt.AlignRight  |*/  Qt.AlignLeft
                                Layout.fillWidth: true

                                background: Rectangle {
                                    anchors.fill: parent
                                    color: "White"
                                    border.color: "LightGray"
                                    radius: 2
                                }
                                Column {
                                    //Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    spacing: 30
//                                    Text {
//                                        text: "Дозы_"
//                                    }
                                    RowLayout {
                                        spacing: 30
                                        Column {
                                            Text {
                                                text: "Дата постановки на учет"
                                                font.pixelSize: 14

                                            }
                                            MyCalendar {
                                                id: nw_date_on
                                                date_val: new Date()
                                                enabled: false //true
                                                width: 200
                                            }
//                                            TextField {
//                                                id: nw_date_on
//                                                font.pixelSize: 16
//                                                width: 150
//                                                horizontalAlignment: Text.AlignHCenter
//                                                selectByMouse: true
//                                                onTextEdited: {
//                                                    if (text.length === 1) text = text.toUpperCase()
//                                                }
//                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Дата снятия с учета"
                                                font.pixelSize: 14
                                            }
                                            MyCalendar {
                                                id: nw_date_off
                                                date_val: new Date()
                                                enabled: false //true
                                                width: 200
                                            }
//                                            TextField {
//                                                id: nw_date_off
//                                                font.pixelSize: 16
//                                                width: 150
//                                                horizontalAlignment: Text.AlignHCenter
//                                                selectByMouse: true
//                                                onTextEdited: {
//                                                    if (text.length === 1) text = text.toUpperCase()
//                                                }
//                                            }
                                        }

                                    }


                                    RowLayout {
                                        spacing: 30
                                        Column {
                                            Text {
                                                text: "Доза до АЭС"
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                TextField {
                                                    id: nw_dose_before_npp
                                                    font.pixelSize: 16
                                                    width: 100
                                                    horizontalAlignment: Text.AlignHCenter
                                                    selectByMouse: true
                                                    text: "0"
                                                    onTextEdited: {
                                                        if (text.length === 1) text = text.toUpperCase()
                                                    }
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "мЗв"
                                                    font.pixelSize: 14
                                                }
                                            }

                                        }
                                        Column {
                                            Text {
                                                text: "Доза, полученная на ЧАЭС"
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                TextField {
                                                    id: nw_dose_chnpp
                                                    font.pixelSize: 16
                                                    width: 100
                                                    horizontalAlignment: Text.AlignHCenter
                                                    selectByMouse: true
                                                    text: "0"
                                                    onTextEdited: {
                                                        if (text.length === 1) text = text.toUpperCase()
                                                    }
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "мЗв"
                                                    font.pixelSize: 14
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Годовой ИКУ"
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                TextField {
                                                    id: nw_iku_year
                                                    font.pixelSize: 16
                                                    width: 100
                                                    horizontalAlignment: Text.AlignHCenter
                                                    selectByMouse: true
                                                    text: "0"
                                                    onTextEdited: {
                                                        if (text.length === 1) text = text.toUpperCase()
                                                    }
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "мЗв"
                                                    font.pixelSize: 14
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Месячный ИКУ"
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                TextField {
                                                    id: nw_iku_month
                                                    font.pixelSize: 16
                                                    width: 100
                                                    horizontalAlignment: Text.AlignHCenter
                                                    selectByMouse: true
                                                    text: "0"
                                                    onTextEdited: {
                                                        if (text.length === 1) text = text.toUpperCase()
                                                    }
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "мЗв"
                                                    font.pixelSize: 14
                                                }
                                            }
                                        }

                                    }

                                    RowLayout {
                                        spacing: 20
                                        Column {
                                            Text {
                                                text: "Административный уровень облучения"
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                TextField {
                                                    id: nw_Au
                                                    font.pixelSize: 16
                                                    width: 100
                                                    horizontalAlignment: Text.AlignHCenter
                                                    selectByMouse: true
                                                    text: "0"
                                                    onTextEdited: {
                                                        if (text.length === 1) text = text.toUpperCase()
                                                    }
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "мЗв"
                                                    font.pixelSize: 14
                                                }
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Индивидуальный уровень облучения\n(устанавливается приказом директора предприятия)"
                                                font.pixelSize: 14
                                            }
                                            Row {
                                                TextField {
                                                    id: nw_Iu
                                                    font.pixelSize: 16
                                                    width: 100
                                                    horizontalAlignment: Text.AlignHCenter
                                                    selectByMouse: true
                                                    text: "0"
                                                    onTextEdited: {
                                                        if (text.length === 1) text = text.toUpperCase()
                                                    }
                                                }
                                                Text {
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    text: "мЗв"
                                                    font.pixelSize: 14
                                                }
                                            }

                                        }

                                    }

                                    RowLayout {
                                        spacing: 30
                                        Column {
                                            Text {
                                                text: "Признак получения аварийной дозы"
                                                font.pixelSize: 14
                                            }
                                            ComboBox {
                                                id: nw_emergency_dose
                                                //width: 135
                                                flat: false
                                                font.pixelSize: 16
                                                model: ["Нет", "Да"]
                                            }
                                        }
                                        Column {
                                            Text {
                                                text: "Статус запрета с ИИИ"
                                                font.pixelSize: 14
                                            }
                                            ComboBox {
                                                id: nw_disable_radiation
                                                //width: 135
                                                flat: false
                                                font.pixelSize: 16
                                                model: ["Нет", "Да"]
                                            }
                                        }


                                    }



                                }
                            }
                        }


                    }
                }
            }



        }

        Button {
            id: ok_button
            width: 120
            //anchors.margins: 10
            anchors.bottomMargin: 10
            anchors.rightMargin: 20

            enabled:
            {
                var isOk

                if (nw_personalNumber.isOk) { isOk = true                }
                else                        { isOk = false; return isOk; }

                if (nw_tld.isOk) { isOk = true                }
                else             { isOk = false; return isOk; }

                return isOk;
            }

            text: "Сохранить"
            font.pixelSize: 14
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            //enabled: false

            onClicked: {
                var data_arr = {}
                data_arr["W_NAME"]       = nw_name.text
                data_arr["W_SURNAME"]    = nw_surname.text
                data_arr["W_PATRONYMIC"] = nw_patronymic.text


                //if (nw_birthday.ready) data_arr["BIRTH_DATE"] = nw_birthday.date_val

                data_arr["SEX"] = nw_gender.currentIndex // (nw_gender.currentIndex==0) ? "M" : "F"
                data_arr["WEIGHT"] = parseInt(nw_weight.text, 10)
                data_arr["HEIGHT"] = parseInt(nw_hieght.text, 10)


                if (nw_personalNumber.length > 0) data_arr["PERSON_NUMBER"] = parseInt(nw_personalNumber.text,10)
                if (nw_tld.text.length > 0)       data_arr["ID_TLD"]        = parseInt(nw_tld.text,10)

                data_arr["STATUS_CODE"] = parseInt(main_AddWorker.model_adm_status.getId(nw_statusCode.currentIndex), 10) //nw_statusCode.currentIndex + 1
                data_arr["STAFF_TYPE"]  = nw_staffType.currentText

                if( nw_staffType.currentIndex == 0 ) {
                    data_arr["ID_DEPARTMENT_INNER"] = parseInt(main_AddWorker.model_adm_department_inner.getId(nw_department_inner.currentIndex),10)
                    data_arr["ID_ORGANIZATION"]     = 0;
                    data_arr["ID_DEPARTMENT_OUTER"] = 0;
                }                
                if( nw_staffType.currentIndex == 1 ) {
                    data_arr["ID_DEPARTMENT_OUTER"] = parseInt(main_AddWorker.model_adm_department_outer.getId(nw_department_outer.currentIndex),10)
                    data_arr["ID_DEPARTMENT_INNER"] = 0;
                    data_arr["ID_ORGANIZATION"]     = parseInt( main_AddWorker.model_adm_organisation.getId(nw_organisation.currentIndex),10 )
                }

                data_arr["ID_ASSIGNEMENT"] = parseInt( main_AddWorker.model_adm_assignment.getId(nw_assignment.currentIndex), 10 )  //nw_assignment.currentText


////                data_arr["IKU_YEAR"] = (nw_iku_year.text.length > 0) ? parseFloat(nw_iku_year.text.replace(",",".")) : 0.0
////                if (nw_gender.currentIndex === 1) { //женщина
////                    data_arr["IKU_MONTH"] = (nw_iku_month.text.length > 0) ? parseFloat(nw_iku_month.text.replace(",",".")) : 0.0
////                }


                if (nw_pass_number.text.length > 0)  data_arr["PASSPORT_NUMBER"]  = nw_pass_number.text
                if (nw_passportGive.text.length > 0) data_arr["PASSPORT_GIVE"]    = nw_passportGive.text

                ///ДАТА РАСКОМЕНТИРОВАТЬ if (nw_pass_date.ready) data_arr["PASSPORT_DATE"] = nw_pass_date.date_val
                //data_arr["PASSPORT_DATE"] = nw_pass_date.date_val

                if (nw_SNILS.text.length > 0)   data_arr["SNILS"] = nw_SNILS.text
                //PANSION_NUMBER

                if (nw_homeTel.text.length > 0)     data_arr["HOME_TEL"]     = nw_homeTel.text
                if (nw_mobileTel.text.length > 0)   data_arr["MOBILE_TEL"]   = nw_mobileTel.text
                if (nw_homeAdress.text.length > 0)  data_arr["HOME_ADDRESS"] = nw_homeAdress.text

                if (nw_workTel.text.length > 0)     data_arr["WORK_TEL"]     = nw_workTel.text
                if (nw_eMail.text.length > 0)       data_arr["E_MAIL"]       = nw_eMail.text
                if (nw_workAdress.text.length > 0)  data_arr["WORK_ADDRESS"] = nw_workAdress.text

                //if (nw_date_on.ready)  data_arr["DATE_ON"]  = nw_date_on.date_val
                //if (nw_date_off.ready) data_arr["DATE_OFF"] = nw_date_off.date_val

                /// дозы
                if( nw_dose_before_npp.text.length > 0 ) data_arr["DOSE_BEFORE_NPP"] = nw_dose_before_npp.text
                if( nw_dose_chnpp.text.length > 0 )      data_arr["DOSE_CHNPP"]      = nw_dose_chnpp.text
                if( nw_iku_year.text.length > 0 )        data_arr["IKU_YEAR"]        = nw_iku_year.text
                if( nw_iku_month.text.length > 0 )       data_arr["IKU_MONTH"]       = nw_iku_month.text

                if( nw_Au.text.length > 0 ) data_arr["AU"] = nw_Au.text
                if( nw_Iu.text.length > 0 ) data_arr["IU"] = nw_Iu.text

                 data_arr["EMERGENCY_DOSE"]    = nw_emergency_dose.currentIndex
                 data_arr["DISABLE_RADIATION"] = nw_disable_radiation.currentIndex




                //console.log(">", nw_organisation.currentText)
                //console.log(data_arr["STATUS_CODE"]);
                //console.log(">",nw_staffType.currentText);
                create_confirm(data_arr)
                clearfields()
            }
        }

        Button {
            id: cancel_button
            width: ok_button.width
            anchors.bottomMargin: 10
            anchors.leftMargin: 20
            text: "Отмена"
            font.pixelSize: 14
            anchors.bottom: parent.bottom
            anchors.left: parent.left            

            onClicked: {
                create_cancel()
                clearfields()
            }
        }





    }






}

