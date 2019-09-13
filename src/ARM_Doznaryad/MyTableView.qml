import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.3

Item {
    id: root

    property alias mtlistview: listview
    property ListModel listview_header
    property alias listview_model: listview.model
    property alias currentIndex: listview.currentIndex

    signal changeitem(var indx)
    signal dblclickeditem(var indx)

    property bool horizontal_scrollbar_on_off: true
//    !!!
//    модель для колонок таблицы > name(название колонки) - width_val(ширина) - trole(имя роли)
//    ListModel {
//        ListElement { name: "Номер";         width_val: 100; trole: "number" }
//        ListElement { name: "ЦЕХ";           width_val: 70;  trole: "id_department"}
//        ListElement { name: "Ответственный"; width_val: 150; trole: "id_responsible"}
//    }

    ScrollView {
        anchors.fill: root
        clip: true
        contentWidth:myheader.width

        //height: 200
        ScrollBar.horizontal.policy: horizontal_scrollbar_on_off ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff
        ScrollBar.horizontal.interactive: true

        //заголовок таблицы
        bottomPadding: horizontal_scrollbar_on_off ? 20 : 1
        Rectangle {
            id: r1
            anchors.top: parent.top
            width: parent.width
            height: myheader.height

            Row {
                id: myheader
                spacing: 0

                Rectangle {
                    width: 15
                    height: myheader.height
                    color: "#00000000"
                    border.color: "#c6bebe"
                }

                Repeater {
                    id: header_repeater
                    model: listview_header

                    Rectangle {
                        width: model.width_val
                        height: ltext.height+10
                        color: "#00000000"
                        border.color: "#c6bebe"

                        Label {
                            id: ltext
                            text: model.name
                            font.bold: true
                            font.pointSize: 10
                            anchors.centerIn: parent
                        }
                    }
                }
            }
        } // - конец заголовок

        ListView {
            id: listview
            anchors.top: r1.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            //model: myModel
            clip: true
            focus: true

            highlightFollowsCurrentItem: true

            highlight: Rectangle {
                color: Material.color(Material.BlueGrey, Material.Shade200)
            }
            highlightMoveDuration: 0

            delegate: Component {
                id: listitem_delegate
                ItemDelegate {
                    id: listitem_wrapper
                    width: parent.width
                    height: 25//30
                    property int row: index

                    onClicked: {
                        listview.currentIndex = index
                        root.changeitem(index)
                    }

                    onDoubleClicked: {
                        root.dblclickeditem(index)
                    }

                    Column {
                        Row {
                            Rectangle {
                                width: 30//15
                                height: listitem_wrapper.height
                                color: "Transparent"
                                Label {
                                    verticalAlignment: Text.AlignVCenter
                                    height: parent.height
                                    leftPadding: 5
                                    font.pointSize: 10
                                    text: listitem_wrapper.row+1
                                }
                            }

                            Repeater {
                                model: listview_header.rowCount()//header_model.rowCount()

                                Label {
                                    id: lb_item
                                    property int column: index
                                    width: listview_header.get(column)["width_val"]
                                    height: listitem_wrapper.height
                                    leftPadding: 10
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 10

                                    text: if ((column > -1) & (listitem_wrapper.row > -1)) {
                                              if (listview_header.get(column)["trole"].toString().length > 0) {
                                                  listview.model.get(listitem_wrapper.row)[listview_header.get(column)["trole"]]
                                              } else {"-"}
                                          } else {""}

                                }
                            }
                        }
                        Rectangle {
                            color: "Silver"
                            width: parent.width
                            height: 1
                        }
                    }
                }
            }

            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOn
                parent: root.parent
                anchors.top: parent.top //r1.bottom
                anchors.topMargin: myheader.height//parent.topPadding
                anchors.right: parent.right
                anchors.rightMargin: 1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: parent.bottomPadding

            }
        }
    }
}







/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
