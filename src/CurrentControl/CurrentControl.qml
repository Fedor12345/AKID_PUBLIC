import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Page {
    id: page_d1
    visible: true
    //property int space_margin: 15
    //    width: 1200
    //    height: 800


    Pane {
        id: frame1
        //wheelEnabled: true
        width: 350
        anchors.margins: 0//8
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        padding: 0

        background: Rectangle {
            anchors.fill: parent
            color: Material.color(Material.Grey, Material.Shade800)
        }

        MyListViewUnfolding {
            anchors.fill: parent

            model:
                ListModel {
                    //id: animalsModel

                ListElement { name: "Карточка работника";           header: "" }

                //ListElement { name: "Касетница";                    header: "" }
                //ListElement { name: "Масс. выдача/ сдача дозиметр"; header: "" }
                //ListElement { name: "Конфигурация";                 header: "" }


                ListElement { name: "Ввод доз ТЛД";          header: "" }
//                ListElement { name: "Ввод доз ТЛД";          header: "Ввод доз" }
//                ListElement { name: "Ввод архивных доз ТЛД"; header: "Ввод доз" }

                ListElement { name: "Типы дозиметров";    header: "Справочная информация" }
                ListElement { name: "Дозиметры";          header: "Справочная информация" }
                ListElement { name: "Касетницы";          header: "Справочная информация" }
                ListElement { name: "Зоны контроля";      header: "Справочная информация" }
                ListElement { name: "Подразделения";      header: "Справочная информация" }



                ListElement { name: "Отчеты";                       header: "" }
                }

//            onCurrentName: {
//                //if(name === "Касетница") { stackview_mainwindow.replace(".qml")
//                if(name === "Карточка работника") { stackview_mainwindow.replace("WorkersCard.qml") }
//                else {stackview_mainwindow.replace("TestPage.qml")}
//            }

            onCurrentName: {
                changePage(name)

//                var namePage
//                switch(name) {
//                case "Карточка работника":
//                    namePage = "WorkersCard.qml";
//                    break;

//                case "Ввод доз ТЛД":
//                    namePage = "InputDoseTLD.qml";
//                    break;

//                case "Отчеты":
//                    namePage = "Report_ESKID.qml";
//                    break;

//                default:
//                    namePage = "TestPage.qml"
//                    break;
//                }
                //stackview_mainwindow.replace(namePage)
                //if(name === "Касетница") { stackview_mainwindow.replace(".qml") }
            }

        }

    }

    function changePage(name) {
        //var namePage
        pageNotVisible();
        switch(name) {
        case "Карточка работника":
            console.log("name = ", name);
            //namePage = "WorkersCard.qml";
            workerCard.visible = true;
            break;

        case "Ввод доз ТЛД":
            console.log("name = ", name);
            //namePage = "InputDoseTLD.qml";
            inputDoseTLD.visible = true;
            break;

        case "Отчеты":
            console.log("name = ", name);
            //namePage = "Report_ESKID.qml";
            //report_ESKID.visible = true;
            reports.visible = true;
            break;

        default:
            console.log("name = ", name);
            //namePage = "TestPage.qml"
            testPage.visible = true;
            break;
        }
    }
    function pageNotVisible(){
        workerCard.visible   = false
        inputDoseTLD.visible = false
        //report_ESKID.visible = false
        reports.visible = false
        testPage.visible     = false
    }


    Item {
        id: pages_main //stackview_mainwindow
        anchors.left: frame1.right
        anchors.right: parent.right
        //anchors.rightMargin: 250
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70


        property var model_adm_status:           managerDB.createModel(" SELECT STATUS_CODE, STATUS  FROM ADM_STATUS ",                    "adm_status_update")
        property var model_adm_assignment:       managerDB.createModel(" SELECT ID, ASSIGNEMENT      FROM ADM_ASSIGNEMENT ",               "adm_department_nnp_update")
        property var model_adm_organisation:     managerDB.createModel(" SELECT ID, ORGANIZATION_    FROM ADM_ORGANIZATION ",                 "adm_organisation")
        property var model_adm_department_outer: managerDB.createModel(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID = 0", "adm_department_outer")
        property var model_adm_department_inner: managerDB.createModel(" SELECT ID, DEPARTMENT_INNER FROM ADM_DEPARTMENT_INNER ",             "adm_department_inner")

        property var id_currentPerson: "Сотрудник не выбран"

        property var model_SQLQiueries: managerDB.createModel(" SELECT ID, SQLQUERY, DESCRIPTION FROM REP_SQLQUERIES ", "rep_sqlqueries")



        WorkersCard {
            id: workerCard
            anchors.fill: parent
            visible: true

            model_adm_status:           pages_main.model_adm_status
            model_adm_assignment:       pages_main.model_adm_assignment
            model_adm_organisation:     pages_main.model_adm_organisation
            model_adm_department_outer: pages_main.model_adm_department_outer
            model_adm_department_inner: pages_main.model_adm_department_inner

            onId_currentPersonChange: {
                pages_main.id_currentPerson = id_currentPerson
            }
        }
        InputDoseTLD {
            id: inputDoseTLD
            anchors.fill: parent
            visible: false
            id_currentPerson: pages_main.id_currentPerson

        }
        Reports {
            id: reports
            anchors.fill: parent
            visible: false

            model_SQLQiueries: pages_main.model_SQLQiueries
        }
//        Report_ESKID {
//            id: report_ESKID
//            anchors.fill: parent
//            visible: false
//        }
        TestPage {
            id: testPage
            anchors.fill: parent
            visible: false
        }


    }


//    StackView {
//        id: stackview_mainwindow
//        anchors.left: frame1.right
//        anchors.right: parent.right
//        //anchors.rightMargin: 250
//        anchors.top: parent.top
//        anchors.bottom: parent.bottom
//        anchors.bottomMargin: 70

//        property var model_adm_status:           managerDB.createModel(" SELECT STATUS_CODE, STATUS  FROM ADM_STATUS ",                    "adm_status_update")
//        property var model_adm_assignment:       managerDB.createModel(" SELECT ID, ASSIGNEMENT      FROM ADM_ASSIGNEMENT ",               "adm_department_nnp_update")
//        property var model_adm_organisation:     managerDB.createModel(" SELECT ID, ORGANIZATION_    FROM ADM_ORGANIZATION ",                 "adm_organisation")
//        property var model_adm_department_outer: managerDB.createModel(" SELECT ID, DEPARTMENT_OUTER FROM ADM_DEPARTMENT_OUTER WHERE ID = 0", "adm_department_outer")
//        property var model_adm_department_inner: managerDB.createModel(" SELECT ID, DEPARTMENT_INNER FROM ADM_DEPARTMENT_INNER ",             "adm_department_inner")

//        property var id_currentPerson

//        //property var testVar: "Hello"

//        initialItem: "WorkersCard.qml"

//        replaceEnter: Transition {
//            PropertyAnimation {
//                property: "opacity"
//                from: 0
//                to:1
//                duration: 0
//            }
//        }
//        replaceExit: Transition {
//            PropertyAnimation {
//                property: "opacity"
//                from: 1
//                to:0
//                duration: 0
//            }
//        }

//    }


    /// индикаторы сосотояний подключения
    Rectangle {
        anchors.bottom: rect_mainStatusPanel.top
        anchors.margins: 10
        anchors.right: parent.right
        anchors.rightMargin: 15

        width: 1120
        height: 1
        color: "LightGray"

    }
    Popup {
        id: popup_wait_2
        modal: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)

        width: 250
        height: 150


        Rectangle {
            anchors.fill: parent
            Column {
                anchors.centerIn: parent
                spacing: 10
                Text {
                    id: popup_txt
                    font.pixelSize: 15
                    color: "#17a81a"
                    //text: qsTr("text")
                }
                Button {
                    id: cansel_popup_button
                    text: "Закрыть"
                    anchors.horizontalCenter: parent.horizontalCenter
                    contentItem: Text {
                        text: cansel_popup_button.text
                        font: cansel_popup_button.font
                        opacity: enabled ? 1.0 : 0.3
                        color: cansel_popup_button.down ? "#17a81a" : "#21be2b"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        elide: Text.ElideRight
                    }
                    background: Rectangle {
                        implicitWidth: 100
                        implicitHeight: 40
                        opacity: enabled ? 1 : 0.3
                        border.color: cansel_popup_button.down ? "#17a81a" : "#21be2b"
                        border.width: 1
                        radius: 2
                    }
                    onClicked: {
                        popup_wait_2.close();
                    }
                }
            }
        }


    }
    Item {
        id: rect_mainStatusPanel
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        width: 580
        height: 40
        anchors.margins: 15
        //border.color: "LightGray"

        Connections {
                target: managerDB
                property int iBegin: 0

                onSignalSendGUI_status: {
                    console.log(" ******************** ",message, " status = ",status)
                    //txt_statusConnection.text = message;
                    if(message=="begin"){
                        txt_statusConnection.append("<p style='color:#9cc17f'>" + message + ": " + iBegin + "</p>") //txt_statusConnection.text = message;
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        //indicatorConnect_local.lightOff();
                        iBegin++;
                    }
                    else
                    {
                        txt_statusConnection.append(message);
                    }

                    if(status) {
                        txt_nameConnection.text = currentConnectionName;
                        //indicatorConnect_local.lightOff();

                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightTrue();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightTrue();
                        }
                        if(currentConnectionName=="0") {
                            //indicatorConnect_local.lightTrue();
                            txt_nameConnection.text = "local machine"
                        }

                    }
                    else if(!status) {
                        //indicatorConnect_local.lightOff();
                        if(currentConnectionName=="machine 0") {
                            indicatorConnect_0.lightFalse();
                        }
                        if(currentConnectionName=="machine 1") {
                            indicatorConnect_1.lightFalse();
                        }
                    }


                    if(currentConnectionName) {
                        popup_wait_2.close()
                    }

                }

         }

        //пенель с кнопками смены коннекта
        Item {
            id: rect_changeConnect
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.top: parent.top
            width: 81
            //property int currentMachine: 0

            Rectangle {
                id: machine0
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 40
                border.color: "LightGray"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("0")
                    font.pixelSize: 15
                    color: "#494848"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        //rect_changeConnect.currentMachine = 0
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        popup_txt.text = qsTr("Подлючение к machine 0");
                        txt_statusConnection.append("<p style='color:#9cc17f'> Переключение БД </p>")
                        popup_wait_2.open();

                        //managerDB.connectionDB(0);
                        managerDB.checkConnectionDB(0)
                    }
                    onEntered: {
                        parent.color = "#dbdbdb" // "LightGray"
                    }
                    onExited:  {
                        parent.color = "Transparent"
                    }
                }
            }
            Rectangle {
                id: machine1
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                width: 40
                border.color: "LightGray"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("1")
                    font.pixelSize: 15
                    color: "#494848"
                }
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        //rect_changeConnect.currentMachine = 1
                        indicatorConnect_0.lightOff();
                        indicatorConnect_1.lightOff();
                        popup_txt.text = qsTr("Подлючение к machine 1");
                        popup_wait_2.open();
                        txt_statusConnection.append("<p style='color:#9cc17f'> Переключение БД </p>")
                        //managerDB.connectionDB(1);
                        managerDB.checkConnectionDB(1)
                    }
                    onEntered: {
                        parent.color = "#dbdbdb" //"LightGray"
                    }
                    onExited:  {
                        parent.color = "Transparent"
                    }
                }
            }

//            Row {
//                anchors.centerIn: parent
//                //Tumbler { model: 5 }
//                //Switch {}
//                //RadioButton {}
//            }
        }

        //разоврачивающаяся информационная панель
        Rectangle {
            id: rect_statusConnection_info
            property bool isButton_clear: false
            anchors.left: rect_changeConnect.right
            anchors.leftMargin: 10
            anchors.bottom: parent.bottom
            width: 300
            height: 40
            border.color: "LightGray"

            Flickable {
                id: flickable_txt_STATUSCONNECT
                anchors.fill: parent
                //anchors.margins: 2
                anchors.leftMargin: 20

                TextArea.flickable: TextArea {
                    id: txt_statusConnection
                    font.pointSize: 10
                    textFormat: Text.RichText /// для использования html форматирования текста
                    wrapMode: TextArea.Wrap
                    color: Material.color(Material.Grey)
                    font.family: "Calibri"
                }

                ScrollBar.vertical: ScrollBar { }
            }
            MouseArea {
                anchors.fill:parent
                hoverEnabled: true

                //onClicked: {rect_statusConnection_info.height = 400}
                onEntered: {
                    rect_statusConnection_info.height = 400
                    flickable_txt_STATUSCONNECT.anchors.margins = 20
                    txt_statusConnection.font.pointSize = 9
                    txt_button_clear.opacity = 0.2
                }
                onExited:  {
                    rect_statusConnection_info.height = 40
                    flickable_txt_STATUSCONNECT.anchors.margins = 0
                    txt_statusConnection.font.pointSize = 10
                    txt_button_clear.opacity = 0.0
                }
                onPositionChanged: {
                    if(    mouseX >= button_clear.x && mouseX <= (button_clear.x+button_clear.width)
                        && mouseY >= button_clear.y && mouseY <= (button_clear.y+button_clear.height) )
                    {
                        button_clear.border.color = "LightGray"
                        txt_button_clear.opacity = 0.6
                        rect_statusConnection_info.isButton_clear = true
                    }
                    else {
                        button_clear.border.color = "transparent"
                        txt_button_clear.opacity = 0.2
                        rect_statusConnection_info.isButton_clear = false
                    }
                }
                onClicked: {
                    if(rect_statusConnection_info.isButton_clear) {txt_statusConnection.clear()}
                }

            }
            Rectangle {
                id: button_clear
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 14
                width: 50
                height: 20
                Text {
                    id: txt_button_clear
                    anchors.centerIn: parent
                    text: qsTr("Clear")
                    opacity: 0.0
                }

            }
        }


        // индикторы
        Rectangle {
            id: rect_statusConnection_indicator
            border.color: "LightGray"
            anchors.bottom: parent.bottom
            anchors.left: rect_statusConnection_info.right
            anchors.leftMargin: 10
            width: 170
            height: 40


            Item {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right

                TextEdit {
                    id: txt_nameConnection
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10



                    font.pixelSize: 12
                    text: "-"
                    color: Material.color(Material.Grey)
                    selectByMouse: true
                    //selectionColor: Material.color(Material.Red)
                }

                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10

                    border.color: "LightGray"
                    radius: 5
                    width: 70
                    height: 25
                    Row {
                        anchors.centerIn: parent
                        spacing: 10
                        LightIndicator { id: indicatorConnect_0;  height: 15; width: 15 }
                        LightIndicator { id: indicatorConnect_1;  height: 15; width: 15 }
                        //                    Rectangle      { height: 15; width: 1; color: "LightGray" }
                        //                    LightIndicator { id: indicatorConnect_local;  height: 15; width: 15; style: false }

                    }
                }

            }

        }
    }


}

