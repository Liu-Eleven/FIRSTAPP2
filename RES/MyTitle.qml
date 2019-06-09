import QtQuick 2.4

Image {
    id: myTitle
    source: "qrc:/image/RES/title.png"
    smooth: true
    width: 1100*myRect.width/1920
    height: 80*myRect.height/1080
    property string myText: ""
    Text {
        id: text
        x:0
        y:0
        width: parent.width
        height: parent.height-parent.height*0.2
        text: myText
        font.family: "微软雅黑"
        font.pixelSize: 30*myMainScale
        font.bold: true
        color: "#3b713a"
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
    }
}
