import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.6

Window {
    id: topWindow
    visible: true
    color: "#000000"
    height: Screen.desktopAvailableHeight
    width: Screen.desktopAvailableWidth


    Component.onCompleted: {
        showTimer.start()
    }


    FontLoader {
        id: openSans
        source: "qrc:/fonts/fonts/OpenSans-Regular.ttf"
    }

    Item {
        width: parent.width * scaleFactor
        height: parent.height * scaleFactor
        id: mainWindow

        property real scaleFactor : 1.0
        property alias videoPosition : video.position
        property alias videoDuration : video.duration

        Item {

            id: frontScreen
            height: parent.height
            width: parent.width
            state: "idle"

            onStateChanged: {

                if (state === "playing_controls_shown") {

                    showTimer.start()
                }
            }

            states : [
                State {
                    name: "idle"
                    PropertyChanges{target: frontScreen; height: mainWindow.height - controls.height}
                    PropertyChanges{target: controls; y:  frontScreen.height}
                    PropertyChanges{target: progressBar; y: controls.y - progressBar.height}
                },
                State {
                    name: "playing"
                    PropertyChanges{target: frontScreen; height: mainWindow.height}
                    PropertyChanges{target: controls; y:  mainWindow.height + progressBar.height}
                    PropertyChanges{target: progressBar; y: 1.1*mainWindow.height }
                },
                State {
                    name: "playing_controls_shown"
                    PropertyChanges{target: frontScreen; height: mainWindow.height}
                    PropertyChanges{target: controls; y:  frontScreen.height - controls.height}
                    PropertyChanges{target: progressBar; y: controls.y - progressBar.height}
                    PropertyChanges{target: controls; backgroundOpacity: 0.4}
                    PropertyChanges{target: progressBar; backgroundOpacity: controls.backgroundOpacity}
                },
                State {
                    name: "seeking"
                    PropertyChanges{target: frontScreen; height: mainWindow.height}
                    PropertyChanges{target: controls; y:  frontScreen.height - controls.height}
                    PropertyChanges{target: progressBar; y: controls.y - progressBar.height}
                    PropertyChanges{target: controls; backgroundOpacity: 0.4}
                    PropertyChanges{target: progressBar; backgroundOpacity: controls.backgroundOpacity}

                }

            ]

            transitions: [
                Transition {
                    from: "idle"; to: "playing";
                    PropertyAnimation{ target: frontScreen; property: "height"; }
                    PropertyAnimation{ target: controls; property: "y"; }
                },
                Transition {
                    from: "playing"; to: "idle";
                    PropertyAnimation{ target: frontScreen; property: "height"; }
                    PropertyAnimation{ target: controls; property: "y"; }
                }
            ]

            Timer {
                id: showTimer
                interval: 10000
                running: false
                onTriggered: {

                    if (frontScreen.state === "playing_controls_shown")
                        frontScreen.state = "playing"
                    else if (frontScreen.state === "playing")
                        frontScreen.state = "playing_controls_shown"

                }
            }

            Video {
                id: video
                width : parent.width
                height : parent.height
                source: "file:///home/pi/video/liza.avi"
                fillMode: VideoOutput.PreserveAspectFit


                onPlaying: {
                    frontScreen.state = "playing_controls_shown"
                    startTimeObject.setMilliseconds(video.duration)

                }
                onStopped: {
                    frontScreen.state = "idle"

                }
                onPaused: {
                    frontScreen.state = "playing_controls_shown"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        if (video.playbackState === MediaPlayer.PlayingState || video.playbackState === MediaPlayer.PausedState)
                            frontScreen.state = "playing_controls_shown"
                    }
                }
                focus: true
            }

        }
        ProgressBar {
            id: progressBar
        }

        ControlBar {
            id: controls
        }
    }
}
