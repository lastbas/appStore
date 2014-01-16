import QtQuick 1.1
import com.nokia.symbian 1.1
import QtWebKit 1.0

Page {
    id:detailPage
    tools: sharedToolBar
    property string installedDrive: ""
    property bool webViewRendering: false
    function updateVerify() {
      if(versionInstalled=="NI") {
          updateAv=false;
       } else if(versionInstalled==version) {
          updateAv=false;
          } else {
          updateAv=true;
       }
    }
    Timer {
        running: (downloading) ? true : false
        repeat: true
        interval: 1000
        onTriggered: {
            busyind.value = dlhelper.getProgress();
        }
        onRunningChanged: {
            busyind.value = 0
        }
    }
    Flickable {
        id:detailFlick
        onMovementStarted: {
            webViewRendering = false
        }
        onMovementEnded: {
            webViewRendering = true
        }
        contentHeight: details.height + detail2.height + commentsHead.height + showCom.height + loader.height + 100
        flickableDirection: Flickable.VerticalFlick
        anchors { right:parent.right; left:parent.left; top:parent.top; bottom:parent.bottom; topMargin: 5;  rightMargin: 10; leftMargin: 10;  }
        Item {
            id:details
            height:iconName.height + divider.height + buttonsColony.height + 70
            width: parent.width
            Row {
                id:iconName
                anchors { top: parent.top; topMargin: 20; }
                spacing: 19
                Item {
                    id:pic
                    height:90
                    width:50
                    Image {
                        source:picture
                        anchors.verticalCenter: parent.verticalCenter
                        width:50
                        height:50
                    }
                }
            Column {
                id:co
                Text {
                    id:titleText
                    text: title
                    color: (invertedTheme) ? "black" : "white"
                    font.pointSize: 7.5;
                }
                Text {
                    text:"By " + dev
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
                Text {
                    text:cat
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
                Text {
                    text:"Version: " + version
                    color:"#737373"
                    font.pointSize: 6; font.bold: true
                }
                Text {
                    text:(installedDrive=="NI") ? "" : "Installed on " + installedDrive + ":"
                    color:"#737373"
                    //height: (text) ? 20 : 0
                    font.pointSize: 6.1; font.bold: true
                }
                Text {
                    id: downCount
                    //text: "Downloads: " + dlhelper.downCountl()  // for now
                    color:"#737373"
                   //height: (text) ? 20 : 0
                    font.pointSize: 6; font.bold: true
                }
              }
            }
            Rectangle {
                id:divider
                anchors {
                    top:iconName.bottom;
                    topMargin: 20;
                    right:parent.right
                    left:parent.left
                }
                color:"#737373"
                height:1
                //width:340;
            }
            Column {
                anchors { top: divider.bottom; topMargin: 20; horizontalCenter: parent.horizontalCenter }
                spacing: 3
                id:buttonsColony
                height: downloadButton.height + runButton.height + unButton.height + busyind.height + instext.height + 15
                width:parent.width - 100
                Text {
                    id:instext
                    text:(installing) ? "Installing..." : (uninstalling) ? "Uninstalling..." :  ""
                    color:"#737373"
                    font.pointSize: 7; font.bold: true
                    height:(text) ? downloadButton.height : 0
                }
                ProgressBar {
                    id:busyind
                    minimumValue: 0
                    maximumValue: 100
                    height:(visible) ? 25 : 0
                    width:parent.width
                    platformInverted: invertedTheme
                    value: 0;
                    visible: (downloading) ? true : false
                }
                Button {
                    id:downloadButton
                    visible:(installing) ? false : (versionInstalled=="NI") ? true : (updateAv) ? true: false;
                    text: (!downloading) ? (updateAv) ? "Update" : "Install" : "Cancel"
                    height: (visible) ? 40 : 0
                    //width: 200
                    width:parent.width
                    platformInverted: invertedTheme
                    onClicked:{

                        if(downloading) {
                            dlhelper.cancelDownload();
                            busyind.value=0
                        }
                        if(!downloading) {
                            if(!finished) {
                            downloading=true
                                if(!link){
                                    dlhelper.setTarget(sis);
                                    dlhelper.download();
                                }else{
                                    dlhelper.setLink(link);
                                    dlhelper.download();
                                }
                            } else {
                                if(insMethod==1){
                                    core.killApp(uid)
                                    core.sisInstallGUI(sis);
                                }
                                else {
                                    core.killApp(uid)
                                    dlhelper.installDownload(sis);
                                    installing=true
                                }
                                finished=false
                            }
                        }
                    }
                }
                Button {
                    id:runButton
                    //width:200
                    width:parent.width
                    height: (visible) ? 40 : 0
                    checked: true
                    visible:(uninstalling || installing || downloading) ? false : (versionInstalled==="NI") ? false : true
                    platformInverted: invertedTheme
                    text: "Run"
                    onClicked: {
                        core.doRunApp(uid);
                    }
                }
                Button {
                    id:unButton
                    height: (visible) ? 40 : 0
                    //width:200
                    width:parent.width
                    visible:(runButton.visible) ? true : false
                    platformInverted: invertedTheme
                    text: "Uninstall"
                    onClicked: {
                        uninstalling=true
                        dlhelper.doUninstall(uid);
                    }
                }
            }
        }
        Rectangle {
            id:divider2
            anchors {
                top:details.bottom
                topMargin: 10
                right:parent.right
                left:parent.left
            }
            color:"#737373"
            height:1
            //width:340;
        }
        Item {
            id:detail2
            anchors {top: details.bottom; topMargin: 20; right:parent.right; left:parent.left }
            height:dtlColumn.height
            Column {
                id:dtlColumn
                width:parent.width
                height: downCount.height + detailText.height + sShot.height
                spacing:15

                Text {
                    id: detailText
                    text: dtltext
                    color: (invertedTheme) ? "black" : "white"
                    font.pointSize: 6; font.bold: true
                    wrapMode: Text.Wrap
                    textFormat: Text.RichText;
                    width: parent.width
                }
                Image {
                    id:sShot
                    width: parent.width
                    source: (screenshot) ? screenshot : ""
                    fillMode: Image.PreserveAspectFit
                    height: (screenshot) ? 330 : 0
                }
            }
        }
        Item {
            id:comments
            anchors {top: detail2.bottom; right:parent.right; left: parent.left;   }
            width:parent.width
            ListHeading {
                id:commentsHead
                anchors { right:parent.right; left: parent.left;  leftMargin:-10; rightMargin:-10 }
                platformInverted: window.invertedTheme
                ListItemText {
                    anchors { horizontalCenter: parent.horizontalCenter;  }
                    color: (window.invertedTheme) ? "#737373" : "white"
                    text: "Comments Beta"
                }
            }
            Button {
                id:showCom
                anchors {top: commentsHead.bottom; right:parent.right;  left: parent.left; topMargin:20 }
                platformInverted: window.invertedTheme
                visible: (loader.source=="") ? true : false
                text:"Show Comments"
                onClicked: {
                    loader.source = "CommentsView.qml"
                }

            }
            Loader {
                id:loader
                source:""
                width:parent.width
                anchors {top: commentsHead.bottom; right:parent.right; left: parent.left;  }
            }
        }
    }
    Component.onCompleted:  {
        dlhelper.incrDownCount(0,uid);
        versionInstalled = uidApp.uidTo(uid);
        installedDrive = uidApp.checkInsDrive(uid);
        dlhelper.delFile(sis);
        updateVerify();
    }
    Connections {
        id:connector
        target: dlhelper
        onTam: {
            finished=true;
            if(updateAv) {
                updateCount--;
            }

            versionInstalled = uidApp.uidTo(uid);
            installedDrive = uidApp.checkInsDrive(uid);
            updateVerify();
            check.text="INSTALLED"
            check.color = "#737373"
        }
        onFinishUninstall: {
            versionInstalled = uidApp.uidTo(uid);
            installedDrive = uidApp.checkInsDrive(uid);
            updateVerify();
            check.text=""
            finished=false;
            downloading=false;
            uninstalling=false;
            infobanner.iconSource= "ui/done.png"
            infobanner.text = "Application Uninstalled"
        }
        onDone: {
            downloading = false
            dlhelper.incrDownCount(1,uid);
            if(!insMethod==1){
                core.killApp(uid)
                dlhelper.installDownload(sis);
                installing=true
                finished=false
            } else {
                finished = true
            }
        }
        onCountNumberReceived: {
            var n = dlhelper.downCountl();
            if(n==-1) {
                downCount.text="Downloaded 0 times"

            } else {
                downCount.text = "Downloaded " + n + " times"
            }

            console.log("received")
        }

    }
}
