import QtQuick 2.0
import QtMultimedia 5.6

Item {

    id: mediaListContainer
    height: topWindow.height
    width: (1 - mainWindow.scaleFactor)*topWindow.width
    x: mainWindow.x + mainWindow.width
    y: topWindow.y


    ListView {
        id: mediaList
        width: parent.width
        height: parent.height
        delegate: itemDelegate
        model: 20
        clip: true
    }

    Component {
        id: itemDelegate

        Item {
            width: mediaList.width
            height: mediaList.height / 5
            Column {
                Rectangle {
                    id: line
                    width: mediaList.width
                    height: 1
                    color: "red"
                }

                Rectangle {
                    id: placeHolder
                    width: mediaList.width
                    height: (mediaListContainer.height / 5) - line.height
                    color: "blue"
                }
            }
        }
    }

}
