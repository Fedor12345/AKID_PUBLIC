import QtQuick 2.12
import QtQuick.Controls 2.5

import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

import QtQuick.Dialogs 1.2

Page {
    id: main_

    property var currentPerson: undefined

    property var model_nuclide
    property var model_nuclide_I

    property int sizeLabel: 14
    property string text_color: "#808080"
    property string textData_color:   "#808080"  //"#6b6b6b" // Material.color(Material.Teal)
    property string textHeader_color: "#777777"

    signal updateDataUI() /// сигнал обновить данные в пользовательском интерфейсе
    signal insertIntoDB_sich(var nameQuery, var nameTable, var data)
    width: 900
    height: 800 /// сигнал вставить данные в БД

    clip: true


    Popup {
        id: popup_checkAdd
        property bool isAdd: false
        property string messageError: ""
        width: checkAdd.width + padding*2
        height: checkAdd.height + padding*2
        modal: true
        focus: true
        closePolicy: Popup.NoAutoClose
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
        padding: 0

        Item {
            id: checkAdd
            height: popup_checkAdd.isAdd ? 120 : 150
            width:  popup_checkAdd.isAdd ? 300 : 600 //implicitContentWidth

            Rectangle {
                anchors.fill: parent
                anchors.margins: 10
                border.color: popup_checkAdd.isAdd ? "#8BC34A" : "#F44336"
            }

            Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 20
                width: 50
                height: 80
                border.color: "#F44336"
                visible: popup_checkAdd.isAdd ? false : true
                Text {
                    anchors.centerIn: parent
                    text: qsTr("!")
                    font.bold: true
                    color: "#F44336"
                    font.pixelSize: 50
                }

            }

            Text {
                //id: txt_checkAdd
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 20
                text: popup_checkAdd.isAdd ? "Данные успешно добавлены" : "Ошибка добавления данных"
                color: popup_checkAdd.isAdd ? "#8BC34A" : "#F44336"
                font.pixelSize: 15
            }
            TextInput {
                //id: txt_checkAddERROR
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 60
                //color: popup_checkAdd.isAdd ? "#8BC34A" : "#F44336"
                font.pixelSize: 12
                text: popup_checkAdd.messageError
            }
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                width: 100
                text: "OK"

                onClicked: {
                    popup_checkAdd.close();
                }
            }
        }
    }




    Connections {
        target: Query1
        onSignalSendResult: {
            if (owner_name === "q1__resultSICH") {
                if (res) {
                    txt_result_c.text = var_res["SUM_ACTIVITY_C"].toFixed(5);
                    txt_result_m.text = var_res["SUM_ACTIVITY_M"].toFixed(5);
                    txt_result_m_co.text = var_res["SUM_ACTIVITY_M_CO"].toFixed(5);
                    txt_result_i.text = var_res["SUM_ACTIVITY_I"].toFixed(5);

                    txt_controlSICH__1.text = var_res["MAX_DATE_TIME_C"].toLocaleDateString("ru_RU", "dd.MM.yyyy");
                    txt_controlSICH__2.text = var_res["SUM_ACTIVITY_C"].toFixed(5) + " Бк";
                    txt_controlSICH__3.text = var_res["COUNT_C"];

                    txt_measureSICH__1.text = var_res["MAX_DATE_TIME_M"].toLocaleDateString("ru_RU", "dd.MM.yyyy");
                    txt_measureSICH__2.text = var_res["SUM_ACTIVITY_M"].toFixed(5) + " Бк";
                    txt_measureSICH__3.text = var_res["SUM_ACTIVITY_M_CO"].toFixed(5) + " Бк";
                    txt_measureSICH__4.text = var_res["COUNT_M"];

                    txt_iodinelSICH__1.text = var_res["MAX_DATE_TIME_I"].toLocaleDateString("ru_RU", "dd.MM.yyyy");
                    txt_iodinelSICH__2.text = var_res["SUM_ACTIVITY_I"].toFixed(5) + " Бк";
                    txt_iodinelSICH__3.text = var_res["COUNT_I"];


                }
            }

            /// ДОБАВЛЕНИЕ ДАННЫХ
            if ( owner_name === "q1__insertInControlSICH"  || owner_name === "q1__insertInMeasureSICH") {
                if(!res) {
                    popup_checkAdd.isAdd = false;
                    popup_checkAdd.messageError = owner_name + ": " + messageError;
                }
                else {
                    popup_checkAdd.isAdd = true;
                    popup_checkAdd.messageError = "";
                    /// обновление данных в интерфейсе
                    updateDataUI();
                    //results_fun();
                }
                popup_checkAdd.open();
            }

        }
    }



    /// ЗАГОЛОВОК
    Rectangle {
        id: rect_header
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 40
        //color: Material.color(Material.Grey) //"transparent" //"Material.color(Material.Grey, Material.Shade800)"
        color: "#EEEEEE" // "transparent"
        //border.color: "LightGray"
        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 1
            color: "LightGray"
        }
        Text {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
            font.pixelSize: 20
            //color: "#474747" //"white"
            font.bold: true
            color: "#808080"
            text: qsTr("Измерение на установках спектрометра излучения человека")
        }

    }


    /// РАМКА РЕЗУЛЬТАТОВ ИЗМЕРЕНИЯ
    Rectangle {
        id: rect_Results
        anchors.top: rect_header.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 250
        color: "transparent"

        GridLayout {
            id: grid
            //anchors.fill: parent
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 10


            columns: 7 //5
            rows: 5

            rowSpacing: 10


            /// рамки
            Item {
                Layout.row: 2
                Layout.column: 2
                Layout.rowSpan: 4
                Layout.preferredWidth: 1
                Layout.fillHeight : true
                //color: "green"

                Rectangle {
                    width: 1
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    color: "#808080"
                    opacity: 0.4
                }
            }
            Item {
                Layout.row: 2
                Layout.column: 4
                Layout.rowSpan: 4
                Layout.preferredWidth: 1
                Layout.fillHeight : true
                //color: "green"

                Rectangle {
                    width: 1
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    color: "#808080"
                    opacity: 0.4
                }
            }
            Item {
                Layout.row: 2
                Layout.column: 6
                Layout.rowSpan: 4
                Layout.preferredWidth: 1
                Layout.fillHeight : true
                //color: "green"

                Rectangle {
                    width: 1
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.margins: 10
                    color: "#808080"
                    opacity: 0.4
                }
            }


            /// заголовки (1ая строка)
            Item {
                id: header_ResultsSICH
                Layout.row: 1
                Layout.column: 5 //3

                Layout.preferredWidth: txt_header_ResultsSICH.width + 40
                Layout.maximumWidth: txt_header_ResultsSICH.width + 40
                Layout.preferredHeight: 30
                //Layout.alignment: Qt.AlignBottom //Qt.AlignHCenter | Qt.AlignVCenter

//                Layout.minimumWidth - минимальная ширина объекта в слое;
//                Layout.minimumHeight - минимальная высота объекта в слое;
//                Layout.preferredWidth - предпочтительная ширина объекта в слое;
//                Layout.preferredHeight - предпочтительная высота объекта в слое;
//                Layout.maximumWidth - максимальная ширина объекта в слое;
//                Layout.maximumHeight - максимальная высота объекта в слое;
//                Layout.fillWidth - заполнение по ширине;
//                Layout.fillHeight - заполнение по высоте;
//                Layout.alignment - выравнивание в слое;

                Text {
                    id: txt_header_ResultsSICH
                    anchors.centerIn: parent
                    text: "Результаты измерений, Бк"
                    font.pixelSize: sizeLabel + 2
                    //font.bold: true
                    color: "#808080"
                }
            }
            Item {
                id: header_stepResultSICH
                Layout.row: 1
                Layout.column: 7 //5

                Layout.preferredWidth: txt_header_stepResultSICH.width + 40
                Layout.preferredHeight: 30

                Text {
                    id: txt_header_stepResultSICH
                    anchors.centerIn: parent
                    text: qsTr("Порог, Бк")
                    font.pixelSize: sizeLabel + 2
                    //font.bold: true
                    color: "#808080"
                }
            }


            /// названия разных СИЧ (1 столбец, 2,3,4,5 строки)
            Item {
                //id: namesSICH
                Layout.row: 2
                Layout.column: 1

                Layout.preferredWidth: 180
                Layout.preferredHeight: h_result_c.height + 10

                Text {
                    id: h_result_c
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.centerIn: parent
                    color: "#808080"
                    font.pixelSize: 14
                    text: "Контрольный СИЧ"
                }
            }
            Item {
                //id: namesSICH
                Layout.row: 3
                Layout.column: 1

                Layout.preferredWidth: 180
                Layout.preferredHeight: h_txt_result_m.height + 10

                Text {
                    id: h_txt_result_m
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.centerIn: parent
                    color: "#808080"
                    font.pixelSize: 14
                    text: "Измерительный СИЧ\nбез учета кобальта"
                }
            }
            Item {
                //id: namesSICH
                Layout.row: 4
                Layout.column: 1

                Layout.preferredWidth: 180
                Layout.preferredHeight: h_txt_result_m_co.height + 10

                Text {
                    id: h_txt_result_m_co
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.centerIn: parent
                    color: "#808080"
                    font.pixelSize: 14
                    text: "Измерительный СИЧ\nс учетом кобальта"
                }
            }
            Item {
                //id: namesSICH
                Layout.row: 5
                Layout.column: 1

                Layout.preferredWidth: 180
                Layout.preferredHeight: h_txt_result_i.height + 10

                Text {
                    id: h_txt_result_i
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    //anchors.centerIn: parent
                    color: "#808080"
                    font.pixelSize: 14
                    text: "Йодный СИЧ (?)"
                }
            }

            /// результат измерений
            Item {
                Layout.row: 2
                Layout.column: 3
                Layout.alignment: Qt.AlignCenter

                Layout.preferredWidth: 60
                Layout.maximumWidth: 60
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    //id: txt_result_c
                    anchors.centerIn: parent
                    text:  (Number(txt_result_c.text) < 300) ? qsTr("✔") : qsTr("!") //✓ ☢ ✕  ✗
                    color: (Number(txt_result_c.text) < 300) ? Material.color(Material.Green)  : "#e85d5d" //  < 300 - Норма
                    font.pixelSize: 20
                    font.bold: true
                }
            }
            Item {
                Layout.row: 3
                Layout.column: 3
                Layout.alignment: Qt.AlignCenter

                Layout.preferredWidth: 60
                Layout.maximumWidth: 60
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    //id: txt_result_c
                    anchors.centerIn: parent
                    text:  (Number(txt_result_m.text) < 450) ? qsTr("✔") : qsTr("!") //✓ ☢ ✕  ✗
                    color: (Number(txt_result_m.text) < 450) ? Material.color(Material.Green)  : "#e85d5d" //  < 300 - Норма
                    font.pixelSize: 20
                    font.bold: true
                }
            }
            Item {
                Layout.row: 4
                Layout.column: 3
                Layout.alignment: Qt.AlignCenter

                Layout.preferredWidth: 60
                Layout.maximumWidth: 60
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    //id: txt_result_c
                    anchors.centerIn: parent
                    text:  (Number(txt_result_m_co.text) < 400) ? qsTr("✔") : qsTr("!") //✓ ☢ ✕  ✗
                    color: (Number(txt_result_m_co.text) < 400) ? Material.color(Material.Green)  : "#e85d5d" //  < 300 - Норма
                    font.pixelSize: 20
                    font.bold: true
                }
            }
            Item {
                Layout.row: 5
                Layout.column: 3
                Layout.alignment: Qt.AlignCenter

                Layout.preferredWidth: 60
                Layout.maximumWidth: 60
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    //id: txt_result_c
                    anchors.centerIn: parent
                    text:  (Number(txt_result_i.text) < 400) ? qsTr("✔") : qsTr("!") //✓ ☢ ✕  ✗
                    color: (Number(txt_result_i.text) < 400) ? Material.color(Material.Green)  : "#e85d5d" //  < 300 - Норма // "#808080"
                    font.pixelSize: 20
                    font.bold: true
                }
            }


            /// значения сумм измерений (3ий(5ый в grid) столбец, 2 2,3,4,5 строки)
            Item {
                //id: namesSICH
                Layout.row: 2
                Layout.column: 5 //3
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    id: txt_result_c
                    anchors.centerIn: parent
//                    anchors.left: parent.left
//                    anchors.leftMargin: 10
//                    anchors.verticalCenter: parent.verticalCenter
                    text: qsTr("0")
                    color: (text < 300) ? "#808080" : "#e85d5d" //  < 300 - Норма
                    font.pixelSize: 14
                    font.bold: true
                }
            }
            Item {
                //id: namesSICH
                Layout.row: 3
                Layout.column: 5 //3
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    id: txt_result_m
                    anchors.centerIn: parent
//                    anchors.left: parent.left
//                    anchors.leftMargin: 10
//                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("0")
                    color: (text < 450) ? "#808080" : "#e85d5d" //  < 450 - Норма
                    font.pixelSize: 14
                    font.bold: true
                }
            }
            Item {
                //id: namesSICH
                Layout.row: 4
                Layout.column: 5 //3
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    id: txt_result_m_co
                    anchors.centerIn: parent
//                    anchors.left: parent.left
//                    anchors.leftMargin: 10
//                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("0")
                    color: (text < 400) ? "#808080" : "#e85d5d" //  < 400 - Норма
                    font.pixelSize: 14
                    font.bold: true
                }
            }
            Item {
                //id: namesSICH
                Layout.row: 5
                Layout.column: 5 //3
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    id: txt_result_i
                    anchors.centerIn: parent
//                    anchors.left: parent.left
//                    anchors.leftMargin: 10
//                    anchors.verticalCenter: parent.verticalCenter

                    text: qsTr("0")
                    color: (text < 400) ? "#808080" : "#e85d5d" //  < 400 - Норма
                    font.pixelSize: 14
                    font.bold: true
                }
            }

            /// границы сумм результатов измерений (5ий(7ый в grid) столбец, 2,3,4,5 строки)
            Item {
                Layout.row: 2
                Layout.column: 7 //5
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    anchors.centerIn: parent
                    text: qsTr("300")
                    font.pixelSize: 14
                    color: "#808080"
                    font.bold: true
                }
            }
            Item {
                Layout.row: 3
                Layout.column: 7 //5
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    anchors.centerIn: parent
                    text: qsTr("450")
                    font.pixelSize: 14
                    color: "#808080"
                    font.bold: true
                }
            }
            Item {
                Layout.row: 4
                Layout.column: 7 //5
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    anchors.centerIn: parent
                    text: qsTr("400")
                    font.pixelSize: 14
                    color: "#808080"
                    font.bold: true
                }
            }
            Item {
                Layout.row: 5
                Layout.column: 7 //5
                Layout.alignment: Qt.AlignCenter

                Layout.fillWidth: true  /// - заполнение по ширине;
                Layout.fillHeight: true /// - заполнение по высоте;

                Text {
                    anchors.centerIn: parent
                    text: qsTr("-")
                    font.pixelSize: 14
                    color: "#808080"
                    font.bold: true
                }
            }



        }
    }


    Rectangle {
        anchors.top:    rect_Results.bottom
        anchors.bottom: parent.bottom
        anchors.left:   parent.left
        anchors.right:  parent.right

        border.color: "LightGray"

        TabBar {
            id: tabbar_SICH
            anchors.top: parent.top
            anchors.topMargin: 1
            width: parent.width
            currentIndex: 0
            font.pixelSize: 14
            background: Rectangle { color: "#eeeeee" }
             TabButton {
                 text: "Контрольный СИЧ"
                 width: implicitWidth
             }
             TabButton {
                 text: "Измерительный СИЧ"
                 width: implicitWidth
             }
             TabButton {
                 text: "Йодный СИЧ"
                 width: implicitWidth
                 //enabled: false
             }
        }

        StackLayout {
            anchors.bottom: parent.bottom
            anchors.top: tabbar_SICH.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            //width: parent.width
            currentIndex: tabbar_SICH.currentIndex

            /// ВКЛАДКА КОНТРОЛЬНЫЙ СИЧ
            Item {
                id: controlSICH
                Pane {
                    id: controlSICH_pane
                    anchors.fill: parent

//                    background: Rectangle {
//                        anchors.fill: parent
//                        color: "transparent" //"White" //transparent
//                        //opacity: 0.1
//                    }

                    ColumnLayout {
                        id: info_controlSICH
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 40

                        spacing: 10

                        RowLayout {
                            spacing: 20
                           Label {
                               //Layout.preferredWidth: 180
                               //Layout.preferredHeight: 40
                               text: "Дата последнего измерения"
                               color: main_.text_color
                           }
                           Label {
                               id: txt_controlSICH__1
                               Layout.minimumWidth: 70
                               Layout.alignment: Qt.AlignTop
                               color: textData_color
                               text: ""
                           }
                        }

                        RowLayout {
                            spacing: 20
                           Label {
                               //Layout.preferredWidth: 180
                               //Layout.preferredHeight: 40
                               text: "Суммарная активность нуклидов кобальта"
                               color: main_.text_color
                           }
                           Label {
                               id: txt_controlSICH__2
                               Layout.minimumWidth: 70
                               Layout.alignment: Qt.AlignTop
                               color: textData_color
                               text: ""
                           }
                        }

                        RowLayout {
                            spacing: 20
                           Label {
                               //Layout.preferredWidth: 180
                               //Layout.preferredHeight: 40
                               text: "Колличество внесенных изменений"
                               color: main_.text_color
                           }
                           Label {
                               id: txt_controlSICH__3
                               Layout.minimumWidth: 70
                               Layout.alignment: Qt.AlignTop
                               color: textData_color
                               text: ""
                           }
                        }
                    }

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: info_controlSICH.bottom
                        anchors.bottomMargin: -20
                        height: 1
                        color: "LightGray"
                    }

                    Column {
                        anchors.top: info_controlSICH.bottom
                        anchors.topMargin: 30
                        spacing: 10
                        Button {
                            //anchors.top: info_controlSICH.bottom
                            //anchors.topMargin: 30
                            width: 180
                            text: "Ручной ввод данных"
                            onClicked: {
                                popup_addInControlSICH.open()
                            }
                        }
                        Button {
                            //anchors.top: info_controlSICH.bottom
                            //anchors.topMargin: 30
                            width: 180
                            text: "Данные из файла"
                            onClicked: {
                                //popup_addInControlSICH.open()
                            }
                        }
                    }

    //                background: Rectangle {
    //                    anchors.fill: parent
    //                    color: "green" //transparent
    //                    opacity: 0.1
    //                }



                }

                Popup {
                    id: popup_addInControlSICH
                    width:  item_addInControlSICH.width  + padding * 2
                    height: item_addInControlSICH.height + padding * 2
                    padding: 0

                    modal: true
                    focus: true
                    closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape //Popup.NoAutoClose
                    onClosed: { clearControlSICH(); }
                    parent: Overlay.overlay
                    x: Math.round((parent.width - width) / 2)
                    y: Math.round((parent.height - height) / 2)

                    function clearControlSICH() {
                        txt_ACTIVITY_CONTROL.text      = "0.0"
                        txt_ERR_AVTIVITY_CONTROL.text  = "0.0"
                        txt_EXP_EFF_DOSE_C.text        = "0.0"
                        txt_ERR_EXP_DOSE_C.text        = "0.0"

                        calendar_DATE_TIME_controlSICH.date_val = new Date();
                    }

                    Rectangle {
                        id: item_addInControlSICH
                        height: 500 //implicitContentHeight + 30
                        width: 500//700
                        color: "#ebebeb" // "#ebebeb" //transparent


                        Rectangle {
                            id: header_addControlSICH
                            color: button_insertControlSICH.enabled ? "#4CAF50" : "indianred"
                            width: parent.width
                            height: 40
                            Label {
                                id: header_caption
                                text: "Добавление данных контрольного СИЧ"
                                anchors.horizontalCenter: parent.horizontalCenter
                                anchors.verticalCenter: parent.verticalCenter

                                font.pixelSize: 16
                                color: "White"
                                font.bold: true
                            }
                        }

                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: header_addControlSICH.bottom
                            anchors.bottom: parent.bottom
                            anchors.margins: 10
                            color: "White" //"transparent" //"#EEEEEE"//"White" Material.color(Material.Grey, Material.Shade200)

                            border.color: "LightGray"
                            //radius: 7

                            Column {
                                anchors.fill: parent
                                anchors.margins: 20
                                spacing: 10
                                Column {
                                    spacing: 5
                                    Label {
                                        id: label
                                        text: qsTr("Дата измерения")
                                        //anchors.verticalCenter: parent.verticalCenter
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        font.pixelSize: main_.sizeLabel
                                        color: (calendar_DATE_TIME_controlSICH.ready) ? "#444444" : "#ff0000"
                                    }
                                    MyCalendar {
                                        id: calendar_DATE_TIME_controlSICH
                                        date_val: new Date()
                                        enabled: true
                                    }
                                }


                                Row {
                                    spacing: 20
                                    Item {
        //                                color: "transparent"
        //                                border.color: "LightGray"
                                        width: 200
                                        height: 50
                                        Label {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("Активность 60Co, БК")
                                            font.pixelSize: main_.sizeLabel
                                        }
                                    }
                                    TextField {
                                        id: txt_ACTIVITY_CONTROL
                                        font.pixelSize: 16
                                        color: Material.color(Material.Teal)
                                        selectByMouse: true
                                        selectionColor: Material.color(Material.Red)
                                        horizontalAlignment: Text.AlignHCenter
                                        placeholderText: qsTr("0.0")
                                        text: "0"
                                        onFocusChanged: {
                                            if (focus) { select(0, text.length) }
                                        }
                                    }
                                }

                                Row {
                                    spacing: 20
                                    Item {
        //                                color: "transparent"
        //                                border.color: "LightGray"
                                        width: 200
                                        height: 50
                                        Label {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("Погрешность\nизмерения активности, Бк")
                                            font.pixelSize: main_.sizeLabel
                                        }
                                    }
                                    TextField {
                                        id: txt_ERR_AVTIVITY_CONTROL
                                        font.pixelSize: 16
                                        color: Material.color(Material.Teal)
                                        selectByMouse: true
                                        selectionColor: Material.color(Material.Red)
                                        horizontalAlignment: Text.AlignHCenter
                                        placeholderText: qsTr("0.0")
                                        text: "0"
                                        onFocusChanged: {
                                            if (focus) { select(0, text.length) }
                                        }
                                    }
                                }

                                Row {
                                    spacing: 20
                                    Item {
        //                                color: "transparent"
        //                                border.color: "LightGray"
                                        width: 230 //450
                                        height: 50
                                        Label {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("Ожидаемая эффективная доза\nот выбранного нуклида за год") //.\nСчитается встроенным программным обеспечением спектрометра
                                            font.pixelSize: main_.sizeLabel
                                        }
                                    }
                                    TextField {
                                        id: txt_EXP_EFF_DOSE_C
                                        font.pixelSize: 16
                                        color: Material.color(Material.Teal)
                                        selectByMouse: true
                                        selectionColor: Material.color(Material.Red)
                                        horizontalAlignment: Text.AlignHCenter
                                        placeholderText: qsTr("0.0")
                                        text: "0"
                                        onFocusChanged: {
                                            if (focus) { select(0, text.length) }
                                        }
                                    }
                                }


                                Row {
                                    spacing: 20
                                    Item {
        //                                color: "transparent"
        //                                border.color: "LightGray"
                                        width: 230 //450
                                        height: 50
                                        Label {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("Неопределенность измерений, мЗв") //.\nСчитается встроенным программным обеспечением спектрометра
                                            font.pixelSize: main_.sizeLabel
                                        }
                                    }
                                    TextField {
                                        id: txt_ERR_EXP_DOSE_C
                                        font.pixelSize: 16
                                        color: Material.color(Material.Teal)
                                        selectByMouse: true
                                        selectionColor: Material.color(Material.Red)
                                        horizontalAlignment: Text.AlignHCenter
                                        placeholderText: qsTr("0.0")
                                        text: "0"
                                        onFocusChanged: {
                                            if (focus) { select(0, text.length) }
                                        }
                                    }
                                }

                            }


    //                        Rectangle {
    //                            anchors.top: parent.top
    //                            anchors.right: parent.right
    //                            anchors.margins: 20
    //                            width:  300
    //                            height: 100
    //                            color: "transparent"
    //                            border.color: "LightGray"
    //                            Text {
    //                                id: txt_result_c
    //                                //anchors.centerIn: parent
    //                                anchors.top: parent.top
    //                                anchors.left: parent.left
    //                                anchors.margins: 10
    //                                font.pixelSize: 15
    //                                property bool result_c: Number(txt_ACTIVITY_CONTROL.text)  > 300 ? false : true
    //                                text: Number(txt_ACTIVITY_CONTROL.text)  > 300 ?
    //                                          qsTr("Активность нуклидов кобальта\nпревышает 300 Бк\n\nРезультат контроля отрицательный") :
    //                                          qsTr("Активность нуклидов кобальта\nне превышает 300 Бк\n\nРезультат контроля положительный")
    //                            }

    //                        }

                            Row {
                                anchors.bottom: parent.bottom
                                anchors.right: parent.right
                                anchors.margins: 20
                                spacing: 20
                                Button {
                                    id: button_canselControlSICH
                                    width: 150
                                    text: "Отмена"
                                    onClicked: {
                                        popup_addInControlSICH.close();
                                    }
                                }

                                Button {
                                    id: button_insertControlSICH
                                    width: 150
                                    text: "Сохранить"
                                    enabled: {
                                        var isOk

                                        if (currentPerson !== undefined) { isOk = true    }
                                        else                 { isOk = false; return isOk; }

                                        if (calendar_DATE_TIME_controlSICH.ready) { isOk = true    }
                                        else                          { isOk = false; return isOk; }

                                        return isOk;
                                    }

                                    onClicked: {
                                        if (main_.currentPerson == undefined) return false;

                                        var data_arr = {}
                                        data_arr["ID_PERSON"]            = parseFloat( main_.currentPerson );
                                        data_arr["ACTIVITY_CONTROL"]     = parseFloat( txt_ACTIVITY_CONTROL.text ); //.replace(",", ".")
                                        data_arr["ERR_AVTIVITY_CONTROL"] = parseFloat( txt_ERR_AVTIVITY_CONTROL.text ); //.replace(",", ".")
                                        data_arr["EXP_EFF_DOSE_C"]       = parseFloat( txt_EXP_EFF_DOSE_C.text ); //.replace(",", ".")
                                        data_arr["ERR_EXP_DOSE_C"]       = parseFloat( txt_ERR_EXP_DOSE_C.text ); //.replace(",", ".")

                                        if (calendar_DATE_TIME_controlSICH.ready) data_arr["DATE_TIME"] = calendar_DATE_TIME_controlSICH.date_val

                                        /// посылается сигнал (в CurrentControl.qml) вставить в таблицу IN_CONTROL БД данные data_arr
                                        /// с именем запроса "q1__insertInControlSICH"
                                        insertIntoDB_sich("q1__insertInControlSICH" ,"IN_CONTROL", data_arr);

                                        //Query1.insertRecordIntoTable("q1__insertInControlSICH" ,"IN_CONTROL", data_arr) //wc_query.map_data

                                        popup_addInControlSICH.close();
                                    }
                                }
                            }

                        }


                    }

                }


            }

            /// ВКЛАДКА ИЗМЕРИТЕЛЬНЫЙ СИЧ
            Item {
                id: measureSICH
                Pane {
                    id: measureSICH_pane
                    anchors.fill: parent

    //                background: Rectangle {
    //                    anchors.fill: parent
    //                    color: "red" //transparent
    //                    opacity: 0.1
    //                }


                    ColumnLayout {
                        id: info_measureSICH
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 40

                        spacing: 10

                        RowLayout {
                            spacing: 20
                            Label {
                                //Layout.preferredWidth: 180
                                //Layout.preferredHeight: 40
                                text: "Дата последнего измерения"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_measureSICH__1
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }

                        RowLayout {
                            spacing: 20
                            Label {
                                //Layout.preferredWidth: 180
                                //Layout.preferredHeight: 40
                                text: "Суммарная активность нуклидов без кобальта"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_measureSICH__2
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }

                        RowLayout {
                            spacing: 20
                            Label {
                                //Layout.preferredWidth: 180
                                //Layout.preferredHeight: 40
                                text: "Суммарная активность нуклидов с кобальтом"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_measureSICH__3
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }

                        RowLayout {
                            spacing: 20
                            Label {
                                //Layout.preferredWidth: 180
                                //Layout.preferredHeight: 40
                                text: "Колличество внесенных изменений"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_measureSICH__4
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }
                    }

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: info_measureSICH.bottom
                        anchors.bottomMargin: -20
                        height: 1
                        color: "LightGray"
                    }

                    Column {
                        anchors.top: info_measureSICH.bottom
                        anchors.topMargin: 30
                        spacing: 10
                        Button {
                            width: 180
                            text: "Ручной ввод данных"
                            onClicked: {
                                popup_addInMeasureSICH.open()
                            }
                        }
                        Button {
                            width: 180
                            text: "Данные из файла"
                            onClicked: {
                                //popup_addInControlSICH.open()
                            }
                        }
                    }

                    /// добавление данных в ИЗМЕРИТЕЛЬНЫЙ СИЧ
                    Popup {
                        id: popup_addInMeasureSICH
                        property int countData: 0

                        width:  item_addInMeasureSICH.width  + padding * 2
                        height: item_addInMeasureSICH.height + padding * 2
                        padding: 0

                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape //Popup.NoAutoClose
                        onClosed: { clearMeasureSICH(); }
                        parent: Overlay.overlay
                        x: Math.round((parent.width - width) / 2)
                        y: Math.round((parent.height - height) / 2)

                        function clearMeasureSICH() {
                            comboBox_ORGAN.currentIndex = -1;
                            comboBox_NUCLIDE.currentIndex = -1;
                            comboBox_NUCLIDE.displayText = "";

                            listModel_SICH_MEASHURE.clear();

                            txt_ACTIVITY_MEASURE.text = ""
                            txt_EXP_EFF_DOSE_M.text   = ""


                            calendar_SICH_MEASHURE.date_val = new Date();
                        }


                        Item {
                            id: item_addInMeasureSICH
                            height: 520 //implicitContentHeight + 30
                            width: 850
                            //anchors.margins: 10

                            Rectangle {
                                id: header_addMeasureSICH
                                color: button_insertSICH_MEASHURE.enabled ? "#4CAF50" : "indianred"
                                width: parent.width
                                height: 40


                                Label {
                                    text: "Добавление данных измерительного СИЧ"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    font.pixelSize: 16
                                    color: "White"
                                    font.bold: true
                                }
                            }


                            Rectangle {
                                anchors.top: header_addMeasureSICH.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.margins: 10
                                color: "#ebebeb" // "#ebebeb" //transparent


                                /// форма для добавления новых данных о новом нуклиде в предварительную ьаблицу в интерфейсе
                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.left: rect_listView.right
                                    anchors.leftMargin: 10
                                    anchors.right: parent.right
                                    //width: 440
                                    height: 380
                                    color: "transparent"
                                    border.color: "LightGray"
                                    Column {
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        anchors.top: parent.top
                                        anchors.topMargin: 10

                                        spacing: 10

                                        RowLayout {
                                            spacing: 10
                                            Label {
                                                Layout.preferredWidth: 100
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Орган"
                                            }
                                            ComboBox {
                                                id: comboBox_ORGAN
                                                Layout.preferredWidth: 200
                                                currentIndex: -1
                                                //width: 200
                                                model: [ "Легкие", "Щитовидная железа"]
                                            }
                                        }

                                        RowLayout {
                                            spacing: 10
                                            Label {
                                                Layout.preferredWidth: 100
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Нуклид"
                                            }
                                            ComboBox {
                                                id: comboBox_NUCLIDE
                                                property int currentIdNuclide
                                                Layout.preferredWidth: 200
                                                currentIndex: -1

                                                //width: 200
                                                model: main_.model_nuclide
                                                    //[ "nuclide 1", "nuclide 2", "nuclide 3", "nuclide 4", "nuclide 5" ]
                                                //textRole: "NUCLIDE" // "MUSNUMBER"
                                                delegate: ItemDelegate {
                                                    width: parent.width
                                                    //height: 60
                                                    //property string currentText_: "test1"
                                                    RowLayout {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        anchors.left: parent.left
                                                        anchors.leftMargin: 10
                                                        spacing: 5
                                                        Text {
                                                            id: delegate_comboBox_NUCLIDE_nuclide
                                                            text: NUCLIDE
                                                            font.pixelSize: 16
                                                            //color: "#999999"
                                                        }
                                                        Text {
                                                            id: delegate_comboBox_NUCLIDE_musnumber
                                                            Layout.alignment: Qt.AlignTop
                                                            text: MUSNUMBER
                                                            font.pixelSize: 12
                                                            //color: "#999999"
                                                        }
                                                    }
                                                    onClicked: {
                                                        if (comboBox_NUCLIDE.currentIndex !== index) {
                                                            comboBox_NUCLIDE.currentIndex = index
                                                        }
                                                        comboBox_NUCLIDE.currentIdNuclide = ID
                                                        comboBox_NUCLIDE.displayText = delegate_comboBox_NUCLIDE_nuclide.text + " - " + delegate_comboBox_NUCLIDE_musnumber.text
                                                    }

                                                }
                                            }
                                        }

                                        RowLayout {
                                            spacing: 20
                                            Label {
                                                Layout.preferredWidth: 200
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Активность\nвыбранного нуклида"
                                            }
                                            TextField {
                                                id: txt_ACTIVITY_MEASURE
                                                //Layout.preferredWidth: 200
                                                //width: 200
                                                //font.pixelSize: main_.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                                horizontalAlignment: Text.AlignHCenter
                                                placeholderText: qsTr("0.0")
                                                onFocusChanged: {
                                                    if (focus) { select(0, text.length) }
                                                }
                                            }
                                            Label {
                                                Layout.preferredWidth: 20
                                                Layout.alignment: Qt.AlignCenter
                                                text: "БК"
                                            }
                                        }

                                        RowLayout {
                                            spacing: 20
                                            Label {
                                                Layout.preferredWidth: 200
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Ожидаемая\nэффективная доза\nвнутреннего облучения за год\nот заданного изотопа"
                                            }
                                            TextField {
                                                id: txt_EXP_EFF_DOSE_M
                                                //Layout.preferredWidth: 200
                                                //width: 200
                                                //font.pixelSize: main_.sizeTxt
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                                horizontalAlignment: Text.AlignHCenter
                                                placeholderText: qsTr("0.0")
                                                onFocusChanged: {
                                                    if (focus) { select(0, text.length) }
                                                }
                                            }
                                            Label {
                                                Layout.preferredWidth: 20
                                                Layout.alignment: Qt.AlignCenter
                                                text: "БК"
                                            }
                                        }

                                        RowLayout {
                                            spacing: 20
                                            Label {
                                                Layout.preferredWidth: 170
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Дата измерения"
                                            }
                                            MyCalendar {
                                                id: calendar_SICH_MEASHURE
                                                date_val: new Date()
                                                //enabled: true
                                            }
                                        }
                                    }


                                    /// КНОПКА ДОБАВИТЬ ДАННЫЕ
                                    Row {
                                        anchors.bottom: parent.bottom
                                        anchors.right: parent.right
                                        anchors.margins: 10
                                        spacing: 10
                                        opacity: (!button_addInTempleTableMeasureSICH.enabled) ? 0.2 : 0.9
                                        Text {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("Добавить")
                                            font.pixelSize: 16
                                        }

                                        Rectangle {
                                            id: button_addInTempleTableMeasureSICH
                                            property var currentColor
    //                                        anchors.bottom: parent.bottom
    //                                        anchors.right: parent.right
    //                                        anchors.margins: 10
                                            anchors.verticalCenter: parent.verticalCenter
                                            height: 40
                                            width:  40
                                            radius: 50
                                            color: "transparent"

                                            enabled: {
                                                var isOk

                                                if (currentPerson !== undefined) { isOk = true }
                                                else              { isOk = false; return isOk; }

                                                if (calendar_SICH_MEASHURE.ready) { isOk = true }
                                                else               { isOk = false; return isOk; }

                                                if (comboBox_NUCLIDE.currentIndex >= 0) { isOk = true  }
                                                else                      { isOk = false; return isOk; }
                                                if (comboBox_ORGAN.currentIndex >= 0)   { isOk = true  }
                                                else                      { isOk = false; return isOk; }


                                                return isOk;
                                            }

                                            Image {
                                                anchors.centerIn: parent
                                                source: "icons/Plus.svg"
                                                sourceSize.height: 18
                                                sourceSize.width: 18
                                                fillMode: Image.Stretch
                                            }
                                            //                                    transitions: Transition {
                                            //                                        ColorAnimation { properties: "color"; duration: 1000 }
                                            //                                    }
                                            MouseArea {
                                                anchors.fill: parent
                                                enabled: button_addInTempleTableMeasureSICH.enabled
                                                hoverEnabled: true
                                                onEntered:  { parent.color = "#EEEEEE"     ; parent.currentColor = "#EEEEEE" }
                                                onExited:   { parent.color = "transparent" ; parent.currentColor = "transparent" } //LightGray
                                                onPressed:  { parent.color = "#dbdbdb" }
                                                onReleased: { parent.color = parent.currentColor }
                                                onClicked:  {
                                                    if(calendar_SICH_MEASHURE.ready) {
                                                        listModel_SICH_MEASHURE.append({   organ_:            comboBox_ORGAN.currentText,
                                                                                           nuclide_:          comboBox_NUCLIDE.displayText,
                                                                                           id_nuclide_:        comboBox_NUCLIDE.currentIdNuclide,
                                                                                           activity_measure_: ( txt_ACTIVITY_MEASURE.text.length > 0 ) ? txt_ACTIVITY_MEASURE.text : "0",
                                                                                           eff_dose_m_:       ( txt_EXP_EFF_DOSE_M.text.length   > 0 ) ? txt_EXP_EFF_DOSE_M.text   : "0",
                                                                                           data_:             calendar_SICH_MEASHURE.date_val
                                                                                       })
                                                    }

                                                }
                                            }
                                        }
                                    }


                                }

                                /// КНОПКА ОТМЕНА
                                Button {
                                    id: button_canselSICH_MEASHURE

                                    anchors.right: button_insertSICH_MEASHURE.left
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 20
                                    text: "Отмена"
                                    onClicked: {
                                        popup_addInMeasureSICH.close();
                                    }
                                }

                                /// КНОПКА СОХРАНИТЬ НОВЫЕ ДАННЫЕ В БД
                                Button {
                                    id: button_insertSICH_MEASHURE

                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 20
                                    text: "Сохранить"

                                    enabled: {
                                        var isOk

                                        if (currentPerson !== undefined)        { isOk = true    }
                                        else                        { isOk = false; return isOk; }

                                        if (table_MeasureSICH.currentIndex_ > -1) { isOk = true  }
                                        else                        { isOk = false; return isOk; }


    //                                    if (calendar_DATE_TIME_controlSICH.ready) { isOk = true    }
    //                                    else                          { isOk = false; return isOk; }

                                        return isOk;
                                    }

                                    onClicked: {
                                        if (main_.currentPerson == undefined) return false;

                                        var data_arr = {}

                                        popup_addInMeasureSICH.countData = 0;
                                        for (var i = 0; i < listModel_SICH_MEASHURE.count; i++) {
                                            popup_addInMeasureSICH.countData ++;
                                            data_arr["ID_PERSON"]        = parseFloat( main_.currentPerson);
                                            data_arr["ORGAN"]            = parseFloat( listModel_SICH_MEASHURE.get(i).organ_)             //.replace(",", ".") );
                                            data_arr["NUCLIDE"]          = parseFloat( listModel_SICH_MEASHURE.get(i).id_nuclide_)        //.replace(",", ".") );
                                            data_arr["ACTIVITY_MEASURE"] = parseFloat( listModel_SICH_MEASHURE.get(i).activity_measure_)  //.replace(",", ".") );
                                            data_arr["EXP_EFF_DOSE_M"]   = parseFloat( listModel_SICH_MEASHURE.get(i).eff_dose_m_)        //.replace(",", ".") );
                                            data_arr["DATE_TIME"]        = listModel_SICH_MEASHURE.get(i).data_;

                                            var nameQuery = "q1__insertInMeasureSICH" + popup_addInMeasureSICH.countData;


    //                                        console.log(" (!) data_arr = ", data_arr["ORGAN"], data_arr["NUCLIDE"],
    //                                                                        data_arr["ACTIVITY_MEASURE"], data_arr["EXP_EFF_DOSE_M"],
    //                                                                        data_arr["DATE_TIME"]);

                                            Query1.insertRecordIntoTable(nameQuery ,"IN_MEASURE", data_arr);
                                            popup_addInMeasureSICH.close();
                                        }


                                        //Query1.insertRecordIntoTable("SICH_MEASHURE" ,"IN_MEASURE", data_arr) //wc_query.map_data
                                        //create_confirm(data_arr)
                                    }
                                }

                                /// ТАБЛИЦА С НОВЫМИ ДАННЫМИ
                                Rectangle {
                                    id: rect_listView
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    //anchors.leftMargin: 10
                                    width: 400
                                    Rectangle {
                                        id: rect_header_listView
                                        anchors.top: parent.top
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        height: 40
                                        color: "transparent" //"#9E9E9E"
                                        enabled: (table_MeasureSICH.currentIndex_ == -1) ? false : true
                                        opacity: (table_MeasureSICH.currentIndex_ == -1) ? 0.2 : 0.9
                                        Row {
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.right: parent.right
                                            spacing: 10
                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: qsTr("Удалить")
                                                font.pixelSize: 16
                                            }

                                            Rectangle {
                                                //id: button_addMeasureSICH
                                                property var currentColor
                                                anchors.verticalCenter: parent.verticalCenter
                                                height: 40
                                                width:  40
                                                radius: 50
                                                color: "transparent"
                                                Image {
                                                    anchors.centerIn: parent
                                                    source: "icons/Minus.svg"
                                                    sourceSize.height: 18
                                                    sourceSize.width: 18
                                                    fillMode: Image.Stretch
                                                }
            //                                    transitions: Transition {
            //                                        ColorAnimation { properties: "color"; duration: 1000 }
            //                                    }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered:  { parent.color = "#EEEEEE"     ; parent.currentColor = "#EEEEEE" }
                                                    onExited:   { parent.color = "transparent" ; parent.currentColor = "transparent" } //LightGray
                                                    onPressed:  { parent.color = "#dbdbdb" }
                                                    onReleased: { parent.color = parent.currentColor }
                                                    onClicked:  {
                                                        listModel_SICH_MEASHURE.remove(table_MeasureSICH.currentIndex_)
                                                    }
                                                }
                                            }


                                        }

                                    }

                                    /// таблица с данными нуклидов по ИЗМЕРИТЕЛЬНОМУ СИЧ (MeasureSICH)
                                    Rectangle {
                                        //id: rect_listView
                                        anchors.top: rect_header_listView.bottom
                                        anchors.left: parent.left
                                        anchors.bottom: parent.bottom
                                        anchors.right: parent.right

                                        border.color: "LightGray"
                                        clip: true

                                        MyListViewTable_dynamic {
                                            id: table_MeasureSICH
                                            model_:
                                                ListModel {
                                                    id: listModel_SICH_MEASHURE
                                                }
                                            columnCount: 5
                                            headerHeight: 40
                                            headerNames: {
                                                var names = [];
                                                names[0] = "Орган"
                                                names[1] = "Нуклид"
                                                names[2] = "Активность"
                                                names[3] = "Ожидаемая\nэфф. доза"
                                                names[4] = "Дата"
                                                return names;
                                            }
                                            roles_: {
                                                var roles = [];
                                                roles[0] = "organ_" //listModel_SICH_MEASHURE.organ_;
                                                roles[1] = "nuclide_" //listModel_SICH_MEASHURE.nuclide_;
                                                roles[2] = "activity_measure_" //listModel_SICH_MEASHURE.activity_measure_;
                                                roles[3] = "eff_dose_m_" //listModel_SICH_MEASHURE.activity_measure_;
                                                roles[4] = "data_" //listModel_SICH_MEASHURE.activity_measure_;
                                                return roles;
                                            }
                                            abilitySelectRow: true

                                        }



                                    }


                                }


                            }
                        }
                    }

                }
            }

            /// ВКЛАДКА ЙОДНЫЙ СИЧ
            Item {
                id: iodinelSICH
                Pane {
                    id: iodinelSICH_pane
                    anchors.fill: parent

//                    background: Rectangle {
//                        anchors.fill: parent
//                        color: "White"
//                    }

                    ColumnLayout {
                        id: info_iodinelSICH
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.topMargin: 10
                        anchors.leftMargin: 40

                        spacing: 10

                        RowLayout {
                            spacing: 20
                            Label {
                                text: "Дата последнего измерения"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_iodinelSICH__1
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }

                        RowLayout {
                            spacing: 20
                            Label {
                                text: "Суммарная активность нуклидов йода"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_iodinelSICH__2
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }

                        RowLayout {
                            spacing: 20
                            Label {
                                text: "Колличество внесенных изменений"
                                color: main_.text_color
                            }
                            Label {
                                id: txt_iodinelSICH__3
                                Layout.minimumWidth: 70
                                Layout.alignment: Qt.AlignTop
                                text: ""
                                color: main_.textData_color
                            }
                        }
                    }

                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: info_iodinelSICH.bottom
                        anchors.bottomMargin: -20
                        height: 1
                        color: "LightGray"
                    }

                    Column {
                        anchors.top: info_iodinelSICH.bottom
                        anchors.topMargin: 30
                        spacing: 10
                        Button {
                            width: 180
                            text: "Ручной ввод данных"
                            onClicked: {
                                popup_addInIodineSICH.open()
                            }
                        }
                        Button {
                            width: 180
                            text: "Данные из файла"
                            onClicked: {
                                //popup_addInControlSICH.open()
                            }
                        }
                    }


                    /// добавление данных в ИЗМЕРИТЕЛЬНЫЙ СИЧ
                    Popup {
                        id: popup_addInIodineSICH
                        property int countData: 0

                        width:  item_addInIodineSICH.width  + padding * 2
                        height: item_addInIodineSICH.height + padding * 2
                        padding: 0

                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnPressOutside | Popup.CloseOnEscape //Popup.NoAutoClose
                        onClosed: { clearIodineSICH(); }
                        parent: Overlay.overlay
                        x: Math.round((parent.width - width) / 2)
                        y: Math.round((parent.height - height) / 2)

                        function clearIodineSICH() {
                            comboBox_ISOTOPE_I.currentIndex = -1;

                            listModel_SICH_IODINE.clear();

                            txt_ACTIVITY_IODINE.text = ""
                            txt_EXP_EFF_DOSE_I.text  = ""

                            calendar_SICH_IODINE.date_val = new Date();
                        }


                        Item {
                            id: item_addInIodineSICH
                            height: 520 //implicitContentHeight + 30
                            width: 850
                            //anchors.margins: 10

                            Rectangle {
                                id: header_addInIodineSICH
                                color: button_insertSICH_MEASHURE.enabled ? "#4CAF50" : "indianred"
                                width: parent.width
                                height: 40


                                Label {
                                    text: "Добавление данных измерительного СИЧ"
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    anchors.verticalCenter: parent.verticalCenter

                                    font.pixelSize: 16
                                    color: "White"
                                    font.bold: true
                                }
                            }


                            Rectangle {
                                anchors.top: header_addInIodineSICH.bottom
                                anchors.left: parent.left
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.margins: 10
                                color: "#ebebeb" // "#ebebeb" //transparent


                                /// форма для добавления новых данных о новом нуклиде в предварительную ьаблицу в интерфейсе
                                Rectangle {
                                    anchors.top: parent.top
                                    anchors.left: rect_listView_I.right
                                    anchors.leftMargin: 10
                                    anchors.right: parent.right
                                    //width: 440
                                    height: 320
                                    color: "transparent"
                                    border.color: "LightGray"
                                    Column {
                                        anchors.left: parent.left
                                        anchors.leftMargin: 20
                                        anchors.top: parent.top
                                        anchors.topMargin: 10

                                        spacing: 10

                                        RowLayout {
                                            spacing: 10
                                            Label {
                                                Layout.preferredWidth: 100
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Изотоп йода"
                                            }
                                            ComboBox {
                                                id: comboBox_ISOTOPE_I
                                                property int currentIdNuclide
                                                Layout.preferredWidth: 200
                                                currentIndex: -1

                                                //width: 200
                                                model: main_.model_nuclide_I
                                                   // [ "Isotope 1", "Isotope 2", "Isotope 3", "Isotope 4", "Isotope 5" ]
                                                delegate: ItemDelegate {
                                                    width: parent.width
                                                    RowLayout {
                                                        anchors.verticalCenter: parent.verticalCenter
                                                        anchors.left: parent.left
                                                        anchors.leftMargin: 10
                                                        spacing: 5
                                                        Text {
                                                            id: delegate_comboBox_ISOTOPE_I
                                                            text: NUCLIDE
                                                            font.pixelSize: 16
                                                            //color: "#999999"
                                                        }
                                                        Text {
                                                            id: delegate_comboBox_ISOTOPE_I_musnumber
                                                            Layout.alignment: Qt.AlignTop
                                                            text: MUSNUMBER
                                                            font.pixelSize: 12
                                                            //color: "#999999"
                                                        }
                                                    }
                                                    onClicked: {
                                                        if (comboBox_ISOTOPE_I.currentIndex !== index) {
                                                            comboBox_ISOTOPE_I.currentIndex = index
                                                        }
                                                        comboBox_ISOTOPE_I.currentIdNuclide = ID
                                                        comboBox_ISOTOPE_I.displayText = delegate_comboBox_ISOTOPE_I.text + " - " + delegate_comboBox_ISOTOPE_I_musnumber.text
                                                    }

                                                }
                                            }
                                        }

                                        RowLayout {
                                            spacing: 20
                                            Label {
                                                Layout.preferredWidth: 200
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Активность\nвыбранного изотопа"
                                            }
                                            TextField {
                                                id: txt_ACTIVITY_IODINE
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                                horizontalAlignment: Text.AlignHCenter
                                                placeholderText: qsTr("0.0")
                                                onFocusChanged: {
                                                    if (focus) { select(0, text.length) }
                                                }
                                            }
                                            Label {
                                                Layout.preferredWidth: 20
                                                Layout.alignment: Qt.AlignCenter
                                                text: "БК"
                                            }
                                        }

                                        RowLayout {
                                            spacing: 20
                                            Label {
                                                Layout.preferredWidth: 200
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Ожидаемая\nэффективная доза\nот выбранного изотопа йода\nза год"
                                            }
                                            TextField {
                                                id: txt_EXP_EFF_DOSE_I
                                                font.bold: true
                                                color: Material.color(Material.Teal)
                                                selectByMouse: true
                                                selectionColor: Material.color(Material.Red)
                                                horizontalAlignment: Text.AlignHCenter
                                                placeholderText: qsTr("0.0")
                                                onFocusChanged: {
                                                    if (focus) { select(0, text.length) }
                                                }
                                            }
                                            Label {
                                                Layout.preferredWidth: 20
                                                Layout.alignment: Qt.AlignCenter
                                                text: "БК"
                                            }
                                        }

                                        RowLayout {
                                            spacing: 20
                                            Label {
                                                Layout.preferredWidth: 170
                                                Layout.alignment: Qt.AlignCenter
                                                text: "Дата измерения"
                                            }
                                            MyCalendar {
                                                id: calendar_SICH_IODINE
                                                date_val: new Date()
                                                //enabled: true
                                            }
                                        }
                                    }


                                    /// КНОПКА ДОБАВИТЬ ДАННЫЕ
                                    Row {
                                        anchors.bottom: parent.bottom
                                        anchors.right: parent.right
                                        anchors.margins: 10
                                        spacing: 10
                                        opacity: (!button_addInTempleTableIodineSICH.enabled) ? 0.2 : 0.9
                                        Text {
                                            anchors.verticalCenter: parent.verticalCenter
                                            text: qsTr("Добавить")
                                            font.pixelSize: 16
                                        }

                                        Rectangle {
                                            id: button_addInTempleTableIodineSICH
                                            property var currentColor
    //                                        anchors.bottom: parent.bottom
    //                                        anchors.right: parent.right
    //                                        anchors.margins: 10
                                            anchors.verticalCenter: parent.verticalCenter
                                            height: 40
                                            width:  40
                                            radius: 50
                                            color: "transparent"

                                            enabled: {
                                                var isOk

                                                if (currentPerson !== undefined) { isOk = true }
                                                else              { isOk = false; return isOk; }

                                                if (calendar_SICH_IODINE.ready) { isOk = true }
                                                else               { isOk = false; return isOk; }

                                                if (comboBox_ISOTOPE_I.currentIndex >= 0) { isOk = true  }
                                                else                      { isOk = false; return isOk; }


                                                return isOk;
                                            }

                                            Image {
                                                anchors.centerIn: parent
                                                source: "icons/Plus.svg"
                                                sourceSize.height: 18
                                                sourceSize.width: 18
                                                fillMode: Image.Stretch
                                            }
                                            //                                    transitions: Transition {
                                            //                                        ColorAnimation { properties: "color"; duration: 1000 }
                                            //                                    }
                                            MouseArea {
                                                anchors.fill: parent
                                                enabled: button_addInTempleTableIodineSICH.enabled
                                                hoverEnabled: true
                                                onEntered:  { parent.color = "#EEEEEE"     ; parent.currentColor = "#EEEEEE" }
                                                onExited:   { parent.color = "transparent" ; parent.currentColor = "transparent" } //LightGray
                                                onPressed:  { parent.color = "#dbdbdb" }
                                                onReleased: { parent.color = parent.currentColor }
                                                onClicked:  {
                                                    if(calendar_SICH_IODINE.ready) {
                                                        listModel_SICH_IODINE.append({     isotope_:           comboBox_ISOTOPE_I.displayText,
                                                                                           id_nuclide_:        comboBox_NUCLIDE.currentIdNuclide,
                                                                                           activity_iodine_: ( txt_ACTIVITY_IODINE.text.length > 0 )  ? txt_ACTIVITY_IODINE.text  : "0",
                                                                                           eff_dose_i_:       ( txt_EXP_EFF_DOSE_I.text.length   > 0 ) ? txt_EXP_EFF_DOSE_I.text   : "0",
                                                                                           data_:             calendar_SICH_IODINE.date_val
                                                                                       })
                                                    }

                                                }
                                            }
                                        }
                                    }


                                }

                                /// КНОПКА ОТМЕНА
                                Button {
                                    id: button_canselSICH_IODINE

                                    anchors.right: button_insertSICH_IODINE.left
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 20
                                    text: "Отмена"
                                    onClicked: {
                                        popup_addInIodineSICH.close();
                                    }
                                }

                                /// КНОПКА СОХРАНИТЬ НОВЫЕ ДАННЫЕ В БД
                                Button {
                                    id: button_insertSICH_IODINE

                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    anchors.margins: 20
                                    text: "Сохранить"

                                    enabled: {
                                        var isOk

                                        if (currentPerson !== undefined)        { isOk = true    }
                                        else                        { isOk = false; return isOk; }

                                        if (table_IodineSICH.currentIndex_ > -1) { isOk = true  }
                                        else                        { isOk = false; return isOk; }


    //                                    if (calendar_DATE_TIME_controlSICH.ready) { isOk = true    }
    //                                    else                          { isOk = false; return isOk; }

                                        return isOk;
                                    }

                                    onClicked: {
                                        if (main_.currentPerson == undefined) return false;

                                        var data_arr = {}

                                        popup_addInIodineSICH.countData = 0;
                                        for (var i = 0; i < listModel_SICH_IODINE.count; i++) {
                                            popup_addInIodineSICH.countData ++;
                                            data_arr["ID_PERSON"]        = parseFloat( main_.currentPerson );
                                            data_arr["NUCLIDE"]          = parseFloat( listModel_SICH_IODINE.get(i).id_nuclide_  );     //.replace(",", ".") );
                                            data_arr["ACTIVITY_IODINE"]  = parseFloat( listModel_SICH_IODINE.get(i).activity_iodine_ ); //.replace(",", ".") );
                                            data_arr["EXP_EFF_DOSE_I"]   = parseFloat( listModel_SICH_IODINE.get(i).eff_dose_i_ );      //.replace(",", ".") );
                                            data_arr["DATE_TIME"]        = listModel_SICH_IODINE.get(i).data_;

                                            var nameQuery = "q1__insertInIodineSICH" + popup_addInIodineSICH.countData;


    //                                        console.log(" (!) data_arr = ", data_arr["ORGAN"], data_arr["NUCLIDE"],
    //                                                                        data_arr["ACTIVITY_MEASURE"], data_arr["EXP_EFF_DOSE_M"],
    //                                                                        data_arr["DATE_TIME"]);

                                            Query1.insertRecordIntoTable(nameQuery ,"IN_IODINE", data_arr);
                                            popup_addInIodineSICH.close();
                                        }


                                        //Query1.insertRecordIntoTable("SICH_MEASHURE" ,"IN_MEASURE", data_arr) //wc_query.map_data
                                        //create_confirm(data_arr)
                                    }
                                }

                                /// ТАБЛИЦА С НОВЫМИ ДАННЫМИ
                                Rectangle {
                                    id: rect_listView_I
                                    anchors.top: parent.top
                                    anchors.left: parent.left
                                    anchors.bottom: parent.bottom
                                    //anchors.leftMargin: 10
                                    width: 400
                                    Rectangle {
                                        id: rect_header_listView_I
                                        anchors.top: parent.top
                                        anchors.left: parent.left
                                        anchors.right: parent.right
                                        height: 40
                                        color: "transparent" //"#9E9E9E"
                                        enabled: (table_IodineSICH.currentIndex_ == -1) ? false : true
                                        opacity: (table_IodineSICH.currentIndex_ == -1) ? 0.2 : 0.9
                                        Row {
                                            anchors.verticalCenter: parent.verticalCenter
                                            anchors.right: parent.right
                                            spacing: 10
                                            Text {
                                                anchors.verticalCenter: parent.verticalCenter
                                                text: qsTr("Удалить")
                                                font.pixelSize: 16
                                            }

                                            Rectangle {
                                                //id: button_addMeasureSICH
                                                property var currentColor
                                                anchors.verticalCenter: parent.verticalCenter
                                                height: 40
                                                width:  40
                                                radius: 50
                                                color: "transparent"
                                                Image {
                                                    anchors.centerIn: parent
                                                    source: "icons/Minus.svg"
                                                    sourceSize.height: 18
                                                    sourceSize.width: 18
                                                    fillMode: Image.Stretch
                                                }
            //                                    transitions: Transition {
            //                                        ColorAnimation { properties: "color"; duration: 1000 }
            //                                    }
                                                MouseArea {
                                                    anchors.fill: parent
                                                    hoverEnabled: true
                                                    onEntered:  { parent.color = "#EEEEEE"     ; parent.currentColor = "#EEEEEE" }
                                                    onExited:   { parent.color = "transparent" ; parent.currentColor = "transparent" } //LightGray
                                                    onPressed:  { parent.color = "#dbdbdb" }
                                                    onReleased: { parent.color = parent.currentColor }
                                                    onClicked:  {
                                                        listModel_SICH_IODINE.remove(table_IodineSICH.currentIndex_)
                                                    }
                                                }
                                            }


                                        }

                                    }

                                    /// таблица с данными нуклидов по ИЗМЕРИТЕЛЬНОМУ СИЧ (MeasureSICH)
                                    Rectangle {
                                        //id: rect_listView
                                        anchors.top: rect_header_listView_I.bottom
                                        anchors.left: parent.left
                                        anchors.bottom: parent.bottom
                                        anchors.right: parent.right

                                        border.color: "LightGray"
                                        clip: true

                                        MyListViewTable_dynamic {
                                            id: table_IodineSICH
                                            model_:
                                                ListModel {
                                                    id: listModel_SICH_IODINE
                                                }
                                            columnCount: 4
                                            headerHeight: 40
                                            headerNames: {
                                                var names = [];
                                                names[0] = "Изотоп"
                                                names[1] = "Активность"
                                                names[2] = "Ожидаемая\nэфф. доза"
                                                names[3] = "Дата"
                                                return names;
                                            }
                                            roles_: {
                                                var roles = [];
                                                roles[0] = "isotope_" //listModel_SICH_MEASHURE.organ_;
                                                roles[1] = "activity_iodine_" //listModel_SICH_MEASHURE.activity_measure_;
                                                roles[2] = "eff_dose_i_" //listModel_SICH_MEASHURE.activity_measure_;
                                                roles[3] = "data_" //listModel_SICH_MEASHURE.activity_measure_;
                                                return roles;
                                            }
                                            abilitySelectRow: true

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


}







/*##^## Designer {
    D{i:1;invisible:true}D{i:102;invisible:true}D{i:162;invisible:true}
}
 ##^##*/
