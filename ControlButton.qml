import QtQuick 2.0

Item {

    property alias buttonSourceImage : icon.source
    height: controlBar.height
    width: height

    signal controlPressed()

    Image {
        id: icon
        anchors.fill: parent

        fillMode: Image.PreserveAspectFit
        width: parent.width
        height: parent.height
        sourceSize.height: 200
        sourceSize.width: 200

        MouseArea {
            id: mousePad
            anchors.fill: parent

            onClicked: {

                controlPressed()
            }
        }
    }
}
