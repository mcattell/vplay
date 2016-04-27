import QtQuick 2.0

Item {

    id: container
    property alias buttonSourceImage : icon.source

    signal controlPressed()
    signal pressedAndHeld(bool direction)
    signal buttonReleased()

    property bool direction //false is rewind, true is fast forward

    MouseArea {
        id: mousePad
        anchors.fill: parent

        onClicked: {
            controlPressed()
        }
        onPressAndHold: {
            pressedAndHeld(direction)
        }
        onReleased: {
            buttonReleased()
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
