import QtQuick 2.0
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

Item {
    id: frame_search

    property bool open: true

    property var model_ext_person_list
    property var model_adm_assignment

    signal sendIDPerson(var id_currentPerson)
    signal openListPerson(var isOpen)

    property int widthListPersonsPanel: button_OpenListAllPersons.width + rect_field_PersonSearch.width


    //width: 800
    height: 70
    //clip: true

    /// функция генерирует строку с добавочными условиями по поиску сотрудников
    function advancedSearch_fun() {
        var advancedSearch = "";
        var dataCurrent = "";
        var isAnd = false;


//        /// УДАЛИТЬ ///
//        return advancedSearch;
//        /// УДАЛИТЬ ///


        /// просмотр флажка ПОЛ
        if(checkBox_SEX.checked) {
            if      (comboBox_SEX.currentIndex==0) { dataCurrent = "'M'"; }
            else if (comboBox_SEX.currentIndex==1) { dataCurrent = "'F'"; }
            else {
                dataCurrent = "";
            }
            advancedSearch = advancedSearch + " SEX = " + dataCurrent;

            //if ( isAnd ) advancedSearch = " AND " + advancedSearch;
            isAnd = true;            
        }

        /// просмотр флажка ДАТА РОЖДЕНИЯ
        if(checkBox_BIRTH_DATE.checked) {
            if ( comboBox_YEAR_DATE.currentIndex >= 0 ) {
                if ( isAnd ) advancedSearch = advancedSearch + " AND ";
                isAnd = true;
                dataCurrent = comboBox_YEAR_DATE.currentText
                advancedSearch = advancedSearch + " Extract(YEAR FROM BIRTH_DATE) = " + dataCurrent;  //= TO_DATE('" + dataCurrent + "','DD/MM/YY') "
            }


        }

        /// просмотр флажка ТИП ПЕРСОНАЛА
        if(checkBox_STAFF_TYPE.checked) {
            if ( comboBox_STAFF_TYPE.currentIndex >= 0 ) {
                if ( isAnd ) advancedSearch = advancedSearch + " AND ";
                isAnd = true;
                if      (comboBox_STAFF_TYPE.currentIndex==0) { dataCurrent = "'Персонал АЭС'"; }
                else if (comboBox_STAFF_TYPE.currentIndex==1) { dataCurrent = "'Командировачный'"; }
                else { dataCurrent = ""; }
                advancedSearch = advancedSearch + " STAFF_TYPE = " + dataCurrent;
            }

        }
        /// просмотр флажка ДОЛЖНОСТЬ
        if(checkBox_ASSIGNEMENT.checked) {
            if ( comboBox_ASSIGNEMENT.currentIndex >= 0 ) {
                if ( isAnd ) advancedSearch = advancedSearch + " AND ";
                isAnd = true;
                dataCurrent = parseInt( frame_search.model_adm_assignment.getFirstColumnInt(comboBox_ASSIGNEMENT.currentIndex), 10 )
                advancedSearch = advancedSearch + " ID_ASSIGNEMENT = '" + dataCurrent + "'";
            }

        }


        return advancedSearch;
    }

    /// функция с запросом поиска сотрудника к БД и обновлением модели списка сотрудников
    function updatePersonList_fun(text, textLenght) {
        //if (field_PersonSearch.text.length == 0) return;

        var advancedSearch = frame_search.advancedSearch_fun(); /// строка с добавочными условиями по поиску сотрудников

        //if (field_PersonSearch.text.length > 0) {
        if (textLenght > 0) {
            //var txt = field_PersonSearch.text
            var txt = text
            if ( advancedSearch.length > 0) {
                advancedSearch = " AND " + advancedSearch;
            }

            if(isNaN(txt)) { /// проверка число или текст
                var query =
                        " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                          FROM EXT_PERSON
                          WHERE (LOWER(W_SURNAME) LIKE '" + txt.toLowerCase() + "%') "
                          + advancedSearch +
                          " ORDER BY W_SURNAME ";
                console.log("query = /n", query);
                model_ext_person_list.query = query;

            } else {
                model_ext_person_list.query =
                        " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                          FROM EXT_PERSON
                          WHERE (ID_TLD LIKE '" + txt + "%') "
                          + advancedSearch +
                          " ORDER BY W_SURNAME "
            }
        } else {
            if ( advancedSearch.length > 0) {
                advancedSearch = " WHERE " + advancedSearch;
                model_ext_person_list.query =
                            " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                              FROM EXT_PERSON "
                              + advancedSearch +
                              " ORDER BY W_SURNAME "
            } else {
                model_ext_person_list.query =
                            " SELECT ID_PERSON, W_NAME, W_SURNAME, W_PATRONYMIC, PERSON_NUMBER, ID_TLD
                              FROM EXT_PERSON
                              ORDER BY W_SURNAME "
            }

        }
    }

    /// фнкция вытаскивает выбранного сотрудника
    function searchPerson(id_currentPerson) {
        var query;

        query = " SELECT W_NAME, W_SURNAME, W_PATRONYMIC from EXT_PERSON WHERE ID_PERSON = " + id_currentPerson;
        Query1.setQueryAndName(query, "FIO");

        query = " SELECT PHOTO from EXT_PERSON WHERE ID_PERSON = " + id_currentPerson;
        Query1.setQueryAndName(query, "pullOutPhotoCurrentPerson");
        query = " select max(BURN_DATE) FROM EXT_DOSE WHERE ID_PERSON = " + id_currentPerson;
        Query1.setQueryAndName(query, "getDATA_BURN_lust");

        frame_search.sendIDPerson(id_currentPerson)
        //main_.workerModelQuery(list_Persons.id_currentPerson);


        var now = new Date();
        var date_begin = new Date((now.getFullYear()-1),now.getMonth(),now.getDate()).toLocaleDateString("ru_RU", "dd.MM.yyyy");
        var date_end   = now.toLocaleDateString("ru_RU", "dd.MM.yyyy");

        query = " SELECT " +
                " SUM(TLD_G_HP10) Z21, SUM(TLD_N_HP10)  Z22, SUM(TLD_G_HP3)   Z25, SUM(TLD_N_HP3)   Z26, "  +
                " SUM(TLD_B_HP3)  Z27, SUM(TLD_G_HP007) Z31, SUM(TLD_N_HP007) Z32, SUM(TLD_B_HP007) Z33, "  +
                " SUM(TLD_G_HP10_DOWN) Z37, SUM(TLD_N_HP10_DOWN) Z38 "  + //, SUM(TLD_B_HP10_DOWN) Z39
                " FROM EXT_DOSE WHERE " +

                " ID_PERSON IN (" + id_currentPerson  + ")"
                /// если отбор по датам то последнюю строку заменить на:
//                                " ID_PERSON IN (" + list_Persons.id_currentPerson  + ") AND " +
//                                " BURN_DATE >= TO_DATE('" + date_begin + "','DD/MM/YY') AND"  +
//                                " BURN_DATE <= TO_DATE('" + date_end   + "','DD/MM/YY') ";
        Query1.setQueryAndName(query, "getMainPersonParam1");


        query = " SELECT " +
                " SUM(EPD_G_HP10) Z23, SUM(EPD_N_HP10)  Z24, SUM(EPD_G_HP3)   Z28, SUM(EPD_N_HP3)   Z29, "  +
                " SUM(EPD_B_HP3)  Z30, SUM(EPD_G_HP007) Z34, SUM(EPD_N_HP007) Z35, SUM(EPD_B_HP007) Z36, "  +
                " SUM(EPD_G_HP10_DOWN) Z40, SUM(EPD_N_HP10_DOWN) Z41 " +
                " FROM OP_DOSE WHERE " +

                " ID_PERSON IN (" + id_currentPerson  + ") "
                /// если отбор по датам то последнюю строку заменить на:
//                                " ID_PERSON IN (" + list_Persons.id_currentPerson  + ") AND "  +
//                                " TIME_OUT >= TO_DATE('" + date_begin + "','DD/MM/YY')  AND "  +
//                                " TIME_OUT <= TO_DATE('" + date_end   + "','DD/MM/YY') ";
        Query1.setQueryAndName(query, "getMainPersonParam2");


    }


    Connections {
        target: list_Persons.model
        onSignalUpdateDone: {
            if (res) {
                if (field_PersonSearch.text.length > 0) {
                    if (!button_OpenListAllPersons.open) {
                        find_popup.open();
                    }
                }

            }
        }
    }

    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "FIO") {
                if (res) {
                    //txt_FIO.text = var_res;
                }
            }
        }
    }

    /// поле со списоком выбранных дополнительных фильтров поиска
    Item {
        id: rect_info_advancedSerch
        anchors.top: parent.top
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.rightMargin: 20
        height: 30

        visible: frame_search.open ? true : false

        RowLayout {
            spacing: 20
            //anchors.fill: parent
            anchors.right: parent.right
            Text {
                id: info_SEX
                visible: checkBox_SEX.checked ? true : false
                text: qsTr(" " + comboBox_SEX.currentText)
                font.pointSize: 12
                color: "#808080" // "#c9c9c9"
            }
            Text {
                id: info_YEAR_DATE
                visible: checkBox_BIRTH_DATE.checked  ? true : false
                text: qsTr(" " + comboBox_YEAR_DATE.currentText) //qsTr("")
                font.pointSize: 12
                color: "#808080" // "#c9c9c9"
            }
            Text {
                id: info_STAFF_TYPE
                visible: checkBox_STAFF_TYPE.checked  ? true : false
                text: qsTr(" " + comboBox_STAFF_TYPE.currentText)
                font.pointSize: 12
                color: "#808080" //"#c9c9c9"
            }
            Text {
                id: info_ASSIGNEMENT
                visible: checkBox_ASSIGNEMENT.checked  ? true : false
                text: qsTr(" " + comboBox_ASSIGNEMENT.currentText)
                font.pointSize: 12
                color: "#808080" //"#c9c9c9"
            }
            Text {
                id: info_DEPARTMENT
                visible: checkBox_DEPARTMENT.checked  ? true : false
                text: qsTr(" " + comboBox_DEPARTMENT .currentText)
                font.pointSize: 12
                color: "#808080" //"#c9c9c9"
            }

        }

    }

    /// кнопка развернуть список сотрудников
    Rectangle {
        id: button_OpenListAllPersons
        property bool open: false
        property var currentColor
        visible: frame_search.open ? true : false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.right: parent.right
        anchors.rightMargin: 10
        width:  40
        height: 40
        radius: 50
        color: "transparent"
        //border.color: "LightGray"
        Text {
            anchors.centerIn: parent
            text: button_OpenListAllPersons.open ? ">" : "<"
        }
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            onEntered:  { button_OpenListAllPersons.color = "#f0f0f0"     ; parent.currentColor = "#f0f0f0" }
            onExited:   { button_OpenListAllPersons.color = "transparent" ; parent.currentColor = "transparent" } //LightGray
            onPressed:  { parent.color = "#dbdbdb" }
            onReleased: { parent.color = parent.currentColor }
            onClicked:  {
                if ( !button_OpenListAllPersons.open ) {
                    button_OpenListAllPersons.open = true;
                    openListPerson(true);
                }
                else {
                    button_OpenListAllPersons.open = false;
                    openListPerson(false);
                }
            }
        }
    }


    /// рамка вокруг поля ввода для поиска
    Rectangle {
        id: rect_field_PersonSearch
        //anchors.top: parent.top
        //anchors.topMargin: frame_search.height - height
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        anchors.right: button_OpenListAllPersons.left
        width: 300
        height: 40

        visible: frame_search.open ? true : false

        color: "transparent" //"#adadad" //"#009688"
        //border.color: "green" //"LightGray"


        Rectangle {
            id: rect_field_PersonSearch_border_1
            anchors.left: parent.left
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
            width: 1
        }
        Rectangle {
            id: rect_field_PersonSearch_border_2
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 1
        }

        NumberAnimation {
            target: rect_field_PersonSearch_border_1
            properties: "height"
            duration: 100
            running: false
        }



        /// поле ввода для поиска
        TextField {
                id: field_PersonSearch
                property string quyrySQLAdvancedSearch: ""
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.rightMargin: 10
                anchors.right: parent.right
                anchors.leftMargin: 40
                height: 30

                bottomPadding: 0
                topPadding: 0
                leftPadding: 8
                rightPadding: 8


                visible: frame_search.open ? true : false

                font.pixelSize: 16
                placeholderText: qsTr("Поиск сотрудника..")
                selectByMouse: true

                //property bool havechoice: false

                background: Rectangle {
                    anchors.fill: parent
                    radius: 5
                    color: "White"
                    border.color: "DarkGray"
                }
                onTextChanged: {
                    if ( button_OpenListAllPersons.open ) {
                        timer_updatePersonList.restart();
                    }
                    else {
                        if(text.length > 0) timer_updatePersonList.restart();
                    }

                }
        }

        /// таймер с запросом к БД
        Timer {
            id: timer_updatePersonList
            interval: 500
            repeat: false
            onTriggered: {
                updatePersonList_fun(field_PersonSearch.text, field_PersonSearch.text.length);
                stop();
            }
        }

        /// кнопка обновить
        Rectangle {            
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.margins: 1
            visible: frame_search.open ? true : false
            color: "transparent"
            width: 40
            Text {
                id: txt_button_update
                anchors.centerIn: parent
//                        anchors.right: parent.right
//                        anchors.top: parent.top
//                        anchors.rightMargin: 2
//                        anchors.topMargin: -10
                font.pixelSize: 35
                color: "LightGray"
                text: qsTr("⟳") //✓ ⟳ ☺ 😐
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:  { txt_button_update.color = "#FF5722" }
                onExited:   { txt_button_update.color = "LightGray" } // = "#4CAF50"
                onPressed:  { /*parent.color = "#f6ffed" */}
                onReleased: { /*parent.color = "transparent"*/ }
                onClicked:  {
                    //modeles.model_ext_person_list.updateModel();
                    //timer_updatePersonList.interval = 100;

                    //timer_updatePersonList.restart();
                    updatePersonList_fun(field_PersonSearch.text, field_PersonSearch.text.length);
                }
            }
        }

    }

    /// список сотрудников
    Popup {
        id: find_popup
        width: 400
        height: (list_Persons.contentHeight > 200) ? 200 : (list_Persons.contentHeight + find_popup.padding*2)
        y: rect_field_PersonSearch.y+rect_field_PersonSearch.height
        x: rect_field_PersonSearch.x

        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape

        ListView {
            id: list_Persons
            anchors.fill: parent
            anchors.leftMargin: 5

            visible: frame_search.open ? true : false

            currentIndex: -1 //0
            property string id_currentPerson: model_ext_person_list.getFirstColumnInt(currentIndex)
            property string pn_currentPerson
            property string tld_currentPerson
            property string fio_currentPerson


            highlightFollowsCurrentItem: true
            model: model_ext_person_list

            ScrollBar.vertical: ScrollBar {
                policy: "AsNeeded" //"AlwaysOn"
            }

            clip: true
            delegate:
                ItemDelegate {
                width: 340 //325
                height: 60
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
                            text: W_SURNAME + " " + W_NAME + " " + W_PATRONYMIC
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
                    list_Persons.id_currentPerson = model_ext_person_list.getFirstColumnInt(index)

                    list_Persons.fio_currentPerson = W_SURNAME + "\n" + W_NAME + " " + W_PATRONYMIC

//                            model_ext_person_list.get(list_Persons.currentIndex)["W_NAME"]    + "\n" +
//                            model_ext_person_list.get(list_Persons.currentIndex)["W_SURNAME"] + " "  +
//                            model_ext_person_list.get(list_Persons.currentIndex)["W_PATRONYMIC"]

//                            model_ext_person_list.getCurrentDate(2,list_Persons.currentIndex) + "\n" +
//                            model_ext_person_list.getCurrentDate(1,list_Persons.currentIndex) + " "  +
//                            model_ext_person_list.getCurrentDate(3,list_Persons.currentIndex);

                    list_Persons.pn_currentPerson  = PERSON_NUMBER
                    list_Persons.tld_currentPerson = ID_TLD

                    sendIDPerson(list_Persons.id_currentPerson);
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
                list_Persons.id_currentPerson = model_ext_person_list.getFirstColumnInt(0);
                stop();
            }
        }
        Timer {
            id: timer_persons
            interval: 410
            repeat: false
            onTriggered: {
                searchPerson(list_Persons.id_currentPerson);
                stop();
             }
        }


    }


    /// поле с дополнительными параметрами поиска сотрудника
    Rectangle {
        id: rect_AdvancedSearch
        property bool open: false
        property int heightOpen: 400
        property int heightClose: 40 //frame_search.height
        property int speedAnimation: 200

        anchors.top: parent.top
        anchors.topMargin: frame_search.height - heightClose - 1
        anchors.right: rect_field_PersonSearch.left

        visible: frame_search.open ? true : false

        width: 400
        height: 40 //frame_search.height
        clip: true

        color: height == heightClose ? "transparent" : "white" // rect_AdvancedSearch.open ? "white" : "transparent" //"#e8e8e8" // "#d1d1d1" // "#adadad" "Transparent" //
        border.width: height == heightClose ? 0 : 1
        //border.color: "black"

        onOpenChanged: {
//            animation_1.stop();
//            animation_1.running = true;
//            animation_2.stop();
//            animation_2.running = true;

            if (rect_AdvancedSearch.open) seqAni_open.running = true;
            if (!rect_AdvancedSearch.open) seqAni_close.running = true;
        }

        SequentialAnimation {
            id: seqAni_open
            NumberAnimation {
                target: rect_AdvancedSearch
                easing.type: Easing.InExpo
                properties: "height"
                from: rect_AdvancedSearch.heightClose
                to:   rect_AdvancedSearch.heightOpen
                duration: rect_AdvancedSearch.speedAnimation
                running: false
            }

            PauseAnimation { duration: 100 }

            NumberAnimation {
                target: advancedSearch_column
                properties: "opacity"
                from: 0
                to:   1
                duration: rect_AdvancedSearch.speedAnimation
                running: false
            }
        }

        SequentialAnimation {
            id: seqAni_close

            NumberAnimation {
                target: advancedSearch_column
                properties: "opacity"
                easing.type: Easing.InExpo
                from: 1
                to:   0
                duration: rect_AdvancedSearch.speedAnimation
                running: false
            }

            PauseAnimation { duration: 100 }

            NumberAnimation {
                target: rect_AdvancedSearch
                properties: "height"
                from: rect_AdvancedSearch.heightOpen
                to:   rect_AdvancedSearch.heightClose
                duration: rect_AdvancedSearch.speedAnimation
                running: false
            }

        }



        NumberAnimation {
            id: animation_1
            target: rect_AdvancedSearch
            properties: "height"
            //            easing.period: 0.8
            //            easing.type: Easing.OutElastic
            from: rect_AdvancedSearch.open ? rect_AdvancedSearch.heightOpen  : rect_AdvancedSearch.heightClose
            to:   rect_AdvancedSearch.open ? rect_AdvancedSearch.heightClose : rect_AdvancedSearch.heightOpen
            duration: rect_AdvancedSearch.speedAnimation
            running: false
        }

        NumberAnimation {
            id: animation_2
            target: advancedSearch_column
            //           easing.period: 0.8
            //           easing.type: Easing.InCirc
            properties: "opacity"
            from: rect_AdvancedSearch.open ? 1 : 0
            to:   rect_AdvancedSearch.open ? 0 : 1
            duration: rect_AdvancedSearch.open ?  rect_AdvancedSearch.speedAnimation : rect_AdvancedSearch.speedAnimation + 200
            running: false
        }



        Column {
            id: advancedSearch_column
            opacity: 0
            //visible: false
            //anchors.fill: parent
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top //heder_AdvancedSearch.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 60

            Item {
                width: 200
                height: 50
                Row {
                    spacing: 10
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    CheckBox {
                        id: checkBox_SEX
                        anchors.verticalCenter: parent.verticalCenter
                        Material.accent: Material.Green //Material.Purple
//                            Material.primary: Material.Purple
//                            Material.foreground: Material.Purple
                        text: qsTr("Пол")
                        checked: false

                    }
                    ComboBox {
                        id: comboBox_SEX
                        enabled: (checkBox_SEX.checked) ? true : false
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                        model: [ "М", "Ж" ]
                    }
                }
            }
            Item {
                width: 200
                height: 50
                Row {
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    CheckBox {
                        id: checkBox_BIRTH_DATE
                        Material.accent: Material.Green
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Год рождения") //qsTr("Дата рождения")
                        checked: false
                    }
                    ComboBox {
                        id: comboBox_YEAR_DATE
                        enabled: (checkBox_BIRTH_DATE.checked) ? true : false
                        anchors.verticalCenter: parent.verticalCenter
                        width: 100
                        model: //[ "2019", "2018" ]
                        {
                            var years = [];
                            var thisYear = new Date().getFullYear();
                            for(var i_year = thisYear; i_year > 1900; i_year --) {
                                years.push(i_year);
                            }
                            return years;
                        }
                    }
//                        MyCalendar {
//                            id: myCalendar_BIRTH_DATE
//                            enabled: (checkBox_BIRTH_DATE.checked) ? true : false
//                            date_val: new Date()
//                        }
                }
            }
            Item {
                width: 200
                height: 50
                Row {
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    CheckBox {
                        id: checkBox_STAFF_TYPE
                        Material.accent: Material.Green
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Тип персонала")
                        checked: false
                       }
                    ComboBox {
                        id: comboBox_STAFF_TYPE
                        enabled: (checkBox_STAFF_TYPE.checked) ? true : false
                        anchors.verticalCenter: parent.verticalCenter
                        width: 180
                        model: [ "Персонал АЭС", "Командировочный" ]
                    }
                }

            }
            Item {
                width: 200
                height: 50
                Row {
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    CheckBox {
                        id: checkBox_ASSIGNEMENT
                        Material.accent: Material.Green
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Должность")
                        checked: false
                    }
                    ComboBox {
                        id: comboBox_ASSIGNEMENT
                        enabled: (checkBox_ASSIGNEMENT.checked) ? true : false
                        anchors.verticalCenter: parent.verticalCenter
                        width: 160
                        model: frame_search.model_adm_assignment
                        textRole: "ASSIGNEMENT"
                    }
                }
            }
            Item {
                width: 200
                height: 50
                Row {
                    anchors.fill: parent
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    CheckBox {
                        id: checkBox_DEPARTMENT // ??? _OUTER _INNER
                        Material.accent: Material.Green
                        anchors.verticalCenter: parent.verticalCenter
                        text: qsTr("Подразделение")
                        checked: false

                        enabled: false
                    }
                    ComboBox {
                        id: comboBox_DEPARTMENT
                        enabled: (checkBox_DEPARTMENT.checked) ? true : false
                        anchors.verticalCenter: parent.verticalCenter
                        width: 160
                        model: [""]
                    }
                }
            }

        }


        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            height: 40 //frame_search.height //rect_AdvancedSearch.open ? 30 : 50
            visible: frame_search.open ? true : false
            //border.color: "black"
            color: "transparent"
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: rect_AdvancedSearch.open ? qsTr("▲ Дополнительные параметры поиска") : qsTr("▼ Дополнительные параметры поиска")
                font.pixelSize: 15
                color: "#808080"
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:  { }
                onExited:   { }
                onPressed:  {
                    if(!rect_AdvancedSearch.open) {
                        rect_AdvancedSearch.open = true
                    }
                    else {
                        rect_AdvancedSearch.open = false
                    }

                }
                onReleased: { }
                onClicked:  {

                }
            }


        }
    }


    /// ФИО в заголовке
    TextEdit {
        id: txt_FIO
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 20

        visible: frame_search.open ? true : false

        text: list_Persons.currentIndex >= 0 ? list_Persons.fio_currentPerson : "Сотрудник\nне выбран "
        font.pointSize: 20
        font.bold: true
        font.capitalization: Font.AllUppercase // в верхний регистр
        color: "#474747" // "Black" //Material.color(Material.DeepOrange)
        selectByMouse: true
        selectionColor: Material.color(Material.Red)
    }

    /// данные о сотруднике в заголовке
    ColumnLayout {
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: txt_FIO.right
        anchors.leftMargin: 40
        anchors.margins: 10
        width: 100
        visible: frame_search.open ? true : false
//    RowLayout {
//        //anchors.verticalCenter: parent.verticalCenter
//        anchors.top: parent.top
//        anchors.topMargin: 10
//        anchors.left: txt_FIO.right
//        anchors.leftMargin: 40
//        spacing: 20
        Rectangle {
            Layout.preferredWidth:  txt_PN.width
            Layout.preferredHeight: txt_PN.height
            color: "transparent" // Material.color(Material.Red)
            //border.width: 1
            TextEdit {
                id: txt_PN
                visible: frame_search.open ? true : false
                text: "Таб. № " + list_Persons.pn_currentPerson
                font.pointSize: 14
                //font.bold: true
                font.capitalization: Font.AllUppercase // в верхний регистр
                color: "#757575"
                selectByMouse: true
                selectionColor: Material.color(Material.Red)
            }
        }
        Rectangle {
            Layout.preferredWidth: txt_TLD.width
            Layout.preferredHeight: txt_TLD.height
            color: "transparent" //Material.color(Material.Red)
            TextEdit {
                id: txt_TLD
                visible: frame_search.open ? true : false

                text: "ТЛД № " + list_Persons.tld_currentPerson
                font.pointSize: 14
                //font.bold: true
                font.capitalization: Font.AllUppercase // в верхний регистр
                color: "#757575"
                selectByMouse: true
                selectionColor: Material.color(Material.Red)
            }
        }

    }




}
