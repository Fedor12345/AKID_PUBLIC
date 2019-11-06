import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Page {
    id: main_
    transformOrigin: Item.Center


    //    Text {
    //        anchors.centerIn: parent
    //        text: "Тест Системы подключений к БД"
    //    }


    Pane {
        id: test_elevation
        property double elevation_: 1.0
        //anchors.verticalCenter: parent.verticalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        anchors.left: parent.left
        anchors.leftMargin: 50
        width: 120
        height: 120

        Material.elevation: elevation_

        Rectangle {
            anchors.fill:  parent
            border.width: 1
        }

        MouseArea {
            anchors.fill: parent
            anchors.margins: -10
            hoverEnabled: true
            onEntered:  { test_elevation.animationStart(1.0, 6.0,"elevation_" ) }
            onExited:   { test_elevation.animationStart(6.0, 1.0,"elevation_" ) }
            onPressed:  {  }
            onReleased: {  }
            onClicked:  {
                console.log(" (!) CLICK! ")
            }
        }

        function animationStart (startValue, endValue, properties) {
            animation_1.startValue = startValue;
            animation_1.endValue = endValue;
            animation_1.properties = properties;
            animation_1.stop();
            animation_1.running = true;
        }
        NumberAnimation {
            id: animation_1
            property double startValue
            property double endValue
            target: test_elevation
            //properties: "elevation_"
            //easing.type: Easing.InOutElastic
            from:
            {
                return startValue
            }
            to:
            {
                return endValue
            }
            duration: 200
            running: false
        }



        Label {
            text: qsTr("START\nTEST")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: rect_param
        anchors.top: parent.top
        anchors.topMargin: 20
        anchors.bottom: parent.bottom
        anchors.left: test_elevation.right
        anchors.leftMargin: 20
        width: 372
        color: "transparent"
        border.color: "LightGray"

        ColumnLayout {
            id: columnLayout
            height: 299
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10


            RowLayout {
                id: rowLayout_headersQuery
                width: parent.width
                height: 100
                Layout.preferredWidth: -1
                Layout.preferredHeight: -1
                spacing: 30
                Layout.fillHeight: false
                Layout.fillWidth: true

                Label {
                    id: label_header_1
                    text: qsTr("Описание")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.minimumWidth: 200
                    Layout.fillHeight: false
                    Layout.fillWidth: false
                    horizontalAlignment: Text.AlignLeft
                    Layout.preferredWidth: -1
                }

                Label {
                    id: label_header_2
                    text: qsTr("Количество")
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    Layout.fillWidth: true
                    Layout.preferredWidth: -1
                }
            }

            Label {
                id: label_sqlQueries
                text: qsTr("SQL запросы")
                verticalAlignment: Text.AlignBottom
                Layout.preferredHeight: 40
                Layout.fillWidth: true
                Layout.minimumHeight: 40
                //Qt.AlignVCenter
                Layout.fillHeight: true
                horizontalAlignment: Text.AlignLeft
                Layout.minimumWidth: 0
            }




            RowLayout {
                id: rowLayout_insert
                width: 100
                height: 100
                Layout.fillWidth: true
                CheckBox {
                    id: checkBox_insert
                    text: qsTr("Insert запросы")
                    Layout.fillWidth: true
                }

                TextField {
                    id: textField_insert
                    text: qsTr("1")
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            RowLayout {
                id: rowLayout_update
                width: 100
                height: 100
                Layout.fillWidth: true
                CheckBox {
                    id: checkBox_update
                    text: qsTr("Update запросы")
                    Layout.fillWidth: true
                    Layout.fillHeight: false
                }

                TextField {
                    id: textField_update
                    text: qsTr("1")
                    horizontalAlignment: Text.AlignHCenter
                }
            }


            RowLayout {
                id: rowLayout_select
                width: 100
                height: 100
                Layout.fillHeight: false
                Layout.fillWidth: true

                CheckBox {
                    id: checkBox_select
                    text: qsTr("Select запросы")
                    Layout.minimumWidth: 150
                    Layout.fillWidth: true
                }

                TextField {
                    id: textField_select
                    text: qsTr("1")
                    Layout.minimumWidth: 0
                    Layout.fillWidth: false
                    Layout.preferredWidth: -1
                    Layout.preferredHeight: -1
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            RowLayout {
                id: rowLayout_delete
                width: 100
                height: 100
                CheckBox {
                    id: checkBox_delete
                    text: qsTr("Delete запросы")
                    Layout.fillWidth: true
                }

                TextField {
                    id: textField_delete
                    text: qsTr("1")
                    horizontalAlignment: Text.AlignHCenter
                }
                Layout.fillWidth: true
            }

            Label {
                id: label_sqlModels
                text: qsTr("SQL модели")
                Layout.preferredHeight: 40
                verticalAlignment: Text.AlignBottom
                Layout.minimumHeight: 40
                Layout.fillHeight: false
                Layout.fillWidth: false
                Layout.rowSpan: 1
            }

            RowLayout {
                id: rowLayout_models
                width: 100
                height: 100
                CheckBox {
                    id: checkBox_model
                    text: qsTr("Обновление модели")
                    Layout.fillWidth: true
                }

                TextField {
                    id: textField_model
                    text: qsTr("1")
                    horizontalAlignment: Text.AlignHCenter
                }
            }








        }


    }

    Rectangle {
        id: rect_nfo
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: rect_param.right
        anchors.margins: 20
        anchors.right: parent.right
        color: "transparent"
        border.color: "LightGray"
    }

}




/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:7;anchors_height:110;anchors_width:356;anchors_x:8;anchors_y:8}
}
 ##^##*/
