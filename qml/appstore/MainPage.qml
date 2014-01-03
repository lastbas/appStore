import QtQuick 1.1
import com.nokia.symbian 1.1
import com.nokia.extras 1.1


Page {
    id: windowP;
    tools: sharedToolBar


    function xmlErrorF() { retryButton.visible=true; errorText.visible=true;  model.source=""; xmlLoaded=false; xmlError=true}
    function retry() { retryButton.visible=false; errorText.visible=false;  model.source="http://storeage.eu.pn/data.xml"; xmlError=false }
    function updateViewContentHeight() { rosterView.contentHeight=(repeater.count*itemHeight)+headerheight; }
//------------------------------PAGE---------------------------//
    Flickable {
        id: rosterView
        anchors { fill: parent; }
        contentWidth: columnContent.width
        clip:true
        contentHeight: (searching) ?  (appCount*itemHeight)+headerheight : (cateFilter) ? (appCount*itemHeight)+headerheight : (repeater.count*itemHeight)+headerheight
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.VerticalFlick

        Rectangle {
            id:header
            color:"black"
            anchors.top:parent.top
            width:parent.width
            height:headerheight
            visible:xmlLoaded
                Rectangle {
                    id:header2;
                    radius: 10
                    visible:true
                    height: headerheight;
                    width: parent.width;
                    anchors.top:parent.top
                    color:(!invertedTheme) ? "grey" : "#F1F1F1"
                    Rectangle {
                        height:16
                        color:(!invertedTheme) ? "grey" :"#F1F1F1"
                        width:header.width
                        anchors { bottom:parent.bottom }
                        Rectangle {
                            id:divider
                            anchors {
                                bottom:parent.bottom
                            }
                            color: "grey"
                            visible:invertedTheme
                            height:2
                            width:header.width
                        }
                    }

                    Text {
                        id:headerText
                        anchors { horizontalCenter: parent.horizontalCenter; verticalCenter: parent.verticalCenter; }
                        text: (cateFilter=="") ? (!searching) ? "Store" : (searchString=="") ? "Search" : "Search - "+searchString : cateFilter
                        font.pointSize: 9;
                        color: (invertedTheme) ? "black" : "white"
                    }
                }
        }

        TextField {
            id: searchField
            width:parent.width
            height:fieldSpace
            Behavior on height { NumberAnimation { duration:300 } }
            anchors {bottom:columnContent.top; top:header.bottom }
            placeholderText: "Search Here"
            onTextChanged: {
                searchString=text
            }
            onHeightChanged: {
                searchString=""
                text=""
                if(height>0) {
                text=""
                openSoftwareInputPanel();
                }
            }
        }
//------------------------ALL-APP-LIST--------------------------------//
        Column {
                id: columnContent
                anchors { top: header.bottom; bottom:parent.bottom; topMargin: fieldSpace }
                Behavior on y { PropertyAnimation {} }
                Repeater {
                    id:repeater
                    delegate: recipeDelegate
                    model:model
                }
            }

    }
//-----------------------------DELEGATE----------------------------------------//

    Component {
        id: recipeDelegate

        ListItem {
            property string versionInstalled: ""
            property bool installed: null
            property bool updateAv: false
            function updateVerify() {
              if(versionInstalled=="NI") {
                  updateAv=false;
               } else if(versionInstalled==version) {
                  updateAv=false;
                  } else {
                  updateAv=true;
               }
            }
            id: recipe
            height:itemHeight
            visible: {
                if(searching==true) {
                    var sh = searchString.toLowerCase()
                    if(sh.toLowerCase().indexOf(title.toLowerCase()))
                    {
                        return false;

                    }
                    else                                                     //THIS THING IS TOO DIRTY (IMO)
                    {
                        return true;
                    }
                } else {
                    return (!cateFilter=="") ? (cat==cateFilter) ? true : false : true;
                }
            }
            onVisibleChanged: {
                    if(visible==true) {
                        appCount++
                    }
                    else
                    {
                        appCount--
                    }
                if(categoriesView) {
                    rosterView.contentY = 0
                    recipe.state = '';
                }
            }
            Component.onCompleted: {
                appCount=repeater.count
                versionInstalled = uidApp.uidTo(uid);
                if(versionInstalled=="NI") {
                    installed = false

                } else {
                    installed = true
                    check.text="INSTALLED"
                    check.color = "#737373"
                    updateVerify();
                    if(updateAv==true) {
                        check.text = "UPDATE"
                        check.color = "blue"
                    }
                }

            }
            Text {
                id:check
                font.pointSize: 6;
                anchors { right:parent.right; rightMargin: 20; verticalCenter: parent.verticalCenter }
            }
            platformInverted: invertedTheme
            onClicked: {
                sharedToolBar.setTools(toolBarLayout);
                windowP.pageStack.push(Qt.createComponent("DetailsView.qml"));
            }
            Row {
                id: topLayout
                x: 10; y: 15;  height: appIcon.height; width: parent.width;
                spacing: 10
                Image {
                    id: appIcon
                    width: 50; height: 50
                    source: picture
                    BusyIndicator{
                        anchors.centerIn: parent
                        platformInverted: invertedTheme
                        visible:appIcon.progress<1.0
                        running:appIcon.progress<1.0
                    }
                }
                Text {
                    id:appName
                    text: title
                    font.pointSize: 7.5;
                    anchors { verticalCenter: appIcon.verticalCenter; verticalCenterOffset: (recipe.state=='Details') ? 0 : -10 }
                    color: (invertedTheme) ? "black" : "white"
                    Text {
                        id:category
                        visible: (recipe.state=='Details') ? false : true
                        text: cat
                        font.pointSize: 6;
                        color:"#737373"
                        anchors { verticalCenter: parent.verticalCenter; verticalCenterOffset: 23 }
                    }
                }

            }


        }
    }
//---------------------END-DELEGATE--------------------------//

    Connections {
        id:connector
        target: dlhelper
        onTam: {
            infobanner.iconSource= "ui/done.png"
            infobanner.text = "Application Installed"
            infobanner.open();
            installing=false
        }
        onCancelled:
        {
            finished=false;
            downloading=false;
        }
    }
    Connections {
        target:dll
        onError: {
            infobanner.iconSource= ""
            infobanner.text = "Download Error"
            infobanner.open();
            downloading=false;
            finished=false;
            console.log("Download error")
        }
    }

    Item {
        id:loader
        anchors { horizontalCenter: parent.horizontalCenter
                  verticalCenter: parent.verticalCenter
        }
        ProgressBar {
            id: progressbar
            anchors.verticalCenterOffset: 80
            anchors { horizontalCenter: parent.horizontalCenter
                      verticalCenter: parent.verticalCenter
            }
            visible: (model.progress<1) ? true : false
            indeterminate: true

        }
        Text {
            id:errorText
            visible:xmlError
            text:"<p>There was a problem opening the Store.</p>
                   <p> Check your connection and try again.</p>"
            anchors { horizontalCenter: parent.horizontalCenter
                      verticalCenter: parent.verticalCenter
                      verticalCenterOffset: 80
            }
            color: (invertedTheme) ? "black" : "white"
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 6
        }
        Button {
            id:retryButton
            platformInverted: invertedTheme
            text:"Retry"
            visible: xmlError
            anchors { horizontalCenter: parent.horizontalCenter; top:logo.bottom; topMargin:100 }
            onClicked: {
                retry()
            }
        }
        BorderImage {
            id: logo
            visible:(xmlError) ? true : (xmlLoaded) ? false : true
            anchors { verticalCenterOffset: -50; verticalCenter: parent.verticalCenter; horizontalCenter: parent.horizontalCenter }
            source: "ui/appstore.png"
        }
    }

//---------------------------MODEL-------------------------//
    XmlListModel {
         id: model
         source:"http://storeage.eu.pn/data.xml"
         //source:"E:/data.xml"
         query: "/catalogue/book"
         XmlRole { name: "title"; query: "title/string()" }
         XmlRole { name: "picture"; query: "picture/string()"}
         XmlRole { name: "sis"; query: "sis/string()"}
         XmlRole { name: "screenshot"; query: "screenshot/string()"}
         XmlRole { name: "link"; query: "link/string()"}
         XmlRole { name: "version"; query: "version/string()"}
         XmlRole { name: "dtltext"; query: "dtltext/string()"}
         XmlRole { name: "dev"; query: "dev/string()" }
         XmlRole { name: "cat"; query: "cat/string()" }
         XmlRole { name: "uid"; query: "uid/string()" }
         onStatusChanged: {
             switch (status) {
             case XmlListModel.Error:  xmlErrorF();
             case XmlListModel.Ready:  xmlLoaded=(xmlError) ? false: true
             }
        }
    }
    InfoBanner {
        id: infobanner
        timeout: 3800
        onClicked: {
            infobanner.close();
        }
        //text: "Application installed."
        //iconSource: "ui/done.png"
    }
    states: [
        State {
                name:"Categories" //categories view
                AnchorChanges { target:columnContent; anchors.right:parent.left }
                AnchorChanges { target:catColumn; anchors.left:parent.left }
                PropertyChanges { target: headerText;   text:"Categories" }
            },
        State {
                name:"Store" // default view
                PropertyChanges { target: headerText;   text:"Store" }
            },
        State {
                name:"CView" //showing the categories
                PropertyChanges { target: catColumn;  visible:false }
            },
        State {
                name: "Search"
                PropertyChanges {
                    target: searchField
                    height:40
                }

        }
    ]
    transitions: Transition {
        ParallelAnimation {
            AnchorAnimation { duration: 200; }
            PropertyAnimation { duration: 200; properties: "height" }
        }
    }

}
