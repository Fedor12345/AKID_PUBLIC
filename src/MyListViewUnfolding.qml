import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

//MyListViewUnfolding.qml
Rectangle {
    id: container
    width: 350 //; height: 450
    color: Material.color(Material.Grey, Material.Shade800)
    property alias model: view.model
    signal currentName(string name)




    ListModel {
        id: modelListViewTest

        ListElement { name: "--- 1";     header: "" }
        ListElement { name: "--- 2.1";   header: "2" }
        ListElement { name: "--- 2.2";   header: "2" }
    }


    ListView {
        id: view
        anchors.fill: parent
        // width: parent.width



        signal sectionClicked(string name)
        model: modelListViewTest
        delegate:  ItemDelegate {
                      id: delegateList

                      width: container.width
                      height: {
                          if (header === "") { mainText.height+10 }
                          else                { shown ? (mainText.height+10) : 0 }
                      }
                      visible: (header === "") ? true : shown

                      property bool shown: false

                      Text {
                          id: mainText;
                          anchors.verticalCenter: parent.verticalCenter
                          anchors.left: parent.left
                          anchors.leftMargin: (header==="") ? 35 : 50
                          text: name;
                          font.bold:  (header==="") ? true : false
                          font.pixelSize: 18
                          color: "white"
                      }
                      onClicked: {
                          console.log("Click: " + " " + index)
                          if (view.currentIndex !== index) {
                              view.currentIndex = index
                          }
                          container.currentName(mainText.text)
                      }
                      Connections {
                          target: view // (!) delegateList.ListView.view
                          onSectionClicked: if (delegateList.ListView.section === name) shown = !shown;
                      }

                      Behavior on height {
                          NumberAnimation { duration: 200 }
                      }

                      Behavior on visible {
                          NumberAnimation { duration: 200 }
                      }


                  }



        section.property: "header"
        section.criteria: ViewSection.FullString
        section.delegate: ItemDelegate {
                              id: sectionHeadingRectangle

                              property var isCurrent: ListView.isCurrentItem
                              property bool isOpen: true

                              visible: (section==="") ? false : true
                              width:   (section==="") ? 0 : container.width
                              height:  (section==="") ? 0 : txt1.height+10 //childrenRect.height

//                              Rectangle {
//                                anchors.fill: parent
//                                color: Material.color(Material.BlueGrey)
//                              }

                              // + -
                              Item {
                                  anchors.verticalCenter: parent.verticalCenter
                                  anchors.left: parent.left
                                  anchors.leftMargin: 7
                                  width: 20
                                  height: 20

                                  Rectangle {
                                    anchors.fill: parent
                                    color: isOpen ? Material.color(Material.Lime) : Material.color(Material.Amber)
                                    visible: (section==="") ? false : true
                                  }
                                  Image {
                                      id: iname
                                      anchors.centerIn: parent
                                      width: 14
                                      height: 14
                                      source: isOpen ? "icons/Minus.svg" : "icons/Plus.svg"
    //                                  sourceSize.height: 14
    //                                  sourceSize.width:  14
                                      fillMode: Image.Stretch
                                      visible: (section==="") ? false : true
                                  }
                              }


                              Text {
                                  id: txt1
                                  anchors.verticalCenter: parent.verticalCenter
                                  anchors.left: parent.left
                                  anchors.leftMargin: 35
                                  text: section
                                  font.bold: true
                                  font.pixelSize: 20;
                                  color: "white"
                                  visible: (section==="") ? false : true
                              }

                              onClicked: {
                                  console.log("Click: " + section)
                                  view.sectionClicked(section)
                                  isOpen = !isOpen
                              }
                          }



        highlight: Rectangle {
            color: Material.color(Material.Grey, Material.Shade700)
            Image {
                id: idrop
                width: 24
                height: 24
                source: "icons/arrow-down-drop.svg"
                sourceSize.height: 24
                sourceSize.width: 24
                fillMode: Image.Stretch
                rotation: 90
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

            }
//            Rectangle {
//                anchors.verticalCenter: parent.verticalCenter
//                anchors.right: parent.right
//                anchors.rightMargin: 5
//                height: 20
//                width: 20
//                color: "White" //Material.color(Material.BlueGrey)
//            }
        }
        highlightMoveDuration: 200

    }
}



