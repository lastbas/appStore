import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1

PageStackWindow {
    id: window
    showStatusBar: true
    showToolBar: false
    platformInverted: true
    property bool downloading: false
    property bool finished: false
    function hideLogo() { progressbar.visible=false; logo.visible=false; header.visible=true }
    function connectError() { retryButton.visible=true; errorText.visible=true;  progressbar.visible=false; model.source="" }
    function retry() { retryButton.visible=false; errorText.visible=false;  progressbar.visible=true; model.source="http://storeage.eu.pn/data.xml" }

//------------------------------PAGE---------------------------//
    Flickable {
        id: rosterView
        anchors { fill: parent; topMargin: 25; bottomMargin: 50 }
        contentHeight: columnContent.height
        contentWidth: columnContent.width
        clip:true
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.VerticalFlick
        Rectangle {
            id:header
            color:"black"
            anchors.top:parent.top
            width:parent.width
            height:70
                Rectangle {
                    id:header2;
                    radius: 15
                    visible:true
                    height: 70;
                    width: parent.width;
                    anchors.top:parent.top
                    color:"gray"
                    Rectangle {
                        height:14
                        color:"gray"
                        width:header.width
                        anchors.top:parent.top
                        anchors.topMargin: 56
                    }
                    Text {
                        id:headerText
                        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; }
                        text: "Store"; font.pointSize: 9;
                    }
                }
        }

//------------------------ALL-APP-LIST--------------------------------//
        Column {
                id: columnContent
                anchors.top: header.bottom
                spacing: 0
                visible:true
                Repeater {
                    model: model
                    delegate: recipeDelegate
                }
            }
    }
//-----------------------------DELEGATE----------------------------------------//
    Component {
        id: recipeDelegate

        ListItem {
            id: recipe
            platformInverted: true
            onClicked: {
                recipe.state = 'Details';
            }
            Item {
                id: background
                x: 2; y: 2; width: parent.width - x*2; height: parent.height - y*2
            }
            Button {
                y: 10
                id:backBnt
                enabled:(downloading) ? false : true
                anchors { right: parent.right; rightMargin: 10 }
                visible:false
                text: "Back"
                platformInverted: true
                onClicked: {
                    recipe.state = '';
                    if(finished) {
                    finished=false;
                    dlhelper.delFile(sis);
                        console.log(sis)
                    }
                }
            }
            ToolButton {
                id:dButton
                width: 135
                height: 51
                //enabled: (downloading) ? false : true
                visible:false
                text:(!finished) ? (!downloading) ? "Download" : "Cancel" : "Install"
                platformInverted: true
                onClicked:{
                    if(text=="Cancel") {
                        //dlhelper.cancelDownload();
                    }

                    if(!downloading) {
                        if(!finished) {
                        downloading=true
                        dlhelper.setTarget(link);
                        dlhelper.download();
                        } else {
                            dlhelper.installDownload(sis)
                            finished=false
                        }
                    }
                }

                anchors {
                    top:backBnt.bottom; topMargin: 5
                    right: parent.right; rightMargin: 10
                }

                BusyIndicator {
                    id:busyind

                    anchors {
                        right: parent.left
                        verticalCenter: parent.verticalCenter
                    }
                    running: (downloading) ? true : false
                    visible: (downloading) ? true : false
                }

            }

            Row {
                id: topLayout
                x: 10; y: 10; height: appIcon.height; width: parent.width
                spacing: 10
                Image {
                    id: appIcon
                    width: 50; height: 50
                    source: picture
                }
                Text {
                    id:appName
                    text: title
                    font.pointSize: 7.5;
                    anchors.verticalCenter: appIcon.verticalCenter
                }
            }
            Column {
                spacing: 0
                id: details
                width: parent.width - 20
                anchors { top: topLayout.bottom;  left:parent.left; leftMargin: 15}
                opacity: 0
                Text {
                 id: appDev
                 text:"By "+dev
                 color:"#737373"
                 font.pointSize: 6; font.bold: true
                }
                Text {
                    id:ver
                    text: "Version: " + version
                    font.pointSize: 6; font.bold: false
                     color:"#737373"
                }

            }
            Flickable {
                id:detailFlick
                width:topLayout.width
                height:infoText.height
                contentHeight: infoText.height
                clip: true
                opacity:0
                interactive: false
                anchors { top: details.bottom; topMargin: 8;  left:parent.left; leftMargin: 15; bottom:parent.bottom; right:parent.right; rightMargin: 15}
                Text {
                    id:infoText
                    text:dtltext
                    anchors.fill:parent
                    wrapMode: Text.Wrap
                }
            }

            states:
                State {
                name: "Details"
                PropertyChanges { target: recipe; enabled: false }
                PropertyChanges { target: recipe; height: window.height }
                PropertyChanges { target: rosterView; explicit: true; contentY: recipe.y+header.height }
                PropertyChanges { target: details; opacity: 1; x: 0 }
                PropertyChanges { target: rosterView; interactive: false }
                PropertyChanges { target: dButton; visible:true }
                PropertyChanges { target: backBnt; visible:true }
                PropertyChanges { target: detailFlick; interactive:true;opacity:1 }
            }
            transitions: Transition {
                ParallelAnimation {
                    NumberAnimation { duration: 200; properties: "height,contentY,opacity" }
                }
            }
        }
    }

    Connections {
        id:connector
        target: dlhelper
        onDone: {
            finished = true
            downloading=false
        }
        onTam: {
            infobanner1.open();
        }
    }

    Item {
        id:loader
        anchors { horizontalCenter: parent.horizontalCenter
                  verticalCenter: parent.verticalCenter
        }
        ProgressBar {
            id: progressbar
            anchors { horizontalCenter: parent.horizontalCenter
                      verticalCenter: parent.verticalCenter
            }
            visible: (model.progress<1) ? true : false
            indeterminate: true

        }
        Text {
            id:errorText
            visible:false
            text:"<p>There was a problem opening the Store.</p>
                   <p> Check your connection and try again.</p>"
            anchors { horizontalCenter: parent.horizontalCenter
                      verticalCenter: parent.verticalCenter
            }
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 6
        }
        Button {
            id:retryButton
            platformInverted: true
            text:"Retry"
            visible: false
            anchors { horizontalCenter: parent.horizontalCenter; top:errorText.bottom; topMargin:20 }
            onClicked: {
                retry()
            }
        }
        BorderImage {
            id: logo
            anchors { verticalCenterOffset: -150; verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
            source: "ui/appstore.png"
        }
    }
    XmlListModel {
         id: model
         source:"http://storeage.eu.pn/data.xml"
         query: "/catalogue/book"
         XmlRole { name: "title"; query: "title/string()" }
         XmlRole { name: "link"; query: "link/string()" }
         XmlRole { name: "picture"; query: "picture/string()"}
         XmlRole { name: "sis"; query: "sis/string()"}
         XmlRole { name: "version"; query: "version/string()"}
         XmlRole { name: "dtltext"; query: "dtltext/string()"}
         XmlRole { name: "dev"; query: "dev/string()" }
         onStatusChanged: {
             var ready = (status == XmlListModel.Error)
             switch (status) {
             case XmlListModel.Error:  connectError();
             case XmlListModel.Ready:  hideLogo();
             }
        }
    }

    InfoBanner {
        id: infobanner1
        width: 360
        height: 74
        timeout: 2500
        text: "Application installed."
        iconSource: "ui/done.png"
    }
}
