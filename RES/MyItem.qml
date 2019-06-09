import QtQuick 2.4
import QtMultimedia 5.0

Image {
    id: myItem
    width: 480*myMainScale
    height: 300*myMainScale
    smooth: true
    source: "qrc:/image/RES/myitemrect.png"
    property string myText: ""
    property string mySourceNormal: "qrc:/image/RES/itemball.png"
    property string mySourcePress: "qrc:/image/RES/itemballpress.png"
    property string mySourceHover: "qrc:/image/RES/itemballhover.png"
    signal buttonClicked(int index)
    scale: 0.85
    opacity: 0.9

    Image {
        id: myItemBall
        smooth: true
        width:350*myMainScale
        height:350*myMainScale
        x:myItem.width/2-width/2
        y:myItem.height/2-height/2
        transform:Rotation{
            id:rotation
            origin.x: myItemBall.width/2
            origin.y: myItemBall.height/2
            axis.x: 0
            axis.y: 0
            axis.z: 1
            angle: 0
        }
        source: mySourceNormal
        MouseArea{
            id:mouseArea
            anchors.fill: myItemBall
            hoverEnabled: false
            onPressed: {
                if(pressedButtons!=Qt.LeftButton){
                    return
                }
                clickScaleAction.to=1
                clickOpacityAction.to=1
                clickRotationAction.to=-180
                clickAction.restart()
                myItemBall.source=mySourcePress
            }
            onReleased: {
                clickScaleAction.to=0.85
                clickOpacityAction.to=0.9
                clickRotationAction.to=0
                clickAction.restart()
                myItemBall.source=mySourceNormal
                if(containsMouse==false){
                    return
                }
                clickSound.play()
                buttonClicked(myIndex)
            }
        }
        ParallelAnimation{
            id:clickAction
            NumberAnimation{
                id:clickScaleAction
                target: myItem
                property: "scale"
                duration: 1000
                easing.type: Easing.OutBack
            }
            NumberAnimation{
                id:clickOpacityAction
                target: myItem
                property: "opacity"
                duration: 1000
                easing.type: Easing.OutBack
            }
            NumberAnimation{
                id:clickRotationAction
                target: rotation
                property: "angle"
                duration: 1000
                easing.type: Easing.OutBack
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
}
