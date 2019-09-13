import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Item {
    id: item_root_operdose

    height: 700//550
    width:  800

    signal set_OK()
    signal set_Cancel()

    Rectangle {
        id: header_rectangle
        color: "indianred"
        width: parent.width
        height: 40
        Label {
            id: header_caption
            text: "Оперативная доза члена бригады"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            font.pixelSize: 16
            color: "White"
            font.bold: true
        }
    }

    Pane {
        id: pane_oper_dose
        width: parent.width

        leftPadding: 1
        rightPadding: 1
        topPadding: 1
        bottomPadding: 1

        //anchors.margins: 10
        anchors.top: header_rectangle.bottom
        anchors.left: parent.left

        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }

        Column {
            anchors.fill: parent
            spacing: 10
            anchors.topMargin: 10

            Frame {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 10
                anchors.leftMargin: 10
                anchors.rightMargin: 10

                background: Rectangle {
                    anchors.fill: parent
                    border.color: "lightgrey"
                    color: "white"
                    radius: 2
                }

                Row {
                    spacing: 20
                    Frame {
                        id: frame1
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        width: height*(3/4)
                        background: Rectangle {
                            anchors.fill: parent
                            border.color: "lavender"
                            color: "whitesmoke"
                            radius: 2
                        }
                        Text {
                            text: "Фото"
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: 14
                            color: "gray"
                        }
                    }

                    Column {
                        spacing: 10
                        Row {
                            Text {
                                text: "Ф.И.О. : "
                                font.pixelSize: 20
                                width: 160
                            }

                            Text {
                                text: "Айболит Аркадий Иванович"
                                font.pixelSize: 20
                                color: "steelblue"
                            }
                        }
                        Row {
                            Text {
                                text: "Номер ТЛД : "
                                font.pixelSize: 16
                                width: 160
                            }

                            Text {
                                text: "* * * * *"
                                font.pixelSize: 16
                            }
                        }
                        Row {
                            Text {
                                text: "№ Наряда-допуска : "
                                font.pixelSize: 16
                                width: 160
                            }

                            Text {
                                text: "* * * * *"
                                font.pixelSize: 16
                            }
                        }
                        Row {
                            Text {
                                text: "Номер дозиметра : "
                                font.pixelSize: 16
                                width: 160
                            }

                            Text {
                                text: "* * * * *"
                                font.pixelSize: 16
                            }
                        }
                        Row {
                            Text {
                                text: "Номер кассетницы : "
                                font.pixelSize: 16
                                width: 160
                            }

                            Text {
                                text: "* * * * *"
                                font.pixelSize: 16
                            }
                        }
                    }
                }


            }

            Frame {
                id: frame
                //width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                padding: 1
                topPadding: 1
                bottomPadding: 1
                height: 90

                background: Rectangle {
                    anchors.fill: parent
                    border.color: "lightgrey"
                    color: "white"
                    radius: 2
                }

                //---
                RowLayout {
                    anchors.horizontalCenter: parent.horizontalCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    spacing: 100

                    RowLayout {
                        Layout.alignment: Qt.AlignBottom
                        Layout.fillWidth: true
                        spacing: 35

                        Column {
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            Text {
                                text: "Вход в зону контроля"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }

                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                TextField {
                                    id: id_sof_H
                                    width: 40
                                    height: 48
                                    bottomPadding: 14
                                    topPadding: 8
                                    //leftPadding: 8
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "08"
                                    font.pixelSize: 16
                                    selectByMouse: true

                                    validator: IntValidator {
                                        bottom: 0
                                        top: 1000
                                    }
                                }
                                Text {
                                    text: "ч"
                                    anchors.bottom: parent.bottom
                                    font.pixelSize: 14
                                    bottomPadding: 6
                                }
                                TextField {
                                    id: id_sof_m
                                    width: 40
                                    height: 48
                                    bottomPadding: 14
                                    topPadding: 8
                                    //leftPadding: 8
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "00"
                                    font.pixelSize: 16
                                    selectByMouse: true
                                    validator: IntValidator {
                                        bottom: 0
                                        top: 59
                                    }
                                }
                                Text {
                                    text: "мин"
                                    anchors.bottom: parent.bottom
                                    font.pixelSize: 14
                                    bottomPadding: 6
                                    rightPadding: 10
                                }
                                MyCalendar {
                                    id: id_sof_date
                                    date_val: new Date()
                                    enabled: true
                                }
                            }
                        }
                    }

                    RowLayout {
                        Layout.alignment: Qt.AlignBottom
                        Layout.fillWidth: true
                        //Layout.leftMargin: 10
                        Layout.topMargin: 10
                        spacing: 35

                        Column {
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            Text {
                                text: "Выход из зоны контроля"
                                anchors.horizontalCenter: parent.horizontalCenter
                                font.pixelSize: 14
                            }

                            Row {
                                anchors.horizontalCenter: parent.horizontalCenter
                                spacing: 10
                                TextField {
                                    id: id_eof_H
                                    width: 40
                                    height: 48
                                    bottomPadding: 14
                                    topPadding: 8
                                    //leftPadding: 8
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "17"
                                    font.pixelSize: 16
                                    selectByMouse: true
                                    validator: IntValidator {
                                        bottom: 0
                                        top: 1000
                                    }
                                }
                                Text {
                                    text: "ч"
                                    anchors.bottom: parent.bottom
                                    font.pixelSize: 14
                                    bottomPadding: 6
                                }
                                TextField {
                                    id: id_eof_m
                                    width: 40
                                    height: 48
                                    bottomPadding: 14
                                    topPadding: 8
                                    //leftPadding: 8
                                    horizontalAlignment: Text.AlignHCenter
                                    text: "00"
                                    font.pixelSize: 16
                                    selectByMouse: true
                                    validator: IntValidator {
                                        bottom: 0
                                        top: 59
                                    }
                                }
                                Text {
                                    text: "мин"
                                    anchors.bottom: parent.bottom
                                    font.pixelSize: 14
                                    bottomPadding: 6
                                    rightPadding: 10
                                }
                                MyCalendar {
                                    id: id_eof_date
                                    date_val: new Date()
                                    //cb_title: "Дата выдачи"
                                    enabled: true
                                }
                            }
                        }
                    }

                }
                //---
            }

            Frame {
                //width: parent.width
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                padding: 1
                topPadding: 1
                bottomPadding: 1
                height: 270

                background: Rectangle {
                    anchors.fill: parent
                    border.color: "lightgrey"
                    color: "white"
                    radius: 2
                }

                TabBar {
                    id: opdose_bar
                    width: parent.width
                    //currentIndex: 1
                    //topPadding: 10
                    TabButton {
                        text: "Индивидуальный эквивалент дозы"
                    }
                    TabButton {
                        text: "Мощность дозы"
                    }
                }

                StackLayout {
                    //width: parent.width
                    //anchors.fill: parent
                    anchors.top: opdose_bar.bottom
                    anchors.topMargin: 10
                    //height: 300
                    currentIndex: opdose_bar.currentIndex


                    Item {
                        id: iedTab

                        Column {
                            spacing: 10

                            Row {
                                spacing: 20
                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гамма излучение"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гумма излучение хрусталика глаза"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гамма излучение кожи, кистей и стоп"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                            }

                            Row {
                                spacing: 20

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Нейтронное излучение"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Бета излучение хрусталика глаза"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Бета излучение кожи, кистей и стоп"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                            }



                            Row {
                                spacing: 20

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гамма излучение низа живота"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Нейтронное излучение низа живота"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }
                            }

                        }

                    }

                    Item {
                        id: mdTab

                        Column {
                            spacing: 10

                            Row {
                                spacing: 20
                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гамма излучение"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гумма излучение хрусталика глаза"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гамма излучение кожи, кистей и стоп"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                            }

                            Row {
                                spacing: 20

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Нейтронное излучение"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Бета излучение хрусталика глаза"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Бета излучение кожи, кистей и стоп"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                            }



                            Row {
                                spacing: 20

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Гамма излучение низа живота"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
                                        }
                                    }
                                }

                                Column {
                                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                                    width: 240
                                    Text {
                                        text: "Нейтронное излучение низа живота"
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        font.pixelSize: 14
                                    }
                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        spacing: 10
                                        TextField {
                                            width: 60
                                            //height: 48
                                            horizontalAlignment: Text.AlignHCenter
                                            font.pixelSize: 16

                                            text: "0,0"
                                            selectByMouse: true
                                            validator: DoubleValidator {
                                                notation: DoubleValidator.StandardNotation
                                            }
                                        }
                                        Text {
                                            text: "мкЗв"
                                            font.pixelSize: 14
                                            bottomPadding: 6
                                            anchors.bottom: parent.bottom
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
        anchors.bottomMargin: 10
        anchors.rightMargin: 20
        text: "Сохранить"
        font.pixelSize: 14
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        onClicked: {
            item_root_operdose.set_OK()
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
            item_root_operdose.set_Cancel()
        }
    }

}
