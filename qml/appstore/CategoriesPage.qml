// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1


Page {
    id:page
    tools:tolBar
    ToolBar {
        id:tolBar
        tools: tolBarLayout
        platformInverted: false
    }

    ToolBarLayout {
        id:tolBarLayout
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            //platformInverted: window.platformInverted
            onClicked: {
                    categoriesView=false
                    window.pageStack.pop();
            }
        }
    }
    BusyIndicator {
        anchors { verticalCenter: parent.verticalCenter; horizontalCenter:parent.horizontalCenter; }
        height:50
        width:50
        running: (model.progress<1.0) ? true : false
        visible: (model.progress<1.0) ? true : false
        platformInverted: window.invertedTheme
    }
    Component {
        id:categoriesDel
        ListItem {
           height: 60
           platformInverted: window.invertedTheme
           subItemIndicator: true
           onClicked: {
               page.pageStack.pop();
               page.pageStack.pop();
               window.cateFilter = name
               sharedToolBar.setTools(tlBar)
           }
           Text {
               id:catext
               text: name
               color: (window.invertedTheme) ? "black" : "white"
               x:20
               font.pointSize: 7.5;
               anchors { verticalCenter: parent.verticalCenter;  }
           }
        }
    }
Column {
    ListHeading {
        id:header
        ListItemText {
            text: "Categories"
        }
    }
    Repeater {
        id:rep
        delegate: categoriesDel
        model: XmlListModel {
            id: model
            source:"http://repo.symbian.odin.magissia.com/data/categories.xml"
            query: "/catalogue/book"
            XmlRole { name: "name"; query: "name/string()" }
       }

    }

    ListHeading {
        id:onHere
        visible: (model.progress<1.0) ? false : true
        platformInverted: window.invertedTheme
        ListItemText {
            anchors { horizontalCenter: parent.horizontalCenter;  }
            color: (window.invertedTheme) ? "#737373" : "#737373"
            text: "On This Device"
        }
    }
    ListItem {
        id:inst
        visible: (model.progress<1.0) ? false : true
        subItemIndicator: true
        platformInverted: window.invertedTheme
        onClicked: {
            otd="Installed"
            page.pageStack.pop();
            sharedToolBar.setTools(tlBar)
            page.pageStack.pop();
        }

        ListItemText {
            anchors { verticalCenter: parent.verticalCenter;  }
            color: (window.invertedTheme) ? "black" : "white"
            x:20
            text: "Installed"
        }
    }
    ListItem {
        id:up
        visible: (model.progress<1.0) ? false : true
        subItemIndicator: true
        platformInverted: window.invertedTheme
        onClicked: {
            otd="Update"
            page.pageStack.pop();
            sharedToolBar.setTools(tlBar)
            page.pageStack.pop();
        }

        ListItemText {
            color: (window.invertedTheme) ? "black" : "white"
            anchors { verticalCenter: parent.verticalCenter;  }
            x:20
            text: "Updated"
        }
        ListItemText {
            anchors { verticalCenter: parent.verticalCenter; right:parent.right; rightMargin: 50 }
            color:"#487393"
            visible:(updateCount==0) ? false : true
            text:"("+updateCount+")"
        }
    }
}
}
