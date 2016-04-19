import QtQuick 2.0

Item {

    id: controlBar
    width: parent.width
    height: parent.height / 8



    Rectangle {
        id: background
        anchors.fill: parent
        color: "#D4D46A"

        Row {

            ControlButton {
                id: play
                buttonSourceImage: "qrc:/images/images/play.png"
                Component.onCompleted: {
                    controlPressed.connect(video.play)
                }
            }
            Item {
                height: controlBar.height
                width: controlBar.height /2
            }
            ControlButton {
                id: stop
                buttonSourceImage: "qrc:/images/images/stop.png"
                Component.onCompleted: {
                    controlPressed.connect(video.stop)
                }
            }
            Item {
                height: controlBar.height
                width: controlBar.height /2
            }
            ControlButton {
                id: next
                buttonSourceImage: "qrc:/images/images/next.png"
                Component.onCompleted: {
                  //  controlPressed.connect(video.next)
                }
            }
        }
    }
}
