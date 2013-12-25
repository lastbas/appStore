// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.symbian 1.1


Page {
    id:page
    tools:
        ToolBarLayout {
        ToolButton {
            flat: true
            iconSource: "toolbar-back"
            platformInverted: window.platformInverted
            onClicked: {
                if(window.pageStack.depth <= 1) {
                    Qt.quit();
                } else {
                    categoriesView=false
                    window.pageStack.pop();

                }
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
            source:"http://storeage.eu.pn/categories.xml"
            query: "/catalogue/book"
            XmlRole { name: "name"; query: "name/string()" }
            XmlRole { name: "img"; query: "img/string()"}
       }

    }

    Component {
        id:categoriesDel
        ListItem {
           height: 60

           platformInverted: window.invertedTheme
           onClicked: {
               page.pageStack.pop()
               window.cateFilter = name
           }
           Image {
           source: img
           x:10
           anchors { verticalCenter: parent.verticalCenter;  }
           }
               Text {
                   id:catext
                   text: name
                   color: (window.invertedTheme) ? "black" : "white"
                   x:80
                   font.pointSize: 7.5;
                   anchors { verticalCenter: parent.verticalCenter;  }
               }
        }
    }
}
}
