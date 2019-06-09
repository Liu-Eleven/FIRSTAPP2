import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import MyObject 1.0

MyWindow {
    id:myWindow
    property real myMainScale: Screen.width/1920
    MyCommon{
        id:myCommon
        onMyProcessPathError: {
            myRect.endMyProcess()
            console.log(path+"   is nothing!(path)")
        }
        onCloseMyProcess: {
            myRect.endMyProcess()
        }
    }
    MyRect{
        id:myRect
        back: MyContent{
            id:myContent
            MyTitle{
                id:myTitle
                x:myRect.width/2-myTitle.width/2
                y:20*myMainScale
            }
            MyItemRect{
                id:myRectTitle1
                x:myRect.width/4*1-width/2
                y:myRect.height/3*1-height/2
                myIndex: 0
            }
            MyItemRect{
                id:myRectTitle2
                x:myRect.width/4*2-width/2
                y:myRect.height/3*1-height/2
                myIndex: 1
            }
            MyItemRect{
                id:myRectTitle3
                x:myRect.width/4*3-width/2
                y:myRect.height/3*1-height/2
                myIndex: 2
            }
            MyItemRect{
                id:myRectTitle4
                x:myRect.width/4*1-width/2
                y:myRect.height/3*2-height/2
                myIndex: 3
            }
            MyItemRect{
                id:myRectTitle5
                x:myRect.width/4*2-width/2
                y:myRect.height/3*2-height/2
                myIndex: 4
            }
            MyItemRect{
                id:myRectTitle6
                x:myRect.width/4*3-width/2
                y:myRect.height/3*2-height/2
                myIndex: 5
            }

            MyButton{
                id:exitButton
                x:myRect.width-exitButton.width-50*myMainScale
                y:myRect.height-exitButton.height-50*myMainScale
                myText: "退出"
                onButtonClicked: {
                    myRect.setEnd()
                }
            }
        }
    }
    Component.onCompleted: {
        myTitle.myText=myCommon.titleName;
        var itemList=myCommon.itemLists();


        for(var i=0;i<6;i++){
            switch(i){
            case 0:
                myRectTitle1.addItem(itemList[i])
                break
            case 1:
                myRectTitle2.addItem(itemList[i])
                break
            case 2:
                myRectTitle3.addItem(itemList[i])
                break
            case 3:
                myRectTitle4.addItem(itemList[i])
                break
            case 4:
                myRectTitle5.addItem(itemList[i])
                break
            case 5:
                myRectTitle6.addItem(itemList[i])
                break
            default:
                break
            }
        }
        myRect.setStart()
    }
}
