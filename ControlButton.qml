import QtQuick 2.0

Item {

    id: container
    property alias buttonSourceImage : icon.source
    signal controlPressed()

    MouseArea {
        id: mousePad
        anchors.fill: parent

        onClicked: {

            controlPressed()
        }
    }
    Image {
        id: icon
        anchors.fill: parent

        fillMode: Image.PreserveAspectFit
        scale:   0.7
        sourceSize.height: 200
        sourceSize.width: 200


    }
}
