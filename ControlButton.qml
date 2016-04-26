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
        scale:   0.9
        sourceSize.height: 400
        sourceSize.width: 400


    }
}
