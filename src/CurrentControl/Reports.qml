import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

import MyTools 1.0


Page {
    id: page_reports

    property string text_color: "#808080"
    property int space_margin: 15
    property var model_SQLQiueries
    property var model_tableReports

//    Label {
//        anchors.centerIn: parent
//        text:"report_ESKID_&"
//    }


    Connections {
        target: model_tableReports
        onSignalUpdateDone: { /// ( переменные от сигнала: nameModel, res, errorMessage )
            if (res) {
                rect_Table.isOk = true;
                rect_Table.createTable_fun(model_tableReports);

            }
            else {
                rect_Table.isOk = false;
                rect_Table.createEmptyTable_fun("OOPS! Что-то не так с запросом!   " + errorMessage)
            }
        }
    }
    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "q1__addReports" || owner_name === "q1__deleteReport") {
                if (res) {
                    model_SQLQiueries.updateModel();
                }
            }
            if (owner_name === "q1__updateReports") {
                if (res) {
                    model_SQLQiueries.updateModel();

                    /// после обновления занных в запросе обновляется модель таблицы и перерисовывается сама таблица
                    var SQLquery = txt_FieldQuerySQL.text;
                    if ( SQLquery.lenght <= 0 ) { //if ( SQLquery === "" || SQLquery === " " )
                        rect_Table.createEmptyTable_fun("SQL запрос отсутсвует");
                    }
                    else {
                        SQLquery = " " + SQLquery + " ";
                        rect_Table.destroyObj_fun();
                        model_tableReports.setQueryDB(SQLquery);
                        txt_ReportNameFromDB.reportName = txt_ReportName.text;
                    }

                }
            }
            if (owner_name === "q1__loadFileForReport") {
                if (res) {
                    console.log(" loadFileForReport: ", var_res["DOCX"], var_res["DOCM"], var_res["REPORTNAME"]);
                    FileManager.saveFile(var_res["DOCX"],"","report1", "docx")
                    FileManager.saveFile(var_res["DOCM"],"","macro_1", "docm")

                    /// запускается создание отчета, затем данные очищаются
                    report.beginCreateReportFile();
                    report.showZ();
                    report.clearZ();
                }
            }
        }

    }


    Frame {
        id: frame_page_header

        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: space_margin
        padding: 1
        topPadding: 1
        bottomPadding: 1
        leftPadding: 30

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
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                color: "#808080"
                text: "ОТЧЕТЫ"
            }
            ToolSeparator {}
            Text {
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 20 //main_.sizeTxt
                font.bold: true
                color: "#808080"
                text: "SQL ЗАПРОСЫ"
            }
        }


//        Label {
//            anchors.centerIn: parent
//            text: "ОТЧЕТЫ"
//            font.pixelSize: 14
//            font.bold: true
//        }

    }

    /// линия между списком запросов и таблицей для их растягивания и масштабирования
    Rectangle {
        id: rect_ScaleLine
        anchors.top: frame_page_header.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom

        x: 380

        width: 20
        color: "transparent" // "Green"

        MouseArea {
            anchors.fill: parent


            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 200
            drag.maximumX: 600 //repeter_headers.itemAt(index).width //1000

            hoverEnabled: true
            onEntered:  {}
            onExited:   {}
            onPressed:  {}
            onReleased: {}
            onClicked:  {}

            CursorShapeArea {
                anchors.fill: parent
                cursorShape: Qt.SplitHCursor // Qt.OpenHandCursor //Qt.PointingHandCursor
            }


        }

    }


    Rectangle {
        id: rectMain_SQLQueries
        anchors.top: frame_page_header.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20

        anchors.right: rect_ScaleLine.left
        //width: 350


        //border.color: "LightGray"
        color: "transparent"

        Rectangle {
            id: rect_SQLQueries_header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50


            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7

            Text {
                anchors.centerIn: parent
                text: "Список SQL запросов"
                font.pixelSize: 14
                font.bold: true
                color: "#808080"
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                width: 40
                height: 40
                color: "transparent"
                border.color: "LightGray"
                radius: 7
                Text {
                    id: txtButton_addQuery
                    anchors.centerIn: parent
                    text: "+"
                    font.pixelSize: 20
                    color: "LightGray"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { parent.border.color = "#4CAF50";   txtButton_addQuery.color = "#4CAF50" }
                    onExited:   { parent.border.color = "LightGray"; txtButton_addQuery.color = "LightGray" }
                    onPressed:  { parent.color = "#f6ffed"; }
                    onReleased: { parent.color = "transparent" }
                    onClicked:  { popup_addQuery.type = "add"; popup_addQuery.open()}
                }

            }

            Popup {
                id: popup_addQuery
                property string type /// при вызове окна необходимо указать тип: add или update
                property bool scripNew: false    /// при выборе файла из диалогового файлового окна меняется на true
                property bool patternNew: false  /// при выборе файла из диалогового файлового окна меняется на true



                width: addQuery.width// + padding*2
                height: addQuery.height// + padding*2
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape
                parent: Overlay.overlay
                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                padding: 0

                onClosed: { clearFilds() }
                onOpened: { scripNew = false; patternNew = false }

                background:
                    Rectangle {
                    anchors.fill: parent
                    //color: "Transparent" //"White" Material.color(Material.Grey, Material.Shade200)

                    radius: 5
                    //opacity: 0.9
                }


                function setDataInFilds(querySQL, description, reportName) {
                    txt_ReportName.reportName = reportName;
                    txt_FieldQuerySQL.text = querySQL
                    txt_FieldQueryDescription.text = description

                    //openFileDialog.clearSelection();

                    txt_ScriptFileName.text  = "";
                    txt_ScriptFileName.fileUrl = "";

                    txt_PatternFileName.text = "";
                    txt_PatternFileName.fileUrl = "";
                }

                function clearFilds(){
                    txt_FieldQuerySQL.text = ""
                    txt_FieldQueryDescription.text = ""
                    openFileDialog.clearSelection();

                    txt_ScriptFileName.text  = "";
                    txt_ScriptFileName.fileUrl = "";

                    txt_PatternFileName.text = "";
                    txt_PatternFileName.fileUrl = "";
                }


                Item {
                    id: addQuery
                    height: 700
                    width:  600

                    /// функция формирует из словарей модель listModel_helpWorldList слов с типами секций
                    function setModelHelpWordList(word,openAlways) {
                        listModel_helpWorldList.clear();

                        /// словари по разделам
                        var wordbook_instruction = ["SELECT","WHERE","FROM"];
                        var wordbook_tables = ["EXT_PERSON","EXT_DOSE","ADM_ASSIGNEMENT","ADM_NUCLIDE","ADM_ORGANIZATION","ADM_DEPARTMENT_INNER","ADM_STATUS"];
                        var wordbook_table_EXT_PERSON = ["ID_PERSON","W_NAME","W_SURNAME","W_PATRONYMIC","PHOTO","STATUS_CODE","SEX","BIRTH_DATE","WEIGHT","HEIGHT"];

                        if (!openAlways) {
                            for (var i = 0; i < wordbook_instruction.length; i ++) {
                                if (wordbook_instruction[i].indexOf(word) === 0) {
                                    listModel_helpWorldList.append( { helpWord: wordbook_instruction[i], type: "команды" })
                                }
                            }
                            for (var i = 0; i < wordbook_tables.length; i ++) {
                                if (wordbook_tables[i].indexOf(word) === 0) {
                                    listModel_helpWorldList.append( { helpWord: wordbook_tables[i], type: "таблицы" })
                                }
                            }
                            for (var i = 0; i < wordbook_table_EXT_PERSON.length; i ++) {
                                if (wordbook_table_EXT_PERSON[i].indexOf(word) === 0) {
                                    listModel_helpWorldList.append( { helpWord: wordbook_table_EXT_PERSON[i], type: "EXT_PERSON" })
                                }
                            }
                        }
                        /// если необходимо вывести весь список слов.
                        /// в listModel_helpWorldList записывается весь словарь (при нажатии ctrl + пробел открывается список со всеми возможными словами)
                        else {
                            for (var i = 0; i < wordbook_instruction.length; i ++) {
                                listModel_helpWorldList.append( { helpWord: wordbook_instruction[i], type: "команды" })
                            }
                            for (var i = 0; i < wordbook_tables.length; i ++) {
                                listModel_helpWorldList.append( { helpWord: wordbook_tables[i], type: "таблицы" })
                            }
                            for (var i = 0; i < wordbook_table_EXT_PERSON.length; i ++) {
                                listModel_helpWorldList.append( { helpWord: wordbook_table_EXT_PERSON[i], type: "EXT_PERSON" })
                            }
                        }
                    }

                    /// функция формирует из словаря и открывает(или не открывает если параметр word пустой) список-подсказку ключевых слов
                    function openHelpWordList(word,x,y, openAlways) {
                        //console.log(" (!) openHelpWordList...",word,x,y,openAlways)
//                        listModel_helpWorldList.clear();
                        if ( word === undefined) {
                            if ( popup_helpWorldList.opened ) popup_helpWorldList.close();
                            return;
                        }

                        /// словарь ключевых слов
                        var wordbook = ["SELECT","WHERE","FROM","EXT_PERSON","EXT_DOSE","ADM_ASSIGNEMENT","ADM_NUCLIDE","ADM_ORGANIZATION","ADM_DEPARTMENT_INNER","ADM_STATUS"]
                        /// словари по разделам
                        var wordbook_instruction = ["SELECT","WHERE","FROM"];
                        var wordbook_tables = ["EXT_PERSON","EXT_DOSE","ADM_ASSIGNEMENT","ADM_NUCLIDE","ADM_ORGANIZATION","ADM_DEPARTMENT_INNER","ADM_STATUS"];
                        var wordbook_table_EXT_PERSON = ["ID_PERSON","W_NAME","W_SURNAME","W_PATRONYMIC","PHOTO","STATUS_CODE","SEX","BIRTH_DATE","WEIGHT","HEIGHT"];



                        if ( word.length > 0 ) {
                            setModelHelpWordList(word,false)
                        }
                        /// если длинна слова меньше нуля, то смотрим на openAlways
                        else {
                            /// если openAlways = true, то в listModel_helpWorldList записывается весь словарь (при нажатии ctrl + пробел открывается список со всеми возможными словами)
                            if (openAlways) {
                                setModelHelpWordList(word,true)
                            }
                             /// если openAlways = flse, закрываем список(если он октрыт) и завершаем функцию
                            else {
                                if ( popup_helpWorldList.opened ) popup_helpWorldList.close();
                                return;
                            }
                        }

//                        /// если openAlways = true, то в listModel_helpWorldList записывается весь словарь (при нажатии ctrl + пробел открывается список со всеми возможными словами)
//                        if (openAlways) {
//                            if ( word.length > 0 ) {
//                                for (var i = 0; i < wordbook.length; i ++) {
//                                    if (wordbook[i].indexOf(word) === 0) {
//                                        listModel_helpWorldList.append( { helpWord: wordbook[i] })
//                                    }
//                                }
//                            }
//                            else {
//                                for (var i = 0; i < wordbook.length; i ++) {
//                                    listModel_helpWorldList.append( { helpWord: wordbook[i] })
//                                }
//                            }

//                        }
//                        else {
//                            if ( word.length > 0 ) {
//                                for (var i = 0; i < wordbook.length; i ++) {
//                                    if (wordbook[i].indexOf(word) === 0) {
//                                        listModel_helpWorldList.append( { helpWord: wordbook[i] })
//                                    }
//                                }
//                            }
//                            /// если длина слова < 0 закрываем список(если он октрыт) и завершаем функцию
//                            else {
//                                if ( popup_helpWorldList.opened ) popup_helpWorldList.close();
//                                return;
//                            }
//                        }

                        /// открываем окно с подсказками
                        var x_helpWorldList = x - word.length * 7;
                        var y_helpWorldList = y + 25;
                        popup_helpWorldList.word = word;
                        popup_helpWorldList.x = x_helpWorldList;
                        popup_helpWorldList.y = y_helpWorldList;
                        popup_helpWorldList.open();


                    }


                    /// Всплывающий лист-подсказка с набором слов, начинающихся на символы, вводимые в txt_FieldQuerySQL
                    Popup {
                        id: popup_helpWorldList
                        property string word

                        width: 80 //listView_helpWorldList.width
                        height: listView_helpWorldList.contentHeight + 5
                        //modal: true
                        //focus: true


                        opacity: 0.8
                        clip: true
                        background: Rectangle {
                            anchors.fill: parent
                            //radius: 5
                            color: "LightGray"
                        }

                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                        parent: flickable_txt_QuerySQL // txt_FieldQuerySQL //popup_addQuery // //Overlay.overlay
                        x: 100 // Math.round((parent.width - width) / 2)
                        y: 200 // Math.round((parent.height - height) / 2)
                        //z: 3
                        onClosed: { width = 0 }
                        padding: 0



                        ListView {
                            id: listView_helpWorldList
                            anchors.fill: parent
                            //property var currentItemTxt
//                            anchors.top:     parent.top
//                            anchors.bottom:  parent.bottom
//                            anchors.left:    parent.left
//                            width: 0
                            //anchors.leftMargin: 5


                            highlightFollowsCurrentItem: true
                            highlight: Rectangle {
                                color: "#ebebeb"
                            }
                            highlightMoveDuration: 100


                            model: //["SLELCT","WHERE","FROM","EXT_PERSON","EXT_DOSE"]
                                   ListModel {
                                id: listModel_helpWorldList
                            }
                            delegate: ItemDelegate {
                                id: delegate_helpWorldList
                                height: 30
                                anchors.left: parent.left
                                anchors.right: parent.right
                                //width: txt_helpWorldList.contentWidth + 50

                                Component.onCompleted: {
                                    var width = txt_helpWorldList.contentWidth + 20;
                                    if ( index == 0 ) {
                                        popup_helpWorldList.width = 80; //width;
                                    }
                                    if ( popup_helpWorldList.width < width )
                                    {
                                        popup_helpWorldList.width = width;
                                    }
                                    //console.log(" (!) width: ", width, popup_helpWorldList.width);
                                }

                                Text {
                                    id: txt_helpWorldList
                                    //anchors.centerIn: parent
                                    anchors.verticalCenter: parent.verticalCenter
                                    anchors.left: parent.left
                                    anchors.leftMargin: 5
                                    color: page_reports.text_color
                                    font.pixelSize: 12
                                    text: helpWord // modelData //helpWord
                                }

                                onClicked: {
                                    if (listView_helpWorldList.currentIndex !== index) {
                                        listView_helpWorldList.currentIndex = index
                                    }

                                    var wordChange = helpWord.slice(popup_helpWorldList.word.length, helpWord.length);
                                    txt_FieldQuerySQL.insert( txt_FieldQuerySQL.cursorPosition, wordChange ) //append(wordChange)

                                }

                            }



                            section.property: "type"
                            section.criteria: ViewSection.FullString
                            section.delegate: Rectangle {
                                width: parent.width
                                height: 20 //childrenRect.height
                                color: "Transparent" //"lightsteelblue"
                                Text {
                                    anchors.centerIn: parent
                                    text: "- " + section + " -"
                                    font.bold: true
                                    font.pixelSize: 11
                                    color: page_reports.text_color
                                }
                            }


                        }

                    }




                    /// Рамка с полем имени отчета
                    Rectangle {
                        id: rect_NameReport
                        anchors.top: parent.top
                        height: 50
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.margins: 10
                        color: "transparent"
                        //border.color: "LightGray"

                        RowLayout {
                            anchors.fill: parent
                            anchors.left: parent.left
                            anchors.leftMargin: 40
                            anchors.right: parent.right
                            anchors.rightMargin: 20

                            spacing: 20

                            Label {
                                //anchors.verticalCenter: parent.verticalCenter
                                text: qsTr("Имя отчета")
                                font.pixelSize: 15
                            }
                            TextField {
                                id: txt_ReportName
                                property string reportName

                                //anchors.verticalCenter: parent.verticalCenter
                                //width: 250
                                Layout.fillWidth: true

                                selectionColor: Material.color(Material.Red)
                                selectByMouse: true
                                //placeholderText: "Report"
                                text: ( reportName.length == 0 ) ? "Report" : reportName
                                onFocusChanged: {
                                    if (focus) { select(0, text.length) }
                                }

                            }
                        }


                    }

                    TabBar {
                        id: tabbar_typeGetQuery
                        anchors.top: parent.top
                        anchors.topMargin: 80
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        contentHeight: 30
                        currentIndex: 1 //0
                        font.pixelSize: 14
                        background: Rectangle { color: "LightGray" }
                        TabButton {
                            text: "Конструктор запроса"
//                            contentItem: Text {
//                                text: parent.text
//                                font.pixelSize: 14
//                                horizontalAlignment: Text.AlignHCenter
//                                verticalAlignment: Text.AlignVCenter
//                            }
                            width: implicitWidth
                            //height: 30//implicitHeight
                        }
                        TabButton {
                            text: "SQL запрос"
                            width: implicitWidth
                            //height: 30 //implicitHeight
                        }

                    }

                    StackLayout {
                        id: stackLayout_typeSetQuery
                        height: 300
                        //anchors.bottom: parent.bottom
                        anchors.top: tabbar_typeGetQuery.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.leftMargin: 10
                        anchors.rightMargin: 10
                        //anchors.margins: 10
                        currentIndex: tabbar_typeGetQuery.currentIndex

                        Item {
                            Rectangle {
                                id: rect_constructorQuery
                                anchors.fill: parent
                                border.color: "LightGray"
                            }
                        }

                        /// ФОРМА ДЛЯ НАПИСАНИЯ SQL ЗАПРОСА
                        Item {
                            Rectangle {
                                id: rect_QuerySQL
                                anchors.fill: parent
//                                anchors.top: parent.top
//                                anchors.topMargin: 80
//                                height: 300
//                                anchors.right: parent.right
//                                anchors.left: parent.left
//                                anchors.margins: 10

                                Rectangle {
                                    id: rect_FieldQuerySQL
                                    anchors.fill: parent
                                    border.color: "LightGrey"

                                    clip: true

                                    Rectangle {
                                        id: rect_menuQuerySQL
                                        anchors.top: parent.top
                                        height: 30
                                        anchors.right: parent.right
                                        anchors.left: parent.left
                                        anchors.margins: 1
                                        color: "Transparent" // "LightGray"

                                        Rectangle {
                                            anchors.bottom: parent.bottom
                                            anchors.left:   parent.left
                                            anchors.right:  parent.right
                                            height: 1
                                            anchors.bottomMargin: -1
                                            color: "LightGray"
                                        }

                                        RowLayout {
                                            anchors.fill: parent
                                            spacing: 0

                                            /// кнопка: добаить имя поля из таблицы
                                            Rectangle {
                                                id: button_AddField
                                                Layout.minimumHeight: parent.height
                                                Layout.minimumWidth: labelAddField.width
                                                Layout.fillWidth: true
                                                color: "white" // "LightGray"

                                                Behavior on color {
                                                    ColorAnimation { duration: 200 } //NumberAnimation //ColorAnimation
                                                }

                                                Text  {
                                                    id: labelAddField
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    text: "Добавить поле"
                                                    color: page_reports.text_color //"#a1a1a1"
                                                    font.pixelSize: 14
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered:  { parent.color = "LightGray"; }
                                                    onExited:   { parent.color = "white";     }
                                                    //onPressed:  { parent.color = "#f6ffed" }
                                                    //onReleased: { parent.color = "transparent" }
                                                    onClicked:  {

                                                    }
                                                }
                                            }

                                            /// кнопка: добаить имя таблицы
                                            Rectangle {
                                                id: button_addTable
                                                Layout.minimumHeight: parent.height
                                                Layout.minimumWidth: labeladdTable.width
                                                Layout.fillWidth: true
                                                color: "white" // "LightGray"

                                                Behavior on color {
                                                    ColorAnimation { duration: 200 }
                                                }

                                                Text  {
                                                    id: labeladdTable
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    text: "Добавить таблицу"
                                                    color: page_reports.text_color
                                                    font.pixelSize: 14
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered:  { parent.color = "LightGray"; }
                                                    onExited:   { parent.color = "white";     }
                                                    //onPressed:  { }
                                                    //onReleased: { }
                                                    onClicked:  {

                                                    }
                                                }
                                            }

                                            /// кнопка: добаить параметр
                                            Rectangle {
                                                id: button_addParam
                                                Layout.minimumHeight: parent.height
                                                Layout.minimumWidth: labeladdParam.width
                                                Layout.fillWidth: true
                                                color: "white" // "LightGray"

                                                Behavior on color {
                                                    ColorAnimation { duration: 200 }
                                                }

                                                Text  {
                                                    id: labeladdParam
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    text: "Добавить параметр"
                                                    color: page_reports.text_color
                                                    font.pixelSize: 14
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered:  { parent.color = "LightGray"; }
                                                    onExited:   { parent.color = "white";     }
                                                    //onPressed:  { }
                                                    //onReleased: { }
                                                    onClicked:  {
                                                        popup_setParam.open();
                                                    }
                                                }
                                            }

                                            Rectangle {
                                                Layout.minimumHeight: parent.height
                                                Layout.minimumWidth: 1
                                                //Layout.fillWidth: true
                                                color: "LightGray"
                                            }

                                            /// кнопка: вытащить текст SQL запроса из файла
                                            Rectangle {
                                                id: button_LoadSQLquery
                                                Layout.minimumHeight: parent.height
                                                Layout.minimumWidth: labelLoadSQLquery.width + 10
                                                color: "white" // "LightGray"

                                                Behavior on color {
                                                    ColorAnimation { duration: 200 } //NumberAnimation //ColorAnimation
                                                }

                                                Text  {
                                                    id: labelLoadSQLquery
                                                    anchors.verticalCenter: parent.verticalCenter
                                                    anchors.horizontalCenter: parent.horizontalCenter
                                                    text: "Загрузить запрос из файла"
                                                    color: page_reports.text_color //"#a1a1a1"
                                                    font.pixelSize: 14
                                                }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered:  { parent.color = "LightGray";   /*labelLoadSQLquery.color =  "#444444"*/ }
                                                    onExited:   { parent.color = "white";       /*labelLoadSQLquery.color =  "#a1a1a1"*/ }
                                                    //onPressed:  { parent.color = "#f6ffed" }
                                                    //onReleased: { parent.color = "transparent" }
                                                    onClicked:  {
                                                        openFileDialog.typeFile = "sql"
                                                        openFileDialog.nameFilters = [ "SQL file (*.txt *.sql)" ] //, "All files (*)"
                                                        openFileDialog.open();
                                                    }
                                                }
                                            }

                                        }

                                        Popup {
                                            id: popup_setParam
                                            width: itrm_setParam.width + padding*2
                                            height: itrm_setParam.height + padding*2
                                            modal: true
                                            focus: true
                                            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside //Popup.NoAutoClose
                                            parent: Overlay.overlay
                                            x: Math.round((parent.width - width) / 2)
                                            y: Math.round((parent.height - height) / 2)
                                            padding: 0

                                            background:
                                                Rectangle {
                                                anchors.fill: parent
                                                radius: 5
                                            }

                                            Item {
                                                id: itrm_setParam
                                                height: 180 //contentHeight //100
                                                width:  300



                                                ColumnLayout {
                                                    anchors.fill: parent
                                                    anchors.margins: 5

                                                    Item {
                                                        Layout.fillWidth: true
                                                        Layout.fillHeight: true
                                                        //Layout.minimumHeight: 20
                                                        Text {
                                                            anchors.verticalCenter:   parent.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                            font.pixelSize: 16
                                                            color: page_reports.text_color
                                                            text: qsTr("Название параметра")
                                                        }
                                                    }
                                                    Item {
                                                        Layout.fillWidth: true
                                                        Layout.fillHeight: true
                                                        //Layout.minimumHeight: 20
                                                        TextField {
                                                            id: txt_setParam
                                                            anchors.verticalCenter:   parent.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                            font.pixelSize: 14
                                                            color: page_reports.text_color
                                                            selectByMouse: true
                                                            selectionColor: Material.color(Material.Red)
                                                            horizontalAlignment: Text.AlignHCenter
                                                            text: qsTr("Parameter")
                                                            onFocusChanged: {
                                                                if (focus) { select(0, text.length) }
                                                            }
                                                        }
                                                    }
                                                    Item {
                                                        Layout.fillWidth: true
                                                        Layout.minimumHeight: 90
                                                        Button {
                                                            anchors.verticalCenter:   parent.verticalCenter
                                                            anchors.horizontalCenter: parent.horizontalCenter
                                                            font.pixelSize: 14
                                                            text: qsTr("OK")
                                                            onClicked: {
                                                                var txtparam = "#param(" + txt_setParam.text + ")#"
                                                                txt_FieldQuerySQL.insert(txt_FieldQuerySQL.cursorPosition, txtparam)
                                                                popup_setParam.close();
                                                            }
                                                        }
                                                    }


                                                }


                                            }
                                        }

                                    }


                                    Flickable {
                                        id: flickable_txt_QuerySQL
                                        anchors.top: rect_menuQuerySQL.bottom
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        anchors.bottom: parent.bottom
                                        //anchors.fill: parent
                                        //anchors.margins: 2
                                        anchors.leftMargin: 5
                                        anchors.rightMargin: 5

                                        ScrollBar.vertical: ScrollBar { }

                                        TextArea.flickable: TextArea { //TextArea
                                            id: txt_FieldQuerySQL
                                            property bool isOk
                                            property var censure: ""
                                            property bool processing: false
                                            selectByMouse: true
                                            wrapMode: TextEdit.WrapAnywhere // TextEdit.WordWrap
                                            font.capitalization: Font.AllUppercase
                                            selectionColor: Material.color(Material.LightGreen)
                                            textFormat: Text.RichText /// для использования html форматирования текста

                                            background: Rectangle {
                                                color:"transparent"
                                                //border.color: "red"
                                            }


                                            /// определяет напечатанное слово до местоположения курсора
                                            function printWord() {
                                                var cursorPosition = txt_FieldQuerySQL.cursorPosition;
                                                var txt = getText(0, length).toUpperCase();
                                                var i_print_word = "";

                                                if (txt.length > 0) {
                                                    var begin_word = false;
                                                    var print_word = "";
                                                    i_print_word = cursorPosition - 1; //txt.length;
                                                    // var re = new RegExp(txt_param.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), "gi");
                                                    // var re = new RegExp(/[.*+?^${}()|[\]\\]/);
                                                    // var simbols = "[.*+?^${}()|[\]\\] ";
                                                    var simbols = "QWERTYUIOPASDFGHJKLZXCVBNMЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ._";
                                                    while (!begin_word) {
                                                        if ( ~simbols.indexOf(txt.charAt(i_print_word)) ) {
                                                            print_word = print_word + txt.charAt(i_print_word);
                                                        }
                                                        else {
                                                            begin_word = true;
                                                        }
                                                        if(i_print_word <= 0) {
                                                            break;
                                                        }
                                                        i_print_word --;
                                                    }
                                                    print_word = print_word.split("").reverse().join(""); /// переворачивает слово
                                                    //console.log(" (!) print_word = ", print_word);
                                                }

                                                return print_word;
                                            }

                                            Keys.onReleased: {
                                                var print_word;
                                                if (event.key == Qt.Key_Left) {
                                                    /// определяем слово напечатанное до изменившегося местоположения курсора
                                                    if (txt_FieldQuerySQL.cursorPosition > 0) {
                                                        print_word = printWord();
                                                        /// вызываем функцию, которая открывает список-подсказку со словами
                                                        addQuery.openHelpWordList(print_word,cursorRectangle.x,cursorRectangle.y, false);
                                                    }
                                                }
                                                if (event.key == Qt.Key_Right) {
                                                    /// определяем слово напечатанное до изменившегося местоположения курсора
                                                    if (txt_FieldQuerySQL.cursorPosition < length) {
                                                        print_word = printWord();
                                                        /// вызываем функцию, которая открывает список-подсказку со словами
                                                        addQuery.openHelpWordList(print_word,cursorRectangle.x,cursorRectangle.y, false);
                                                    }
                                                }
                                            }

                                            Keys.onPressed: {
                                                if (event.key == Qt.ControlModifier || event.key == Qt.Key_Space) {
                                                    /// определяем слово напечатанное до местоположения курсора
                                                    var print_word = printWord();
                                                    if (print_word === undefined) {
                                                        print_word = "";
                                                    }
                                                    addQuery.openHelpWordList(print_word,cursorRectangle.x,cursorRectangle.y, true)
                                                }

                                                if (event.key == Qt.Key_Down) {
                                                    if (popup_helpWorldList.opened) {
                                                        if (listView_helpWorldList.currentIndex < listView_helpWorldList.count-1) {
                                                            listView_helpWorldList.currentIndex++;
                                                        }
                                                    }
                                                    else { txt_FieldQuerySQL.cursorPosition = txt_FieldQuerySQL.cursorPosition + txt_FieldQuerySQL.lineCount }
                                                    event.accepted = true;
                                                }
                                                else if (event.key == Qt.Key_Up) {
                                                    if (popup_helpWorldList.opened) {
                                                        if (listView_helpWorldList.currentIndex > 0) {
                                                            listView_helpWorldList.currentIndex--;
                                                        }
                                                    }
                                                    else {
                                                        console.log(" (!) txt_FieldQuerySQL.lineCount = ", txt_FieldQuerySQL.lineCount );
                                                        txt_FieldQuerySQL.cursorPosition = txt_FieldQuerySQL.cursorPosition - txt_FieldQuerySQL.lineCount
                                                    }
                                                    event.accepted = true;
                                                }
                                                else if ( event.key == Qt.Key_Return ) {
                                                    if (popup_helpWorldList.opened) {
                                                        if ( listModel_helpWorldList.get(listView_helpWorldList.currentIndex) !== undefined ) {
//                                                            console.log(" (!) listView_helpWorldList = ", listModel_helpWorldList.get(listView_helpWorldList.currentIndex).helpWord);
                                                            var wordChange = listModel_helpWorldList.get(listView_helpWorldList.currentIndex).helpWord;
                                                            wordChange = wordChange.slice(popup_helpWorldList.word.length, wordChange.length);
                                                            txt_FieldQuerySQL.insert( txt_FieldQuerySQL.cursorPosition, wordChange ) //append(wordChange)
                                                        }

                                                    }
                                                    else {
                                                        //txt_FieldQuerySQL.cursorPosition = txt_FieldQuerySQL.cursorPosition + txt_FieldQuerySQL.length*txt_FieldQuerySQL.lineCount;
                                                        //txt_FieldQuerySQL.insert(txt_FieldQuerySQL.cursorPosition, "<br>");
                                                    }
                                                    event.accepted = true;
                                                }

                                            }

                                            onTextChanged: {
                                                if (!processing) {
                                                    processing = true;
                                                    var cursorPosition = txt_FieldQuerySQL.cursorPosition;
                                                    var txt = getText(0, length).toUpperCase();

                                                    if (txt.length > 0) {
                                                        /// определяем слово напечатанное до местоположения курсора
                                                        var print_word = printWord();
                                                        //console.log(" (!) print_word = ", print_word);
                                                        /// вызываем функцию, которая открывает список-подсказку со словами
                                                        addQuery.openHelpWordList(print_word,cursorRectangle.x,cursorRectangle.y, false);


                                                        ///////////////////////////////////////////////////////////////////////////////////////
                                                        /// выделяет красным цветом текст, в случае нахождения в нем недопустимых SQL команд
                                                        if(~txt.indexOf("DELETE")  || ~txt.indexOf("ADD") || ~txt.indexOf("INSERT") || ~txt.indexOf("UPDATE")) {
                                                            //console.log(" --!CENSURE!-- ");
                                                            color = "#ff0000";
                                                            isOk = false;
                                                            censure = "Некорректный запрос: недопускается использование слов DELETE, ADD, INSERT, UPDATE"
                                                        }
                                                        else {
                                                            color = "black";
                                                            isOk = true;
                                                            censure = "";
                                                        }

                                                        ///////////////////////////////////////////////////////////////////////////////////////
                                                        /// выделяет цветом параметры (заменяя текст на текст с html тегами цвета)
                                                        var txt_tmp = txt;

                                                        if(~txt.indexOf("#PARAM(")) {
                                                            //                                                            var txt_param = "#PARAM(";
                                                            //                                                            var txt_param_color = "<span  style='color:#9cc17f'>" + txt_param + "</span >";
                                                            //                                                            var re = new RegExp(txt_param.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), "gi");
                                                            //                                                            txt = txt.replace(re, txt_param_color);
                                                            //                                                            console.log("(!) txt_replace = ", txt);


                                                            var txt_param = "";
                                                            var count_param = 0; //число параметров
                                                            var i_param = txt.indexOf("#PARAM(");

                                                            while (i_param !== -1) {
                                                                if (~txt_tmp.indexOf( ")#", i_param + 7 )) {
                                                                    txt_param = "";
                                                                    for ( var i = i_param; i < txt_tmp.indexOf( ")#", i_param + 7 ) + 2; i++) {
                                                                        txt_param = txt_param + txt_tmp.charAt(i);
                                                                    }
                                                                    //console.log("(!) txt_param = ", txt_param);
                                                                    var txt_param_color = "<span style='color:#9cc17f'>" + txt_param + "</span>" //" (!)ЗАМЕНА(!) " //
                                                                    //var txt_param_re = new RegExp(txt_param.replace(/[.*+?^${}()|[\]\\]/g, '\\$&'), "gi");
                                                                    txt_tmp = txt_tmp.replace(txt_param,txt_param_color) //txt_param_re
                                                                    i_param = txt_tmp.indexOf('#PARAM(', i_param + txt_param_color.length);
                                                                    //console.log( "(!) txt_tmp = ", txt_tmp , " i_param = ", i_param);
                                                                }
                                                                else {
                                                                    i_param = -1;
                                                                }
                                                                count_param ++;
                                                            }
                                                        }


                                                    }
                                                    else { isOk = false }

                                                    //console.log("(!) txt_tmp = ", txt_tmp);
                                                    if(txt_tmp != undefined) {                                                        
                                                        txt_FieldQuerySQL.text = txt_tmp;
                                                        txt_FieldQuerySQL.cursorPosition = cursorPosition;
                                                    }
                                                    processing = false;
                                                }


                                            }

                                            ToolTip {
                                                id: toolTip_CENSURE
                                                parent: txt_FieldQuerySQL //.handle
                                                text: (txt_FieldQuerySQL.censure === "") ? qsTr("OK") : qsTr(txt_FieldQuerySQL.censure)  //qsTr("Некорректный запрос")
                                                y: parent.y - 35 //parent.height
                                                //x: parent.x
                                                font.pixelSize: 15
                                                visible: txt_FieldQuerySQL.censure
                                                delay: 200 //задержка
                                                contentItem: Text {
                                                    text: toolTip_CENSURE.text
                                                    font: toolTip_CENSURE.font
                                                    color: "white" // "white" //"#21be2b"
                                                }
                                                //  background: Rectangle {
                                                //      border.color: "#21be2b"
                                                //  }
                                            }
                                        }
                                    }
                                }

                            }

                        }

                    }



                    /// ФОРМА ДЛЯ НАПИСАНИЯ ОПИСАНИЯ ЗАПРОСА
                    Rectangle {
                        id: rect_description
                        anchors.top: stackLayout_typeSetQuery.bottom
                        anchors.bottom: rect_ScriptPattern.top
                        anchors.right: parent.right
                        anchors.left: parent.left
                        anchors.margins: 10
                        //color: "LightGray" // "transparent"

                        /// заголовок описания
                        Rectangle {
                            id: rect_header_description
                            anchors.top: parent.top
                            height: 30
                            anchors.right: parent.right
                            anchors.left: parent.left
                            color: "LightGray"
                            Label {
                                anchors.verticalCenter: parent.verticalCenter
                                anchors.left: parent.left
                                anchors.leftMargin: 40
                                text: "Описание"
                            }
                        }

                        Rectangle {
                            id: rect_FieldDescription
                            anchors.top: rect_header_description.bottom
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.right: parent.right

                            border.color: "LightGrey"

                            clip: true

                            Flickable {
                                id: flickable_txt_Description
                                anchors.fill: parent
                                //anchors.margins: 2
                                anchors.leftMargin: 5
                                anchors.rightMargin: 5

                                ScrollBar.vertical: ScrollBar { }

                                TextArea.flickable: TextArea {
                                    id: txt_FieldQueryDescription
                                    selectByMouse: true
                                    wrapMode: TextEdit.WordWrap // | TextEdit.WrapAnywhere
                                    //Material.accent: Material.LightGreen
                                    selectionColor: Material.color(Material.LightGreen)
                                    background: Rectangle {
                                        color:"transparent"
                                        //border.color: "red"
                                    }
                                }
                            }
                        }
                    }

                    /// ФОРМА ДЛЯ КНОПОК ЗАГРУЗКИ ФАЙЛОВ ШАБЛОНА И СКРИПТА
                    Rectangle {
                        id: rect_ScriptPattern
                        anchors.left: parent.left
                        anchors.leftMargin: 20
                        anchors.right: parent.horizontalCenter
                        anchors.rightMargin: 20
                        anchors.bottom: button_addQuery.top
                        anchors.bottomMargin: 10
                        height: 110
                        //border.color: "LightGray"
                        color: "transparent"
                        Column {
                            anchors.fill: parent
                            spacing: 10

                            Row {
                                spacing: 10
                                Button {
                                    text: "Скрипт"
                                    width: 90
                                    onClicked: {
                                        openFileDialog.typeFile = "docm"
                                        //openFileDialog.selectedNameFilter = "Script file (*.docm)"
                                        //openFileDialog.setNameFilters( "Script file (*.docm)" )
                                        openFileDialog.nameFilters = [ "Script file (*.docm)" ] //, "All files (*)"
                                        openFileDialog.open();
                                    }
                                }
                                TextEdit {
                                    id: txt_ScriptFileName
                                    property var fileUrl: ""
                                    property var fileName
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 150
                                    selectionColor: Material.color(Material.Red)
                                    selectByMouse: true
                                    font.pixelSize: 15
                                    //placeholderText: (fileUrl == "") ? "имя файла скрипта..." : fileName
                                    //text: (fileUrl == "") ? "имя файла скрипта..." : fileName
//                                    onTextChanged: {
//                                        fileName = text;
//                                    }
                                }
                            }

                            Row {
                                spacing: 10
                                Button {
                                    text: "Шаблон"
                                    width: 90
                                    onClicked: {
                                        openFileDialog.typeFile = "docx"
                                        //openFileDialog.selectedNameFilter = "Pattern file (*.docx)"
                                        //openFileDialog.setNameFilters( "Pattern file (*.docx)")
                                        openFileDialog.nameFilters = [ "Pattern file (*.docx)" ] //, "All files (*)"
                                        openFileDialog.open();
                                    }
                                }
                                TextEdit {
                                    id: txt_PatternFileName
                                    property var fileUrl: ""
                                    property var fileName
                                    anchors.verticalCenter: parent.verticalCenter
                                    width: 150
                                    selectionColor: Material.color(Material.Red)
                                    selectByMouse: true
                                    font.pixelSize: 15
                                    //text: (fileUrl == "") ? "имя файла шаблона..." : fileName
//                                    onTextChanged: {
//                                        fileName = text;
//                                    }
                                }
                            }


                        }

                    }

                    /// рамка со вспомогательными сообщениями
                    Rectangle {
                        id: rect_Info
                        anchors.left: rect_ScriptPattern.right
                        anchors.leftMargin: 20
                        anchors.right: parent.right
                        anchors.rightMargin: 20
                        anchors.bottom: button_addQuery.top
                        anchors.bottomMargin: 10
                        height: 110
                        border.color: "LightGray"
                        color: "transparent"

                        Text {
                            anchors.top: parent.top
                            anchors.topMargin: 10
                            anchors.bottom: parent.bottom
                            anchors.left: parent.left
                            anchors.leftMargin: 15
                            anchors.right: parent.right
                            anchors.rightMargin: 15
                            font.pixelSize: 14
                            color: "#757575"
                            wrapMode: TextEdit.WordWrap
                            text: {
                                var str = "";

                                if (txt_FieldQuerySQL.isOk) { str = str + ""; }
                                else                        { str = str + "Не заполнено поле SQL запроса\n"; }
                                if (popup_addQuery.type != "update") {
                                    if (txt_ScriptFileName.fileUrl != "")   { str = str + ""; }
                                    else                                    { str = str + "Не выбран файл скрипта\n";  }
                                    if (txt_PatternFileName.fileUrl != "")  { str = str + ""; }
                                    else                                    { str = str + "Не выбран файл шаблона\n";  }
                                }
                                if (txt_ReportName.text.length != 0)    { str = str + ""; }
                                else                                    { str = str + "Не заполнено поле имени отчета";  }

                                //                                if (txt_ScriptFileName.text != "")      { str = str + ""; }
                                //                                else                                    { str = str + "Не заполнено поле имени скрипта\n";  }
                                //                                if (txt_PatternFileName.text != "")     { str = str + ""; }
                                //                                else                                    { str = str + "Не заполнено поле имени шаблона\n";  }


                                if ( str == "") {
                                    str = "Отчет подготовлен к загрузке в базу данных"
                                }

                                return str;
                            }

                        }




                    }



                    /// окно диалога выбора файлов
                    FileDialog {
                        id: openFileDialog
                        //property var fileUrl
                        property string typeFile
                        title: "Выбирите фото"
                        folder: shortcuts.desktop //shortcuts.home
                        selectExisting: true
                        //nameFilters: [ "Script file (*.docm)", "Pattern file (*.docx)", "Image files (*.jpg *.png)", "bat files (*.bat)", "txt files (*.txt)", "All files (*)" ]
                        //nameFilters: [ "Script file (*.docm)", "Pattern file (*.docx)", "All files (*)" ]
                        onAccepted: {

                            if ( fileUrl.toString().length <= 0 ) return;


                            //console.log("You chose: " + openFileDialog2.fileUrls)
                            //var str = openFileDialog2.fileUrl;
                            //console.log("str: " + str)
                            //txt_fileName.text = fileUrl.toString().replace('file:///','')                            


                            var str = fileUrl.toString().replace('file:///','')
                            var fileName = "fileName_"
                            if (~str.indexOf("/")) {
                                str = str.split("/");
                            }
                            else if (~str.indexOf("'\'")) {
                                 str = str.split("'\'");
                            }
                            fileName = str[str.length-1];

                            if ( typeFile == "docm" ) {
                                popup_addQuery.scripNew = true;
                                txt_ScriptFileName.text = fileName; // + " (" + fileUrl.toString().replace('file:///','') + ")"
                                txt_ScriptFileName.fileUrl = fileUrl;
                                popup_addQuery
                            }
                            else if ( typeFile == "docx" )
                            {
                                popup_addQuery.patternNew = true;
                                txt_PatternFileName.text = fileName; // + " (" + fileUrl.toString().replace('file:///','') + ")"
                                txt_PatternFileName.fileUrl = fileUrl;
                            }
                            else if ( typeFile == "sql")
                            {
                                FileManager.pathFile = fileUrl;
                                //console.log(" (!) text = ", FileManager.textFromFile)
                                txt_FieldQuerySQL.text = FileManager.textFromFile;
                            }

                        }
                        onRejected: {
                            console.log("Canceled")
                            //Qt.quit()
                        }
                    }

                    /// Сообщение с информацией о добавлении в БД
                    Popup {
                        id: popup_infoAddDB
                        property alias textInfo: txt_infoAddDB.text



                        width: item_infoAddDB.width
                        height: item_infoAddDB.height
                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnEscape
                        //parent: Overlay.overlay
                        x: Math.round((parent.width - width) / 2)
                        y: Math.round((parent.height - height) / 2)
                        Item {
                            id: item_infoAddDB
                            height: txt_infoAddDB.height + 100
                            width:  300
                            Text {
                                id: txt_infoAddDB
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.top: parent.top
                                anchors.topMargin: 10
                                width: parent.width - 40
                                wrapMode: Text.WordWrap
                                font.pixelSize: 15
                                color: "#444444"
                                text: qsTr("text")
                            }
                            Button {
                                text: "OK"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.bottom: parent.bottom
                                anchors.bottomMargin: 20
                                onClicked: {
                                    popup_infoAddDB.close()
                                }
                            }
                        }
                    }

                    Button {
                        id: button_addQuery
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.horizontalCenter
                        anchors.margins: 20
                        anchors.rightMargin: 5
                        Material.background: Material.LightGreen
                        //Material.foreground: "white" //Material.Orange
                        //Material.foreground: Material.Orange

                         enabled:// (txt_FieldQuerySQL.isOk) ? true : false
                        {
                           var isOk;

                           if (txt_FieldQuerySQL.isOk) { isOk = true; }
                                                  else { return false;  }

                           if (txt_ReportName.text.length == 0)    { return false; }
                           else { isOk = true;  }

                           if (popup_addQuery.type != "update") {
                               if (txt_ScriptFileName.fileUrl == "") { return false; }
                                                                else { isOk = true;  }
                               if (txt_PatternFileName.fileUrl == "") { return false; }
                                                                 else { isOk = true;  }
                           }

//                           if (txt_ScriptFileName.text == "")    { return false; }
//                                                            else { isOk = true;  }
//                           if (txt_PatternFileName.text == "")    { return false; }
//                                                             else { isOk = true;  }


                           return isOk;
                        }

                        text: {
                            if (popup_addQuery.type == "add") {
                                return "Добавить запрос";
                            }
                            if (popup_addQuery.type == "update") {
                                return "Обновить запрос";
                            }

                        }
                        font.pixelSize: 14
                        onClicked: {
                            //var SQLquery;
                            //SQLquery = " INSERT INTO REP_SQLQUERIES ( SQLQUERY , DESCRIPTION ) VALUES ( '"
                            //           + txt_FieldQuerySQL.text + "', '" + txt_FieldQueryDescription.text + "' ) ";
                            //console.log("SQLquery ======= ", SQLquery);
                            //Query1.setQueryAndName(SQLquery, "AddReports");


                            var data_arr = {}

                            FileManager.pathFile = txt_PatternFileName.fileUrl;
                            /// проверка выбран ли новый файл шаблона в диалоговом меню ( при открытии окна "редактровать запись", сменяется на false )
                            /// если true, то, добавляем файл (проверив его размер) в набор данных для запроса
                            if (popup_addQuery.patternNew) {
                                if (FileManager.fileLenght <= 0)
                                {
                                    //console.log("Данные не были добавленны в БД: выбранный файл ШАБЛОНА имеет нулевой размер, был удален или переименован");
                                    popup_infoAddDB.textInfo = "Данные не были добавленны в БД: выбранный файл ШАБЛОНА имеет нулевой размер, был удален или переименован";
                                    popup_infoAddDB.open();
                                    txt_PatternFileName.fileUrl = "";
                                    return;
                                }
                                else
                                {
                                    data_arr["DOCX"] = FileManager.qByteArray_file;
                                }
                            }

                            /// проверка выбран ли новый файл скрипта в диалоговом меню (при редкатировании записи он становится false, считается выбранным )
                            /// если true, то, проверив размер файла, добавляем его в набор данных для запроса
                            if (popup_addQuery.scripNew) {
                                FileManager.pathFile = txt_ScriptFileName.fileUrl;
                                if (FileManager.fileLenght <= 0)
                                {
                                    //console.log("Данные не были добавленны в БД: выбранный файл СКРИПТА имеет нулевой размер, был удален или переименован");
                                    popup_infoAddDB.textInfo = "Данные не были добавленны в БД: выбранный файл СКРИПТА имеет нулевой размер, был удален или переименован";
                                    popup_infoAddDB.open();
                                    txt_ScriptFileName.fileUrl = "";
                                    return;
                                }
                                else
                                {
                                    data_arr["DOCM"] = FileManager.qByteArray_file;
                                }
                            }




                            data_arr["REPORTNAME"] = txt_ReportName.text
                            data_arr["SQL"] = txt_FieldQuerySQL.getText(0, txt_FieldQuerySQL.length) //text
                            data_arr["DESCRIPTION"] = txt_FieldQueryDescription.text


                            console.log("data_arr: ", data_arr["DOCX"], data_arr["DOCM"], data_arr["REPORTNAME"], data_arr["SQL"], data_arr["DESCRIPTION"]);
                            if (popup_addQuery.type == "add") {
                                Query1.insertRecordIntoTable("q1__addReports", "REPORTS", data_arr);
                            }
                            if (popup_addQuery.type == "update") {
                                //console.log("ОБНОВИТЬ ЗАПИСЬ...пока не обновляется =)");
                                Query1.updateRecordIntoTable("q1__updateReports", "REPORTS", data_arr, "ID", model_SQLQiueries.get(list_SQLQueries.currentIndex)["ID"] );
                            }


                            //popup_addQuery.clearFilds();
                            popup_addQuery.close();
                        }
                    }

                    Button {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.horizontalCenter
                        anchors.right: parent.right
                        anchors.margins: 20
                        anchors.leftMargin: 5
                        highlighted: true
                        Material.background: Material.LightBlue
                        //Material.foreground: Material.Orange
                        text: "Отмена"
                        font.pixelSize: 14
                        //highlighted: true
                        //Material.accent: Material.Orange
                        onClicked: {
                            //popup_addQuery.clearFilds();
                            popup_addQuery.close();
                        }
                    }

                }
            }


        }


        Rectangle {
            id: rect_SQLQueriesList
            anchors.top: rect_SQLQueries_header.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7


            ListModel {
                id: listModel_params
//                ListElement {
//                    name: "Apple"
//                    cost: 2.45
//                }
            }

            ListView {
                id: list_SQLQueries
                anchors.fill: parent
                anchors.margins: 5
                currentIndex: -1 //0
                property var id_currentPerson //: page_reports.model_SQLQiueries.getFirstColumnInt(currentIndex)
                property var sqlQuery

                highlightFollowsCurrentItem: true

                model: page_reports.model_SQLQiueries

                ScrollBar.vertical: ScrollBar {
                    policy: "AlwaysOn"
                }

                clip: true
                delegate:
                    ItemDelegate {
                    id: delegate_SQLqueryList
                    width: list_SQLQueries.width - 20 // 210
//                    height: txt_delegate_SQLqueryList_1.height + txt_delegate_SQLqueryList_2.height + 20 //60 //implicitContentHeight
                    height: (list_SQLQueries.currentIndex == index) ?  txt_delegate_SQLqueryList_1.height + txt_delegate_SQLqueryList_2.height + 55 : txt_delegate_SQLqueryList_1.height + txt_delegate_SQLqueryList_2.height + 20 //60 //implicitContentHeight
                    Row {
                        anchors.fill: parent
                        anchors.margins: 5
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: (list_SQLQueries.currentIndex == index) ? 35 : 0

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
                            spacing: 5
                            Text {
                                id: txt_delegate_SQLqueryList_1
                                text: DESCRIPTION
                                font.pixelSize: 14
                                width: delegate_SQLqueryList.width - 30
                                color: {
                                 if (list_SQLQueries.currentIndex == index) { "#FF5722" }
                                 else { "#4c4c4c" }
                                }
                                wrapMode: Text.WordWrap
                                //font.bold: true
                            }
                            Text {
                                id: txt_delegate_SQLqueryList_2
                                text: {
                                    //list_SQLQueries.sqlQuery = SQLQUERY;
                                    var strQuery = SQL.toUpperCase(); /// в верхний регистр
                                    var str_all = "";
                                    var str_0   = "";
                                    var str_1   = "";

                                    //console.log(" ####################### ")

                                    /// ~n эквивалентен выражению -(n+1)
                                    for (var i = 0; i < strQuery.length; i++) {
                                        if ( strQuery[i] !== " "  && i < strQuery.length-1) {
                                            str_0 = str_0 + strQuery[i];
                                            //console.log("str_0 = ", str_0);
                                        }
                                        else if ( strQuery[i] === " " || i === strQuery.length-1) {
                                            if(i === strQuery.length-1) {
                                                str_0 = str_0 + strQuery[i];
                                            }

                                            if ( str_0 === "SELECT"   || str_0 === "FROM"     || str_0 === "WHERE"    ||
                                                 str_0 === "AND"      || str_0 === "ORDER"    || str_0 === "BY"       ||
                                                 str_0 === "INNER"    || str_0 === "JOIN"     || str_0 === "AS"       ||
                                                 str_0 === "ON"       || str_0 === "DISTINCT" || str_0 === "INTO"     ||
                                                 str_0 === "LIKE"     || str_0 === "EXISTS"   || str_0 === "JOIN"     ||
                                                 str_0 === "IN"       || str_0 === "GROUP"    || str_0 === "BY"       ||
                                                 str_0 === "GROUP"
                                                    ) {
                                                str_0 = "<b>" + str_0 + "</b>";
                                            }

                                            if ( str_0 === "*" ) {
                                                str_0 = '<font color="#cc2e2e">' + str_0 + '</font>'

                                            }


                                            str_all = str_all + str_0 + " ";
                                            //console.log("str_all = ", str_all);
                                            str_0 = "";
                                        }
                                    }

                                    //console.log(" ####################### ")

//                                    if(~strQuery.indexOf("FROM")) {
//                                        str_all = strQuery.slice(0,strQuery.indexOf("FROM"));
//                                        str_0 = strQuery.slice(strQuery.indexOf("FROM"),strQuery.indexOf("FROM")+4)
//                                        str_0 = "<b>" + str_0 + "</b>"  //str_0 = str_0.bold();
//                                        str_all = str_all + str_0 + strQuery.slice(strQuery.indexOf("FROM")+4);
//                                    }

                                    return str_all;
                                }

                                font.pixelSize: 10
                                width: delegate_SQLqueryList.width - 30
                                color: "#777777"
                                wrapMode: Text.WordWrap
                            }
                        }

                    }

                    Row {
                        visible: (list_SQLQueries.currentIndex == index) ? true : false
//                        anchors.left: parent.left
//                        anchors.right: parent.right
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: -30

                        spacing: 5
                        Rectangle {
                            height: 25
                            width: 100
                            border.color: "#FF5722"
                            color: "transparent"
                            Text {
                                id: txt_Edit
                                anchors.centerIn: parent
                                color: "#FF5722"
                                text: qsTr("Редактировать")
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:  { parent.border.color = "#e33700";   txt_Edit.color = "#e33700"   }
                                onExited:   { parent.border.color = "#FF5722";   txt_Edit.color = "#FF5722"; parent.color = "transparent"  }
                                onPressed:  { parent.border.color = "#e33700";   txt_Edit.color = "#e33700"; parent.color = "#ffeae3"      }
                                onReleased: { parent.border.color = "#FF5722";   txt_Edit.color = "#FF5722"; parent.color = "transparent"  }
                                onClicked:  {
                                    var sqlQuery = model_SQLQiueries.get(list_SQLQueries.currentIndex)["SQL"];
                                    var descriotion = model_SQLQiueries.get(list_SQLQueries.currentIndex)["DESCRIPTION"];
                                    var reportName = model_SQLQiueries.get(list_SQLQueries.currentIndex)["REPORTNAME"];
                                    popup_addQuery.setDataInFilds(sqlQuery, descriotion, reportName);
                                    popup_addQuery.type = "update"
                                    popup_addQuery.open();
                                }
                            }
                        }
                        Rectangle {
                            height: 25
                            width: 100
                            border.color: "#FF5722"
                            color: "transparent"
                            Text {
                                id: txt_Delete
                                anchors.centerIn: parent
                                color: "#FF5722"
                                text: qsTr("Удалить")
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:  { parent.border.color = "#e33700";   txt_Delete.color = "#e33700"   }
                                onExited:   { parent.border.color = "#FF5722";   txt_Delete.color = "#FF5722"; parent.color = "transparent"  }
                                onPressed:  { parent.border.color = "#e33700";   txt_Delete.color = "#e33700"; parent.color = "#ffeae3"      }
                                onReleased: { parent.border.color = "#FF5722";   txt_Delete.color = "#FF5722"; parent.color = "transparent"  }
                                onClicked:  {
                                    popup_deleteSQLQuery.querySQL = model_SQLQiueries.get(list_SQLQueries.currentIndex)["SQL"];
                                    popup_deleteSQLQuery.queryDescription = model_SQLQiueries.get(list_SQLQueries.currentIndex)["DESCRIPTION"];
                                    popup_deleteSQLQuery.open();
                                }
                            }
                        }
                        Rectangle {
                            height: 25
                            width: 100
                            border.color: "#FF5722"
                            color: "transparent"
                            Text {
                                id: txt_Copy
                                anchors.centerIn: parent
                                color: "#FF5722"
                                text: qsTr("Копировать")
                            }
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                onEntered:  { parent.border.color = "#e33700";   txt_Copy.color = "#e33700"   }
                                onExited:   { parent.border.color = "#FF5722";   txt_Copy.color = "#FF5722"; parent.color = "transparent"  }
                                onPressed:  { parent.border.color = "#e33700";   txt_Copy.color = "#e33700"; parent.color = "#ffeae3"      }
                                onReleased: { parent.border.color = "#FF5722";   txt_Copy.color = "#FF5722"; parent.color = "transparent"  }
                                onClicked:  {
                                    clipboard.text = model_SQLQiueries.get(list_SQLQueries.currentIndex)["SQL"];
                                }
                            }
                        }

                    }


                    onClicked: { //onDoubleClicked: {
                        if (list_SQLQueries.currentIndex !== index) {
                            list_SQLQueries.currentIndex = index
                        }
                        list_SQLQueries.id_currentPerson = page_reports.model_SQLQiueries.getFirstColumnInt(index)

//                        var SQLquery = model_SQLQiueries.getCurrentDateByName( "SQL", list_SQLQueries.currentIndex );
                        var SQLquery = model_SQLQiueries.get(list_SQLQueries.currentIndex)["SQL"];
                        list_SQLQueries.sqlQuery = SQLquery;
                        console.log( " (!) SQLquery ===== ", SQLquery) ;


                        /// парсим полученный SQL запрос из модели данных (из БД) на параметров по ключевому символам #PARAM(имя_парамтера)#
                        if(~SQLquery.indexOf("#PARAM(")) {
                            listModel_params.clear();
                            rect_Table.destroyObj_fun();

                            var txt_param = "";
                            var i_param = SQLquery.indexOf("#PARAM(");
                            while (i_param !== -1) {
                                if (~SQLquery.indexOf( ")#", i_param + 7 )) {
                                    txt_param = "";
                                    for ( var i = i_param + 7; i < SQLquery.indexOf( ")#", i_param + 7 ); i++) {
                                        txt_param = txt_param + SQLquery.charAt(i);
                                    }
                                    listModel_params.append( { nameParams : txt_param } )
                                    i_param = SQLquery.indexOf('#PARAM(', i_param + txt_param.length);
                                    //console.log( "(!) txt_param = ", txt_param , " i_param = ", i_param);
                                }
                                else {
                                    i_param = -1;
                                }
                            }

                            /// открываем окно с сформировавшимися полями ввода параметров
                            popup_getParams.open();
                        }
                        else {
                            if ( SQLquery.lenght <= 0 ) { //if ( SQLquery === "" || SQLquery === " " )
                                rect_Table.createEmptyTable_fun("<- Выберите SQL запрос из списка слева");
                            }
                            else {
                                SQLquery = " " + SQLquery + " ";
                                rect_Table.destroyObj_fun();
                                model_tableReports.setQueryDB(SQLquery);
                                txt_ReportNameFromDB.reportName = model_SQLQiueries.get(list_SQLQueries.currentIndex)["REPORTNAME"]
                            }
                        }
                        //console.log(" (!) txt_param = ", txt_param);

                    }

                }

                highlight: Rectangle {
                    color: "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                    border.color: "#FF5722"
                }
                highlightMoveDuration: 200

            }


            Popup {
                id: popup_getParams
                property string querySQL: ""
                property string queryDescription: ""
                width:  getParams.width + padding * 2
                height: getParams.height + padding * 2
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape
                parent: Overlay.overlay
                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                padding: 0

                background:
                    Rectangle {
                    anchors.fill: parent
                    //color: "Transparent" //"White" Material.color(Material.Grey, Material.Shade200)

                    radius: 5
                    opacity: 0.9
                }

                Item {
                    id: getParams
                    height: repeater_params.count * 80 + repeater_params.count * 20 + button_getParams.height + 20 //el_1__deleteSQLQuery.height + el_2__deleteSQLQuery.height + 130 //250 //implicitHeight
                    width:  500
                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 5

                        Repeater {
                            id: repeater_params
                            model: listModel_params // 3
                            Rectangle {
                                width: getParams.width; height: 80
                                border.width: 1
                                property alias textProperty: txt_param.text
                                //color: "yellow"
                                RowLayout {
                                    anchors.fill: parent
                                    spacing: 10

                                    Rectangle {
                                        Layout.minimumWidth: 350
                                        Layout.fillHeight: true
                                        border.color: "LightGray"
                                        color: "Transparent"
                                        Text {
                                            anchors.centerIn: parent
                                            width: 300
                                            horizontalAlignment: Text.AlignHCenter
                                            wrapMode: Text.WordWrap
                                            color: page_reports.text_color
                                            font.pixelSize: 14
                                            text: qsTr(nameParams)
                                        }
                                    }

                                    Rectangle {
                                        Layout.fillWidth:  true
                                        Layout.minimumWidth: 150
                                        Layout.fillHeight: true
                                        border.color: "LightGray"
                                        color: "Transparent"
                                        TextField {
                                            id: txt_param
                                            anchors.centerIn: parent
                                           // width: parent.width
                                            font.bold: true
                                            color: Material.color(Material.Teal)
                                            selectByMouse: true
                                            selectionColor: Material.color(Material.Red)
                                            horizontalAlignment: Text.AlignHCenter
                                            placeholderText: qsTr("0")
                                            onFocusChanged: {
                                                if (focus) { select(0, text.length) }
                                            }
                                        }
                                    }

                                }
                            }
                        }


                        Button {
                            id: button_getParams
                            Layout.alignment: Qt.AlignHCenter
                            text: "OK"
                            onClicked: {
                                var SQLquery = list_SQLQueries.sqlQuery;
                                if ( SQLquery.lenght <= 0 ) { //if ( SQLquery === "" || SQLquery === " " )
                                    rect_Table.createEmptyTable_fun("<- Выберите SQL запрос из списка слева");
                                }
                                else {

                                    //var param1 = repeater_params.itemAt(0).textProperty;
                                    //console.log(" (!) params = ", param1, param2);

                                    var iParams = 0;
                                    var SQLquery_tmp = SQLquery;
                                    var txt_param = "";
                                    var i_param = SQLquery.indexOf("#PARAM(");
                                    while (i_param !== -1) {
                                        if (~SQLquery.indexOf( ")#", i_param + 7 )) {
                                            txt_param = "";
                                            for ( var i = i_param ; i < SQLquery.indexOf( ")#", i_param + 7 ) + 2; i++) {
                                                txt_param = txt_param + SQLquery.charAt(i);
                                            }
                                            var param = "'" + repeater_params.itemAt(iParams).textProperty + "'";
                                            console.log( "(!) param = ", param);
                                            SQLquery_tmp = SQLquery_tmp.replace(txt_param, param)

                                            i_param = SQLquery_tmp.indexOf('#PARAM(', i_param + param.length);

                                            console.log( "(!) txt_param = ", txt_param , " i_param = ", i_param);

                                        }
                                        else {
                                            i_param = -1;
                                        }
                                        iParams ++;
                                    }

                                    console.log( " (!) SQLquery_final = ", SQLquery_tmp);
                                    SQLquery = " " + SQLquery_tmp + " ";
                                    rect_Table.destroyObj_fun();
                                    model_tableReports.setQueryDB(SQLquery);
                                    txt_ReportNameFromDB.reportName = model_SQLQiueries.get(list_SQLQueries.currentIndex)["REPORTNAME"]
                                }
                                popup_getParams.close();
                            }
                        }


                    }
                }
            }



            Popup {
                id: popup_deleteSQLQuery
                property string querySQL: ""
                property string queryDescription: ""
                width:  deleteSQLQuery.width + padding*2
                height: deleteSQLQuery.height + padding*2
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape
                parent: Overlay.overlay
                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                padding: 0

                background:
                    Rectangle {
                    anchors.fill: parent
                    //color: "Transparent" //"White" Material.color(Material.Grey, Material.Shade200)

                    radius: 5
                    opacity: 0.9
                }

                Item {
                    id: deleteSQLQuery
                    height: el_1__deleteSQLQuery.height + el_2__deleteSQLQuery.height + 130 //250 //implicitHeight
                    width:  500

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 10
                        font.pixelSize: 15
                        text: "Удаление запроса"
                    }

                    Column {
                        //id: column_deleteSQLQuery
                        anchors.fill: parent
                        anchors.top: parent.top
                        anchors.topMargin: 40
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 40
                        spacing: 10

                        Text {
                            id: el_1__deleteSQLQuery
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.margins: 15
                            font.pixelSize: 20
                            wrapMode: TextEdit.WrapAnywhere | TextEdit.WordWrap
                            text: popup_deleteSQLQuery.queryDescription
                        }
                        Rectangle {
                            id: el_2__deleteSQLQuery
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.margins: 10
                            border.color: Material.color(Material.LightGreen)
                            color:"transparent"
                            height: 200


                            TextArea {
                                //enabled: false
                                anchors.fill: parent
                                padding: 20
                                text: popup_deleteSQLQuery.querySQL
                                font.pixelSize: 12
                                selectByMouse: true
                                wrapMode: TextEdit.WrapAnywhere | TextEdit.WordWrap
                                font.capitalization: Font.AllUppercase
                                selectionColor: Material.color(Material.LightGreen)
                                background: Rectangle {
                                    color:"transparent"
                                }
                            }

//                            Flickable {
//                                anchors.fill: parent
//                                clip : true

//                                ScrollBar.vertical: ScrollBar { }

//                                TextArea.flickable: TextArea {
//                                    //enabled: false
//                                    padding: 20
//                                    text: popup_deleteSQLQuery.querySQL
//                                    font.pixelSize: 12
//                                    selectByMouse: true
//                                    wrapMode: TextEdit.WrapAnywhere | TextEdit.WordWrap
//                                    font.capitalization: Font.AllUppercase
//                                    selectionColor: Material.color(Material.LightGreen)
//                                        background: Rectangle {
//                                            color:"transparent"
//                                        }
//                                }
//                            }

                        }

                    }

                    Button {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.horizontalCenter
                        anchors.margins: 20
                        anchors.rightMargin: 5
                        Material.background: Material.LightGreen
                        text: "Удалить"
                        onClicked: {
                            var query = "Delete from REPORTS WHERE ID = " + model_SQLQiueries.get(list_SQLQueries.currentIndex)["ID"];
                            //console.log(" (!) query: ", query);
                            Query1.setQueryAndName(query, "q1__deleteReport")
                            popup_deleteSQLQuery.close()
                        }
                    }

                    Button {
                        anchors.bottom: parent.bottom
                        anchors.left: parent.horizontalCenter
                        anchors.right: parent.right
                        anchors.margins: 20
                        anchors.leftMargin: 5
                        //highlighted: true
                        //Material.background: Material.LightBlue
                        text: "Отмена"
                        onClicked: {
                            popup_deleteSQLQuery.close()
                        }
                    }



                }
            }

        }



    }


    Rectangle {
        id: rectMain_Table
        anchors.top: frame_page_header.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: rect_ScaleLine.right //rectMain_SQLQueries.right
        //anchors.leftMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20

        color: "transparent"
        //border.color: "Green" //"LightGray"


        Rectangle {
            id: rect_Table_header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: 50


            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7

//            Text {
//                anchors.centerIn: parent
//                text: "Данные по запросу"
//                font.pixelSize: 14
//                font.bold: true
//                color: "#808080"
//            }

//            Rectangle {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.left: parent.left
//                anchors.leftMargin: 10
//                width: 170
//                height: 40
//                color: "transparent"
//                border.color: "LightGray"
//                radius: 7
//                Text {
//                    id: txtButton_ShowReport
//                    anchors.centerIn: parent
//                    text: "Отобразить данные"
//                    font.pixelSize: 14
//                    color: "#4CAF50" //"LightGray"
//                }
//                MouseArea {
//                    anchors.fill: parent
//                    hoverEnabled: true
//                    onEntered:  { parent.border.color = "#FF5722";   txtButton_ShowReport.color = "#FF5722" }
//                    onExited:   { parent.border.color = "LightGray"; txtButton_ShowReport.color = "#4CAF50" }
//                    onPressed:  { parent.color = "#f6ffed" }
//                    onReleased: { parent.color = "transparent" }
//                    onClicked:  {
//                        var SQLquery = model_SQLQiueries.getCurrentDateByName( "SQL", list_SQLQueries.currentIndex );
//                        console.log(" SQLquery ===== ",SQLquery);
//                        if ( SQLquery === "" || SQLquery === " " ) {
//                            rect_Table.createEmptyTable_fun("<- Выберите SQL запрос из списка слева");
//                            //console.log("SQLquery ===== |",SQLquery, "|");
//                        }
//                        else {
//                            SQLquery = " " + SQLquery + " ";
//                            rect_Table.destroyObj_fun();
//                            model_tableReports.setQueryDB(SQLquery);
//                        }
//                    }

//                }

//            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 190
                width: 180
                height: 40
                color: "transparent"
//                border.color: "LightGray"
//                radius: 7
                TextField {
                    id: txt_ReportNameFromDB
                    property string reportName
                    anchors.fill: parent

                    selectionColor: Material.color(Material.Red)
                    selectByMouse: true
                    //placeholderText: "Report"
                    text: ( reportName.length == 0 ) ? "Report" : reportName
                    onFocusChanged: {
                        if (focus) { select(0, text.length) }
                    }
                }

            }


            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 10
                width: 170
                height: 40
                color: "transparent"
                border.color: "#444444" //"LightGray"
                radius: 7
                enabled: (list_SQLQueries.currentIndex < 0  || !rect_Table.isOk) ? false : true
                Text {
                    id: txtButton_CreateFileReport
                    anchors.centerIn: parent
                    text: "Оформить в виде файла"
                    font.pixelSize: 14
                    color:  "#444444" //"LightGray"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { parent.border.color = "#4CAF50";   txtButton_CreateFileReport.color = "#4CAF50"   }
                    onExited:   { parent.border.color = "#444444";   txtButton_CreateFileReport.color = "#444444"   }
                    onPressed:  { parent.border.color = "#35dd89";   txtButton_CreateFileReport.color = "#35dd89"; parent.color = "#f6ffed"      }
                    onReleased: { parent.border.color = "#4CAF50";   txtButton_CreateFileReport.color = "#4CAF50"; parent.color = "transparent"  }
                    onClicked:  {

                        function type_(value) {
                            var regex = /^\[object (\S+?)\]$/;
                            var matches = Object.prototype.toString.call(value).match(regex) || [];
                            return (matches[1] || 'undefined').toLowerCase();
                        }


                        /// задается размерность массива данных
                        //var Z_lenght = model_tableReports.columnCount() * model_tableReports.rowCount();
                        //console.log( " (!) Z_lenght = ", Z_lenght )
                        console.log( " (!) setTypeReport "  );
                        report.setTypeReport( model_tableReports.columnCount(), model_tableReports.rowCount() );

                        var Z = {};
                        Z[1] = txt_ReportNameFromDB.text; //model_SQLQiueries.get(list_SQLQueries.currentIndex)["REPORTNAME"];
                        var ij = 2;
                        var nameHeader;
                        for (var i = 0; i < model_tableReports.rowCount(); i++) {
                            for (var j = 0; j < model_tableReports.columnCount(); j++) {

                                /// берется заголовок
                                nameHeader = model_tableReports.headerData(j, Qt.Horizontal, 0)

                                var z_now = model_tableReports.get(i)[nameHeader]

                                /// определяется тип данных
                                var typeZ = type_(z_now)

                                /// данные форматируются по их типу
                                if ( typeZ == "date" ) {
                                    Z[ij] = z_now.getDate() + "." + (z_now.getMonth()+1) + "." + z_now.getFullYear(); }
                                else if ( typeZ == "undefined" ) {
                                    Z[ij] = " ";
                                }
                                else {
                                    Z[ij] = z_now;
                                }

                                //console.log(" (!) Z[", ij , "] = ",  Z[ij])
                                ij++;
                            }
                        }

                        /// данные загружаются в объект создателя отчета
                        report.setZ(Z);

                        var query = " select DOCX, DOCM, REPORTNAME FROM REPORTS WHERE ID = " + model_SQLQiueries.get(list_SQLQueries.currentIndex)["ID"]
                        Query1.setQueryAndName(query, "q1__loadFileForReport")
                        //popup_createReport.open()

                    }
                }

            }           


        }


        /// Рамка с таблицей
        Rectangle {
            id: rect_Table
            anchors.top: rect_Table_header.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
            border.color: "LightGray"
            radius: 7
            clip: true

            property var table_dynamic: undefined
            property bool isOk


            /////////////////////////////////////////////////////////////////
            //Следующие функции нужны для обновления данных таблицы
            // при изменении модели

            // функция создания таблицы на основе ListView из файла MyListViewTable_dynamic.qml
            // в параметр model передается модель с данными для таблицы
            function createTable_fun(model){
                console.log("createTable_fun: создание таблицы...");
                destroyObj_fun();
                createObj_fun();

                var roles = [];
                var columnCount = model.columnCount();

                for (var i=0; i<columnCount; i++){
                    roles[i]=model.headerData(i, Qt.Horizontal, 0)
                }

                // первым необходимо определить роли, потом число столбцов, затем только модель

                //table_dynamic.border.color = "LightGray";
                table_dynamic.roles_ = roles;
                table_dynamic.columnCount = columnCount;
                table_dynamic.model_ = model;

            }

            function createEmptyTable_fun(headerText){
                console.log("createEmptyTable_fun: создание пустой таблицы...");
                destroyObj_fun();
                createObj_fun();

                var roles = [headerText];
                var columnCount = 1;

//                for (var i=0; i<columnCount; i++){
//                    roles[i]=model.headerData(i, Qt.Horizontal, 0)
//                }

                // первым необходимо определить роли, потом число столбцов, затем только модель
                table_dynamic.roles_ = roles;
                table_dynamic.columnCount = columnCount;
                table_dynamic.isEmpty = true;
                //table_dynamic.model_ = model;

            }


            // функция создания компонента таблица (на основе ListView) из файла MyListViewTable_dynamic.qml
            function createObj_fun(){
                console.log("createObj_fun: создание нового объекта...");
                var component = Qt.createComponent("MyListViewTable_dynamic.qml");

//                if( component.status != Component.Ready )
//                {
//                    if( component.status == Component.Error )
//                        console.debug("Error:"+ component.errorString() );
//                    return; // or maybe throw
//                }
//                var dlg = component.createObject( parentId, {} );
                var object = component.createObject(rect_Table);
                table_dynamic = object;
            }

            // функция удаления компонента, помещенного в свойство listView_dynamic
            //  (удаление созданного listview)
            function destroyObj_fun(){ //(object)
                //console.log("destroyObj_fun: удаление старого объекта(если он существует)...");
                if(table_dynamic !== undefined){
                    table_dynamic.columnCount  = 0
                    table_dynamic.columnWidth  = 0
                    table_dynamic.headerHeight = 0
                    table_dynamic.rowHeight    = 0
                    table_dynamic.model_       = undefined
                    table_dynamic.destroy();
                    console.log("destroyObj_fun: удаление старого объекта...");
                    table_dynamic = undefined;
                }
            }
            /////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////



        }





    }






}
