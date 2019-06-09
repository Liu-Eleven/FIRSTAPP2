import QtQuick 2.4
import QtMultimedia 5.0

Image {
    id: myChildItem
    width: 260*myMainScale
    height: 50*myMainScale
    smooth: true
    x:parent.width/2-myChildItem.width/2
    property int myIndex: -1
    property string myText: ""
    property string myPath: ""
    property string mySourceNormal: "qrc:/image/RES/item.png"
    property string mySourcePress: "qrc:/image/RES/itempress.png"
    property string mySourceHover: "qrc:/image/RES/itemhover.png"
    signal buttonClicked(int index)

    source: mySourceNormal
    scale: 0.9
    opacity: 0.9

    Text {
        id: dialogText
        anchors.fill: parent
        text: myText
        color: "white"
        font.family: "微软雅黑"
        font.pixelSize: 24*myMainScale
        font.bold: true
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        wrapMode: Text.WordWrap
    }
    MouseArea{
        id:mouseArea
        anchors.fill: myChildItem
        hoverEnabled: false
        onPressed: {
            if(pressedButtons!=Qt.LeftButton){
                return
            }
            clickScaleAction.to=1
            clickOpacityAction.to=1
            clickAction.restart()
            myChildItem.source=mySourcePress
        }
        onReleased: {
            clickScaleAction.to=0.9
            clickOpacityAction.to=0.9
            clickAction.restart()
            myChildItem.source=mySourceNormal
            if(containsMouse==false){
                return
            }
            clickSound.play()
            buttonClicked(myIndex)
            myRect.startMyProcess(myPath)
        }
    }
    ParallelAnimation{
        id:clickAction
        SpringAnimation{
            id:clickScaleAction
            target: myChildItem
            property: "scale"
            spring: 10
            damping: 1
        }
        SpringAnimation{
            id:clickOpacityAction
            target: myChildItem
            property: "opacity"
            spring: 10
            damping: 1
        }
    }
    SoundEffect{
        id:hoverSound
        source: "qrc:/sound/RES/hover.wav"
    }
    SoundEffect{
        id:clickSound
        source: "qrc:/sound/RES/click.wav"
    }
}
