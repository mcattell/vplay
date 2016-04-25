import QtQuick 2.0
import QtMultimedia 5.6

Item {

    id: controlBar
    width: parent.width
    height: parent.height / 10
    property alias backgroundOpacity : background.opacity
    function onPlayPressed() {


        if (video.playbackState === MediaPlayer.PlayingState) {

            video.pause()
        }
        else if (video.playbackState === MediaPlayer.PausedState) {

            video.play()
        }

        else if (video.playbackState === MediaPlayer.StoppedState  ) {

            video.play()
        }
    }

    function onStopPressed() {

        video.stop()
    }

    function onNextPressed() {
        //TODO
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#00B2FF"
        opacity: 0.2
        Row {

            ControlButton {
                id: play
                buttonSourceImage: (video.playbackState === MediaPlayer.PlayingState) ? "qrc:/images/images/pause.png" : "qrc:/images/images/play.png"
                Component.onCompleted: {
                    controlPressed.connect(controlBar.onPlayPressed)
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
                    controlPressed.connect(controlBar.onStopPressed)
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
                    controlPressed.connect(controlBar.onNextPressed)
                }
            }
        }
    }
}
