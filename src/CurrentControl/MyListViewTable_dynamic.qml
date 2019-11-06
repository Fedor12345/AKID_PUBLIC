import QtQuick 2.10
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import QtQuick.Controls.Material 2.0

import MyTools 1.0
//import "ColorSettings.js" as ColorSettings

Rectangle {
    id: main_
    anchors.fill: parent
    property var  isEmpty: false              /// в случае если таблица пустая, можно задать информационный текст в поле заголовка таблицы заместо заголовков
    property var  columnCount                 /// количество столбцов (модель для рипитора, создающего столбцы в строке)
    property int  columnWidth: 120            /// ширина одного столбца
    property bool automaticСolumnWidth: true  /// если true, то ширина каждого отдельного столбца будет автоматически подстраиваться под длину его заголовка,
                                              /// если false, то  ширина всех столбцов будет равна columnWidth

    property int   rowHeight: 25            /// высота строк
    property var   roles_                   /// названия столбцов (имена ролей, тип string)
    property alias model_: listview.model_  /// модель

    property string headerColor: "#7c7c7c" /// цвет заголовков столбцов
    property int    headerHeight: 30       /// высота заголовков столбцов
    property var    headerNames            /// имена столбцов, если параметр не заданн, то имена берутся такие же как названия ролей (из параметра roles_)

    property bool abilitySelectRow: false               /// параметр влияет на то можно ли выделять любую строку в таблице кликом мыши
    property int  currentIndex_: listview.currentIndex  /// номер выбранной строки




    color: "transparent"
//    border {color: "#B0BEC5" /*ColorSettings.colorBorder*/}
//    radius: 7
//    clip: true

    Rectangle {
        parent: main_
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        color: "#7c7c7c" //ColorSettings.colorHederTable
        height: headerHeight
        //anchors.margins: 5
    }
    // скрол по горизонтали
    ScrollView {
        id: scrollView
        anchors.fill: parent
        //anchors.margins: 5
        clip: true
        //width: row_header.width
        contentWidth: row_header.width

        ScrollBar.horizontal.policy: ScrollBar.AlwaysOn //.AlwaysOn .AsNeeded
        ScrollBar.horizontal.interactive: true
        ScrollBar.vertical.policy: ScrollBar.AlwaysOff //ScrollBar.AsNeeded //


        bottomPadding: 14


        // заголовки столбцов таблицы
        Rectangle {
            id: header
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: headerHeight //; width: main_.width
            //border.width: 1
            color: main_.headerColor //"#7c7c7c" //ColorSettings.colorHederTable

            Row {
                id: row_header
                height: parent.height
                //anchors.verticalCenter: parent.verticalCenter
                //anchors.fill: parent
                Rectangle {
                    width: 20
                    height: parent.height
                    color: "transparent"
                    Label {
                        anchors.centerIn: parent
                        //text: "№"
                    }
                    Rectangle {
                        anchors.right: parent.right
                        height: parent.height
                        width: 1
                        color: "LightGray"
                    }
                }
                Repeater {
                    id: repeter_headers
                    model : main_.columnCount
                    Rectangle {
                        height: main_.headerHeight
//                        width: isEmpty ? label_header.width + 100 : main_.columnWidth  //main_.columnWidth
                        width: {
                            if (automaticСolumnWidth) {
                                var widthForAll = label_header.width + 15;
                                if ( widthForAll > 200 ) { widthForAll = 200 }
                                isEmpty ? label_header.width + 100 : widthForAll; // main_.columnWidth
                                listview.widthRowElements[index] = widthForAll;
                            }
                            else {
                                width: isEmpty ? label_header.width + 100 : main_.columnWidth
                            }
                        }


                        color: "transparent"
                        //border.width: 1
                        clip: true
                        Label {
                            id: label_header
                            anchors.centerIn: parent
                            text: {
                                // index - тут (в данном рипиторе) это будет номер столбца
                                //                                if(index === 0)
                                //                                    return ""
                                //                                else

                                if ( headerNames ) {
                                    if (headerNames[index]) {
                                        return headerNames[index]
                                    }
                                }
                                else {
                                    return main_.roles_[index];
                                }
                                //return eval(main_.roles_[index]); // создает переменную с именем из текстовой строки
                            }
                            color: isEmpty ? "#ffbfbf" : "white"
                            font.bold: true
                        }
                        // черточка, ограничивающая заголовки столбцов (зажав по ней мышью, можно менять ширину столбцов)
                        Rectangle {
                            anchors.right:  parent.right
                            anchors.top:    parent.top
                            anchors.bottom: parent.bottom
                            anchors.topMargin:    index==main_.columnCount-1 ? 0 : 7
                            anchors.bottomMargin: index==main_.columnCount-1 ? 0 : 7

                            color: "Silver"
                            //height: parent.height - 10
                            width: 1
                            //border.width: 5
                            MouseArea {
                                x: -15
                                width: parent.width + 30
                                height: parent.height
                                property bool fl_click: false

                                drag.target: parent
                                drag.axis: Drag.XAxis
                                drag.minimumX: 40
                                drag.maximumX: 500 //repeter_headers.itemAt(index).width //1000

                                hoverEnabled: true
                                onMouseXChanged:
                                {
                                    if(fl_click) {
                                        repeter_headers.itemAt(index).width = parent.x + 1
                                        //listview.getRepeterEl_fun(index,parent.x)
                                        listview.changeWhidth(index,parent.x+1)
                                    }
                                }
                                onClicked:
                                {
                                    //repeter_headers.itemAt(index).width = 50;
                                }
                                onEntered:   // мышь на элементе
                                {
                                    //if(fl_click) {
                                    //}
                                    //console.log("I am " + index + " ");// + repeter_headers.itemAt(0).width
                                }
                                onPressed: // мышь зажата на элементе
                                {
                                    parent.anchors.right = undefined;
                                    parent.anchors.left = undefined;

                                    fl_click = true;
                                    //console.log("I am " + index + " " + mouse.x);// + repeter_headers.itemAt(0).width
                                }
                                onReleased:  // мышь отжала элемент
                                {
                                    fl_click = false;
                                    //console.log("Bye " + mouse.x)
                                }

                                CursorShapeArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.SplitHCursor // Qt.OpenHandCursor //Qt.PointingHandCursor
                                }

                            }
                        }
                    }



                }
            }

        }



        // сама таблица
        ListView {
            id: listview
            property var model_   //модель
            signal changeWhidth(var index, var x)
            property var widthRowElements: {
                var width_m = [];
                for (var i = 0; i < main_.columnCount; i++) {
                    width_m[i] = main_.columnWidth;
                }
                return width_m;
            }

//            property var repeter_rows_EL : {
//                for(var child in listview.contentItem.children) {
//                     if(contentItem.children[0]) {
//                        if(listview.contentItem.children[child].children[2]) {
//                            //console.log(child + "   "+ listview.contentItem.children[child].children[2].children[0].children[0])
//                            return listview.contentItem.children[child].children[2].children[0]; //.children[0]
//                        }
//                    }
//                }
//            }
            //функция больше нигде не используется
            function getRepeterEl_fun(index, x){
//                for(var child in listview.contentItem.children) {
//                     if(contentItem.children[0]) {
//                        if(listview.contentItem.children[child].children[2]) {
//                            //el[child] = listview.contentItem.children[child].children[2].children[0].children[index].width;
//                            //                       (delegate[номер делегата]) (стоблец)     (строка) (элемент, который нужно поменять)
//                            //console.log("x = ", x)
//                            listview.contentItem.children[child].children[2].children[0].children[index].width = x;
//                        }
//                    }
//                }


            }

            //anchors.fill: parent
            anchors.top: header.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            clip: true
            focus: true
            highlightFollowsCurrentItem: abilitySelectRow ? true : false
            highlight: Rectangle {
                color: "#b2b2b2" // "transparent" // "#FF5722" //"#c9c9c9" // "#B0BEC5" //Material.color(Material.Grey, Material.Shade700)
                //border.color: "#FF5722"
            }
            highlightMoveDuration: 100
            //    highlight: Rectangle {
            //        color: Material.color(Material.Teal)
            //        radius: 5
            //    }

            ScrollBar.vertical: ScrollBar {
                policy: "AsNeeded" //"AlwaysOn" //policy: ScrollBar.AlwaysOn
                parent: scrollView
                anchors.top: parent.top; anchors.topMargin: header.height
                anchors.bottom: parent.bottom
                anchors.right: parent.right
//                contentItem: Rectangle {
//                    opacity: 0.5
//                    color: ColorSettings.colorButton
//                    radius: 100
//                }
            }
            //    ScrollBar.horizontal: ScrollBar {
            //        //interactive: true
            //        policy: "AlwaysOn"
            //    }

            model: listview.model_  //ModelDB //listModel

            delegate: Component {
                id: component_delegate

                ItemDelegate {
                    id: delegate_comp
                    width: parent.width
                    height: rowHeight                    
                    property int row: index

                    property var repeter_rows_EL : repeter_rows

                    Connections {
                        target: listview
                        onChangeWhidth: {
                            listview.widthRowElements[index] = x;
                            repeter_rows.itemAt(index).width = x; //listview.widthRowElements[index];
                        }

                    }

                    onClicked: {
                        if (listview.currentIndex !== index) {
                            listview.currentIndex = index
                        }
                    }

                    //border {width: 1; color:"#B0BEC5"}
                    //color: "transparent"

                    Column {
                        // создается строка с рипитором, который создает столбцы
                        Row {
                            Rectangle {
                                width: 20
                                height: parent.height
                                //border.color: "LightGray"
                                color: "transparent"
                                Label {
                                    anchors.centerIn: parent
                                    text: delegate_comp.row
                                    color: abilitySelectRow ? (listview.currentIndex == index ? "white" : "#b2b2b2" )  : "#b2b2b2"
                                }
                                Rectangle {
                                    anchors.right: parent.right
                                    height: parent.height
                                    width: 1
                                    color: "LightGray"
                                }
                            }

                            Repeater {
                                id: repeter_rows
                                model : main_.columnCount

                                Rectangle {
                                    clip: true
                                    // index - тут (в данном рипиторе) это будет номер столбца
                                    height: main_.rowHeight
                                    width:  //main_.columnWidth
                                    {
                                        return listview.widthRowElements[index];
                                    }
                                    color: "transparent"
                                    //border {width: 1;/* color:"white"*/}                                    

                                    Label {
                                        id: label_row
                                        anchors.centerIn: parent
                                        text: eval(main_.roles_[index]); // создает переменную с именем из текстовой строки
                                    }
                                    Rectangle {
                                        color: "Silver"
                                        height:main_.rowHeight //parent.height
                                        width: index==main_.columnCount-1 ? 1 : 0
                                        anchors.right:parent.right
                                        //border.width: 5
                                    }

                                    CursorShapeArea {
                                        anchors.fill: parent
                                        cursorShape: Qt.PointingHandCursor // Qt.OpenHandCursor //Qt.PointingHandCursor
                                    }
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


        }


    }

}
