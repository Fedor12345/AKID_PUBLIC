import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4

import QtQuick.Extras 1.1
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Window 2.0

//import "ColorSettings.js" as ColorSettings


Rectangle {
    id: rect_main
    property bool headerVisible: true
    property bool shadow: false
    property string header //текст заголовка
    property var childrenMainList: [] //что бы рамка подсвечивалась, сюда необходимо перечислить id элементов, отображаемых внутри RectangleWithHeader
    property int pixelSizeHeder: 15 //размер текста заголовка

    property string colorBackground: "transparent"
    property string colorType: "Dark"
    property string colorBorder: ColorSettings.colorBorder
    property string colorBorderFocus: {  //"#778899" //цвет рамки
                                    if(colorType=="Dark" || colorType=="dark")   return ColorSettings.colorBorderDark
                                    if(colorType=="Light" || colorType=="light") return ColorSettings.colorBorderLight
                                    return ColorSettings.colorBorder
                                 }
    property string colorShadow: { //цвет подсветки рамки //"#778899"
                                   if(colorType=="Dark" || colorType=="dark")   return ColorSettings.colorShadowDark
                                   if(colorType=="Light" || colorType=="light") return ColorSettings.colorShadowLight
                                   return ColorSettings.colorShadow
                                 }


    property bool focusRect: false
    property real shadowRadius: { //продимся по с писку элементов внутри рамки и в случае если кто-то из них в фокусе, то рамка подсвечивается
        //console.log("childrenMainList: ", childrenMainList);
        if(shadow) {
            for (var i=0;i<childrenMainList.length;i++) {
                if(childrenMainList[i].focus){ //если среди элементов есть выделенные мышью, т.е. в фокусе
                    focusRect = true;
                    return 8.0 //размер подсветки
                }
            }
        }
        focusRect = false;
        return 0.0;
    }


    color: "transparent"
    width: label_heder.width + 70
    height: 70

    // прямоугольник с тенью и рамкой
    Rectangle {
        anchors.fill:parent
        border {
            width: 1
            color: { //colorBorder
                     if(focusRect) {return colorBorderFocus}
                     else return colorBorder;
                   }
        }
        layer.enabled: {if(shadow){return true}; return false}
        layer.effect: DropShadow {
            radius: shadowRadius //8.0
            transparentBorder: true
            samples: 17
            color: colorShadow //"#12956c" //"lightslategray"
        }
        color: colorBackground
    }

    // второй контур для заголовока
    Rectangle {
        //id: rect_
        visible: (headerVisible) ? true : false
        anchors.top: parent.top
        anchors.topMargin: -7
        anchors.left: parent.left
        anchors.leftMargin: 10
        width: label_heder.width + 10
        height: label_heder.height + 4
        color: "white"
        layer.enabled: {if(shadow){return true}; return false}
        layer.effect: DropShadow {
            radius: shadowRadius //8.0
            transparentBorder: true
            samples: 17
            color: colorShadow//"lightslategray"
        }
        border {
            width: { //colorBorder
                    if(focusRect) {return 1}
                    else return 1;
                   }
            color: { //colorBorder
                    if(focusRect) {return colorBorderFocus}
                    else return colorBorder;
                   }
//            width: 1
//            color: "#12956c"
        }
        Label {
            id: label_heder
            visible: (headerVisible) ? true : false
            //anchors.centerIn: parent
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: pixelSizeHeder
            text: header
        }
    }




}
