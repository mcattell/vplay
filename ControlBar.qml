import QtQuick 2.0
import QtMultimedia 5.6

Item {

    id: controlBar
    width: parent.width
    height: parent.height / 8

    property alias backgroundOpacity : background.opacity

    property bool windDir

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

    function onFastForwardPressed() {
        video.seek(video.position + 10000)
    }

    function onRewindPressed() {
        video.seek(video.position - 10000)
    }

    function onNextPressed() {
        //TODO
    }

    function onContinuousWind() {

        if (windDir) // fast forward
            onFastForwardPressed()
        else
            onRewindPressed()
    }

    function onPressedAndHeld(direction) {

        windDir = direction
        mainWindow.state = "seeking"
        fastTimer.start()
    }

    function onButtonReleased() {

        mainWindow.state = "playing_controls_shown"
        fastTimer.stop()
    }

    Timer {

        id: fastTimer
        interval: 500
        repeat: true
        Component.onCompleted: {
            triggered.connect(controlBar.onContinuousWind)
        }
    }


    Rectangle {

        id: background
        color: "#00B2FF"
        opacity: 0.4

        Row {

            ControlButton {
                id: stop
                height: controlBar.height
                width: height
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
                id: rewind
                height: controlBar.height
                width: height
                buttonSourceImage: "qrc:/images/images/rw.png"
                Component.onCompleted: {

                    direction = false
                    controlPressed.connect(controlBar.onRewindPressed)
                    pressedAndHeld.connect(controlBar.onPressedAndHeld)
                    buttonReleased.connect(controlBar.onButtonReleased)
                }
            }
            Item {
                height: controlBar.height
                width: controlBar.height /2
            }
            ControlButton {
                id: play
                height: controlBar.height
                width: height
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
                id: fastForward
                height: controlBar.height
                width: height
                buttonSourceImage:  "qrc:/images/images/ff.png"
                Component.onCompleted: {

                    direction = true
                    controlPressed.connect(controlBar.onFastForwardPressed)
                    pressedAndHeld.connect(controlBar.onPressedAndHeld)
                    buttonReleased.connect(controlBar.onButtonReleased)
                }
            }
            Item {
                height: controlBar.height
                width: controlBar.height /2
            }


            ControlButton {
                id: next
                height: controlBar.height
                width: height
                buttonSourceImage: "qrc:/images/images/next.png"
                Component.onCompleted: {
                    controlPressed.connect(controlBar.onNextPressed)
                }
            }
            Item {
                height: controlBar.height
                width: controlBar.height /2
            }
            TimeDisplay {
                id: time
                width: 8*next.width
                height: controlBar.height
            }
        }
    }
}
