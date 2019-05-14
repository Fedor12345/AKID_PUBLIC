import QtQuick 2.12
import QtQuick.Controls 2.5

BusyIndicator {
    id: busy_control

    running: false

    //anchors.left: err_label.right
    anchors.verticalCenter: parent.verticalCenter
    //anchors.horizontalCenter: parent.horizontalCenter
    //anchors.leftMargin: 10
    //width: 40
    //height: 40

    property int biwidth: 50//40
    property int biheight: 50//40
    property int biradius: 4

    contentItem: Item {
        implicitWidth: busy_control.biwidth      //40//64
        implicitHeight: busy_control.biheight    //40//64

        Item {
            id: bcitem
            x: parent.width / 2 - busy_control.biwidth/2     //20//32
            y: parent.height / 2 - busy_control.biheight/2   //20//32
            width: busy_control.biwidth   //40//64
            height: busy_control.biheight //40//64
            opacity: busy_control.running ? 1 : 0

            Behavior on opacity {
                OpacityAnimator {
                    duration: 250
                }
            }

            RotationAnimator {
                target: bcitem
                running: busy_control.visible && busy_control.running
                from: 0
                to: 360
                loops: Animation.Infinite
                duration: 2500//1250
            }

            Repeater {
                id: bcrepeater
                model: 6

                Rectangle {
                    x: bcitem.width / 2 - width / 2
                    y: bcitem.height / 2 - height / 2
                    implicitWidth: busy_control.biradius*2//8
                    implicitHeight: busy_control.biradius*2//8
                    radius: busy_control.biradius // 4
                    color: "gainsboro"

                    transform: [
                        Translate {
                            y: -Math.min(bcitem.width, bcitem.height) * 0.5 + 5
                        },
                        Rotation {
                            angle: index / bcrepeater.count * 360
                            origin.x: busy_control.biradius //4
                            origin.y: busy_control.biradius //4
                        }
                    ]
                }
            }
        }
    }
}
