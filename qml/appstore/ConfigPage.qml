import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage

Page {
    tools:
        ToolBarLayout {
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: if(!window.pageStack.depth <= 1) {
                           window.pageStack.pop()
                           Storage.setSetting("invertedTheme",invertedTheme)

                       }
        }
    }
    Column {
        id:column
        anchors.fill: parent
        ListHeading {
            id:header
            ListItemText {
                text: "Options"
            }
        }
        ListItem {
            id: themeitem
            platformInverted: invertedTheme
            ListItemText {
                id:theme
                text: "Theme:"
                x:15
                platformInverted: invertedTheme
                anchors {
                    verticalCenter: parent.verticalCenter
                    }
                }
                onClicked: {
                if(invertedTheme) {
                    invertedTheme=false
                } else {
                    invertedTheme=true
                }
            }
            Text {
                anchors { horizontalCenter: parent.horizontalCenter; horizontalCenterOffset: 90; verticalCenter: parent.verticalCenter;}
                text: (invertedTheme) ? "Radiance" : "Evolve"
                color: (invertedTheme) ? "grey" : "#737373"
            }
        }
        ListItem {
            id:installMethod
            platformInverted: invertedTheme
            ListItemText {
                text:"Install Method:"
                id:txt
                x:15
                platformInverted: window.platformInverted
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
            onClicked: {
                if(window.insMethod==0) {
                    window.insMethod = 1
                    Storage.setSetting("insMeth","1")
                } else {
                    window.insMethod = 0
                    Storage.setSetting("insMeth","0")
                }
            }

            Text {
                    id: item
                    anchors { horizontalCenter: parent.horizontalCenter; horizontalCenterOffset: 90; verticalCenter: parent.verticalCenter;}
                    text:(window.insMethod==0) ? "Silent" : "Normal"
                    color: (invertedTheme) ? "grey" : "#737373"
                }

        }
        ListItem {
            id:drive
            enabled: (window.insMethod==0) ? true : false

            platformInverted: invertedTheme
            onClicked: {
                selectionDialog.open();
            }
            ListItemText {
                text:"Drive:"
                id:driveText
                x:15

                platformInverted: window.platformInverted
                anchors {
                    verticalCenter: parent.verticalCenter
                }
            }
            Text {
                id:driveSel
                color: (invertedTheme) ? "grey" : "#737373"
                anchors { horizontalCenter: parent.horizontalCenter; horizontalCenterOffset: 90; verticalCenter: parent.verticalCenter;}


                text: selectionDialog.selectedIndex >= 0
                                              ? selectionDialog.model.get(selectionDialog.selectedIndex).name
                                              : "Please select"
                }


                SelectionDialog {
                    id: selectionDialog
                    titleText: "Select:"
                    platformInverted: window.platformInverted
                    model: ListModel {
                        ListElement { name: "(C)Phone Memory" }
                        ListElement { name: "(E)Mass Memory" }
                        ListElement { name: "(F)Memory Card" }

                    }
                    onSelectedIndexChanged: {
                        if(selectedIndex==0) {
                            Storage.setSetting("insDrive","C")
                            dlhelper.path("C")
                            window.driveSaved="C"
                        }
                        if(selectedIndex==1) {
                            Storage.setSetting("insDrive","E")
                            dlhelper.path("E")
                            window.driveSaved="E"
                        }
                        if(selectedIndex==2) {
                            Storage.setSetting("insDrive","F")
                            dlhelper.path("F")
                            window.driveSaved="F"
                        }
                    }
                }
            }
        }
    Component.onCompleted: {
        selectionDialog.selectedIndex = (window.driveSaved=="C") ? 0 : (window.driveSaved=="E") ? 1 : 2
    }
}


