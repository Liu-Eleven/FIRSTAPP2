import QtQuick 2.4
import QtMultimedia 5.0

Flipable{
    id:itemRect
    smooth: true
    width: 520*myMainScale
    height: 360*myMainScale
    property int myIndex: -1
    property string myTitle: ""
    property var myChildren: new Array
    function closeRect(){
        rotation.angle=0
    }

    transform:Rotation{
        id:rotation
        origin.x: frontItem.width/2
        origin.y: frontItem.height/2
        axis.x: 0
        axis.y: 1
        axis.z: 0
        angle: 0
        Behavior on angle {
            PropertyAnimation{
                duration: 800
                easing.type: Easing.OutBack
            }
        }
        onAngleChanged: {
            if(angle>90){
                frontItem.visible=false
            }else{
                frontItem.visible=true
            }
        }
    }
    SpringAnimation{
        id:showAction
        target: itemRect
        property: "scale"
        spring: 2
        damping: 0.15
    }
    front:MyItem{
        id:frontItem
        myText: myTitle
        onButtonClicked: {
            myRect.closeAllItemRect()
            rotation.angle=180
        }
    }

    back:Image {
        id: backItem
        source: "qrc:/image/RES/itemrect.png"
        smooth: true
        anchors.fill: parent
    }
    function setShowAnimation(){
        showAction.from=0
        showAction.to=1
        showAction.restart()
    }
    function addItem(itemDataList){

        console.log(itemDataList)
        myTitle=itemDataList.title
        var items=itemDataList.items
        for(var i=0;i<items.length;i++){
            var item
            item=Qt.createComponent("MyChildItem.qml").createObject(backItem)
            myChildren[i]=item
            item.myIndex=i
            item.myPath=items[i].path
            item.myText=items[i].title
        }
        fixMyPos()
    }
    function fixMyPos(){
        switch(myChildren.length){
        case 0:
            break;
        case 1:
            myChildren[0].y=itemRect.height/2-myChildren[0].height/2
            break;
        case 2:
            myChildren[0].y=itemRect.height/3-myChildren[0].height/3
            myChildren[1].y=itemRect.height/3*2-myChildren[1].height/3*2
            break;
        case 3:
            myChildren[0].y=itemRect.height/4-myChildren[0].height/4
            myChildren[1].y=itemRect.height/4*2-myChildren[1].height/4*2
            myChildren[2].y=itemRect.height/4*3-myChildren[2].height/4*3
            break;
        case 4:
            myChildren[0].y=itemRect.height/5-myChildren[0].height/5
            myChildren[1].y=itemRect.height/5*2-myChildren[1].height/5*2
            myChildren[2].y=itemRect.height/5*3-myChildren[2].height/5*3
            myChildren[3].y=itemRect.height/5*4-myChildren[3].height/5*4
            break;
        default:
            break;
        }
    }
}
