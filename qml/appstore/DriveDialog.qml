// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1
import "storage.js" as Storage
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
    //onStatusChanged: if (status === DialogStatus.Closing) destroy()
    Component.onCompleted: {
        selectionDialog.open()
        selectionDialog.selectedIndex = (window.driveSaved=="C") ? 0 : (window.driveSaved=="E") ? 1 : 2
    }
}
