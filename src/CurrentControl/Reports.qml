import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2


Page {
    id: page_reports
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
                rect_Table.createTable_fun(model_tableReports);
            }
            else {
                rect_Table.createEmptyTable_fun("OOPS! Что-то не так с запросом!   " + errorMessage)
            }
        }
    }


    Rectangle {
        id: rect_page_header
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: space_margin

        color: "#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)
        border.color: "LightGray"
        radius: 7

        Label {
            anchors.centerIn: parent
            text: "ОТЧЕТЫ"
            font.pixelSize: 14
            font.bold: true
        }

    }

    Rectangle {
        id: rectMain_SQLQueries
        anchors.top: rect_page_header.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: 20
        width: 350

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

            Label {
                anchors.centerIn: parent
                text: "Список SQL запросов"
                font.pixelSize: 14
                font.bold: true
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
                    onPressed:  { parent.color = "#f6ffed";          popup_addQuery.open() }
                    onReleased: { parent.color = "transparent" }
                    //onClicked:  {}
                }

            }
//            Button {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.right: parent.right
//                anchors.rightMargin: 10
//                width: 30
//                height: 40
//                text: "+"
//                font.pixelSize: 30
//            }

            Popup {
                id: popup_addQuery
                width: addQuery.width + padding*2
                height: addQuery.height + padding*2
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape
                parent: Overlay.overlay
                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                padding: 0
                Item {
                    id: addQuery
                    height: 200
                    width:  900

                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 10
                        color: "LightGray"
                        border.color: "LightGray"
                    }
                    RowLayout {
                        id: row_SQL
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        //anchors.topMargin: 20
                        anchors.margins: 20
                        spacing: 40

                        Label {
                            id: label_QuerySQL
                            Layout.minimumWidth: 50
                            Layout.preferredWidth: 50
                            text: "SQL вопрос:"

                        }
                        TextField {
                            id: txt_FieldQuerySQL
                            property var censure: ""
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            anchors.margins: 5
                            selectByMouse: true
                            wrapMode: TextEdit.WordWrap
                            onTextEdited: {
                               //console.log(" ENTER TEXT ");
                               if (text.length > 0) {
                                   text = text.toUpperCase();
                                   if(~text.indexOf("DELETE") || ~text.indexOf("INSERT") || ~text.indexOf("UPDATE")) {
                                       //console.log(" --!CENSURE!-- ");
                                       color = "#ff0000";
                                       button_addQuery.enabled = false;
                                       censure = "Некорректный запрос: недопускается использование слов DELETE, INSERT, UPDATE"
                                       //censure = true;
                                   }
                                   else {
                                       color = "black";
                                       button_addQuery.enabled = true;
                                       censure = "";
//                                       censure = false;
                                   }

                               }
                            }

//                            ToolTip.visible: censure
//                            ToolTip.text: qsTr("Некорректный запрос")
                            ToolTip {
                                 id: toolTip_CENSURE
                                 parent: txt_FieldQuerySQL //.handle
                                 text: (txt_FieldQuerySQL.censure === "") ? qsTr("OK") : qsTr(txt_FieldQuerySQL.censure)  //qsTr("Некорректный запрос")
                                 //anchors.centerIn: parent
                                 y: parent.y - 35 //parent.height
                                 //x: parent.x
                                 font.pixelSize: 15

                                 //anchors.centerIn: parent
                                 visible: txt_FieldQuerySQL.censure
                                 delay: 200 //задержка
                                 contentItem: Text {
                                     text: toolTip_CENSURE.text
                                     font: toolTip_CENSURE.font
                                     color: "white" // "white" //"#21be2b"
                                 }

//                                 background: Rectangle {
//                                     border.color: "#21be2b"
//                                 }
                            }


                            //color: "#eeeeee"
                        }
                    }

                    RowLayout {
                        id: row_description
                        anchors.top: row_SQL.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 20
                        spacing: 40

                        Label {
                            //id: labe_description
                            Layout.minimumWidth: 50
                            Layout.preferredWidth: 50
                            text: "Описание:"
                        }
                        TextField {
                            id: txt_FieldQueryDescription
                            Layout.fillWidth: true
                            Layout.preferredWidth: 100
                            anchors.margins: 5
                            selectByMouse: true
                            wrapMode: TextEdit.WordWrap
                            //color: "#333333"
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
                        //Material.foreground: Material.Orange
                        text: "Добавить запрос"
                        font.pixelSize: 14
                        onClicked: {
                            var SQLquery;
                            SQLquery = " INSERT INTO REP_SQLQUERIES ( SQLQUERY , DESCRIPTION ) VALUES ( '"
                                       + txt_FieldQuerySQL.text + "', '" + txt_FieldQueryDescription.text + "' ) ";
                            //console.log("SQLquery ======= ", SQLquery);
                            Query1.setQueryAndName(SQLquery, "Reports");

                            parent.clearFilds();
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
                            parent.clearFilds();
                            popup_addQuery.close();
                        }
                    }
                    function clearFilds(){
                        txt_FieldQuerySQL.text = ""
                        txt_FieldQueryDescription.text = ""
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
                    height: txt_delegate_SQLqueryList_1.height + txt_delegate_SQLqueryList_2.height + 20 //60 //implicitContentHeight
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
                                    var strQuery = SQLQUERY.toUpperCase(); /// в верхний регистр
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

                    onClicked: {
                        if (list_SQLQueries.currentIndex !== index) {
                            list_SQLQueries.currentIndex = index
                        }
                        list_SQLQueries.id_currentPerson = page_reports.model_SQLQiueries.getFirstColumnInt(index)
                        //id_currentPersonChange(list_SQLQueries.id_currentPerson)
                    }
                }

                highlight: Rectangle {
                    color: "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                    border.color: "#FF5722"
                }
                highlightMoveDuration: 200

            }

        }



    }


    Rectangle {
        id: rectMain_Table
        anchors.top: rect_page_header.bottom
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: rectMain_SQLQueries.right
        anchors.leftMargin: 20
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

            Label {
                anchors.centerIn: parent
                text: "Данные по запросу"
                font.pixelSize: 14
                font.bold: true
            }

            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 170
                height: 40
                color: "transparent"
                border.color: "LightGray"
                radius: 7
                Text {
                    id: txtButton_ShowReport
                    anchors.centerIn: parent
                    text: "Отобразить данные"
                    font.pixelSize: 14
                    color: "#4CAF50" //"LightGray"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { parent.border.color = "#FF5722";   txtButton_ShowReport.color = "#FF5722" }
                    onExited:   { parent.border.color = "LightGray"; txtButton_ShowReport.color = "#4CAF50" }
                    onPressed:  { parent.color = "#f6ffed" }
                    onReleased: { parent.color = "transparent" }
                    onClicked:  {
                        var SQLquery = model_SQLQiueries.getCurrentDateByName( "SQLQUERY", list_SQLQueries.currentIndex );
                        console.log(" SQLquery ===== ",SQLquery);
                        if ( SQLquery === "" || SQLquery === " " ) {
                            rect_Table.createEmptyTable_fun("<- Выберите SQL запрос из списка слева");
                            //console.log("SQLquery ===== |",SQLquery, "|");
                        }
                        else {
                            SQLquery = " " + SQLquery + " ";
                            rect_Table.destroyObj_fun();
                            model_tableReports.setQueryDB(SQLquery);
                        }
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
                border.color: "LightGray"
                radius: 7
                Text {
                    id: txtButton_CreateFileReport
                    anchors.centerIn: parent
                    text: "Оформить в виде файла"
                    font.pixelSize: 14
                    color: "LightGray"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:  { parent.border.color = "#4CAF50";   txtButton_CreateFileReport.color = "#4CAF50"     }
                    onExited:   { parent.border.color = "LightGray"; txtButton_CreateFileReport.color = "LightGray"   }
                    onPressed:  { parent.border.color = "#35dd89";   txtButton_CreateFileReport.color = "#35dd89"; parent.color = "#f6ffed"      }
                    onReleased: { parent.border.color = "#4CAF50";   txtButton_CreateFileReport.color = "#4CAF50"; parent.color = "transparent"  }
                    onClicked:  { popup_createReport.open() }
                }

            }
            Popup {
                id: popup_createReport
                width:  createReport.width + padding*2
                height: createReport.height + padding*2
                modal: true
                focus: true
                closePolicy: Popup.CloseOnEscape
                parent: Overlay.overlay
                x: Math.round((parent.width - width) / 2)
                y: Math.round((parent.height - height) / 2)
                padding: 0
                Item {
                    id: createReport
                    height: 400
                    width:  600

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.top
                        anchors.topMargin: 20
                        text: "ФОРМА ДЛЯ СОЗДАНИЯ ФАЙЛА ОТЧЕТА"
                    }
                    Button {
                        anchors.centerIn: parent
                        text: "Отмена"
                        onClicked: {
                            popup_createReport.close()
                        }
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
                    table_dynamic.columnHeight = 0
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
