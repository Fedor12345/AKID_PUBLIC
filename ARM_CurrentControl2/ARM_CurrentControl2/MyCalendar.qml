import QtQuick 2.12
import QtQuick.Controls 2.5
import Qt.labs.calendar 1.0
import QtQuick.Layouts 1.3

Item {
    id: root
    width: 135 //id_cb.width//+img_erase.width+8   //contentWidth
    height: id_cb.height //contentHeight

    property date date_val
    property bool ready: false
    property alias cbwidth: id_cb.width
    ComboBox {
        id: id_cb
        width: root.width //135
        padding: 0
        font.pixelSize: 16
        hoverEnabled: true
        displayText: !ready ? "":date_val.toLocaleDateString("ru_RU", date_val, "dd.MM.yyyy")

        indicator: Image {
            id: ind
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            source: "icons/calendar.svg"
            opacity: 0.7
        }

        popup: Popup {
            id: mycalendar
            parent: id_cb

            ColumnLayout {
                spacing: 1
                Rectangle {
                    id: rectangle
                    width:grid.width
                    height: 25
                    color: "LightGrey"
                    Label {
                        text: grid.title
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: parent.verticalCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        font.pixelSize: 14
                    }

                    Image {
                        //id: name
                        anchors.left: parent.left
                        source: "icons/menu-left.svg"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (grid.month === Calendar.January) {
                                    grid.year--
                                    grid.month = Calendar.December
                                } else {
                                    grid.month--
                                }
                            }
                        }
                    }
                    Image {
                        anchors.right: parent.right
                        source: "icons/menu-right.svg"
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if (grid.month === Calendar.December) {
                                    grid.year++
                                    grid.month = Calendar.January
                                } else {
                                    grid.month++
                                }
                            }
                        }
                    }
                }

                DayOfWeekRow {
                    locale: grid.locale
                    Layout.fillWidth: true
                    delegate: Text {
                        text: model.shortName
                        color: "SteelBlue"
                        font.pixelSize: 12
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                MonthGrid {
                    id: grid
                    month: date_val.getMonth()    //curmonth     //curdate.getMonth()//Calendar.December
                    year:  date_val.getFullYear() //curyear

                    locale: Qt.locale("ru_RU")
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    delegate: Text {
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        opacity: (model.month === grid.month) ? 1 : 0.5
                        text: model.day
                        //font: control.font
                        font.pixelSize: 12
//                        color: ((model.day === root.date_val.getDay() ) &&
//                               (model.month === root.date_val.getMonth()) &&
//                               (model.year === root.date_val.getFullYear()) ) ? "Blue" : "Black"

                        color: model.today ? "Crimson" : "Black"
                    }
                    onClicked: {
                        date_val = date
                        id_cb.popup.close()
                        ready = true
                    }
                }
            }
        }
    }

    Image {
        id: img_erase
        sourceSize.height: 16
        sourceSize.width: 16
        //anchors.verticalCenter: parent.verticalCenter
        anchors.right: id_cb.right
        anchors.bottom: id_cb.top

        anchors.leftMargin: 8
        source: "icons/eraser-variant.svg"
        opacity: 0.5

        MouseArea {
            anchors.fill: parent
            onClicked: {
                ready = false
                //date_val = null
            }
        }
    }

}
