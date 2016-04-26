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

        property real scaleFactor
        property alias videoPosition : video.position
        property alias videoDuration : video.duration



        state: "idle"

        onWidthChanged:  {
            progressBar.updateWidth()
        }


        onStateChanged: {

            if (state === "playing_controls_shown") {

                showTimer.start()
            }
        }
        states : [
            State {
                name: "idle"

                PropertyChanges{target: controls; backgroundOpacity: 1.0}
                PropertyChanges{target: mainWindow; scaleFactor: 0.8;}

            },
            State {
                name: "playing"

                PropertyChanges{target: controls; backgroundOpacity: 0.0}
                PropertyChanges{target: mainWindow; scaleFactor: 1.0;}
            },
            State {
                name: "playing_controls_shown"

                PropertyChanges{target: controls; backgroundOpacity: 0.5}
                PropertyChanges{target: mainWindow; scaleFactor: 1.0;}
            },
            State {
                name: "seeking"

                PropertyChanges{target: controls; backgroundOpacity: 0.5}
                PropertyChanges{target: mainWindow; scaleFactor: 1.0;}
            }

        ]
        transitions: [
            Transition {
                from: "idle"; to: "playing_controls_shown";

                PropertyAnimation{ target: controls; property: "backgroundOpacity"; duration: 600}
                PropertyAnimation{ target: mainWindow; property: "scaleFactor"; duration: 600}
            },
            Transition {
                from: "playing"; to: "idle";

                PropertyAnimation{ target: controls; property: "backgroundOpacity"; duration: 600}
                PropertyAnimation{ target: mainWindow; property: "scaleFactor"; duration: 600}
            },
            Transition {
                from: "playing_controls_shown"; to: "playing";

                PropertyAnimation{ target: controls; property: "backgroundOpacity"; duration: 600}
                PropertyAnimation{ target: mainWindow; property: "scaleFactor"; duration: 600}
            },
            Transition {
                from: "playing_controls_shown"; to: "idle";

                PropertyAnimation{ target: controls; property: "backgroundOpacity"; duration: 600}
                PropertyAnimation{ target: mainWindow; property: "scaleFactor"; duration: 600}
            }
        ]
        Rectangle {

            id: frontScreen
            height: parent.height
            width: parent.width

            Timer {

                id: showTimer
                interval: 10000
                running: false

                onTriggered: {

                    if (mainWindow.state === "playing_controls_shown")
                        mainWindow.state = "playing"
                    else if (mainWindow.state === "playing")
                        mainWindow.state = "playing_controls_shown"

                }
            }

            Video {

                id: video
                width : parent.width
                height : parent.height
                source: "file:///home/pi/video/liza.avi"
                fillMode: VideoOutput.PreserveAspectFit

                Component.onCompleted:    {

                    seekBeginning()
                }

                function seekBeginning() {

                    play()
                    pause()
                    if (seekable) {
                        seek(0)
                    }
                    mainWindow.state = "idle"
                }

                onPlaying: {
                    mainWindow.state = "playing_controls_shown"
                    startTimeObject.setMilliseconds(video.duration)
                }
                onStopped: {
                    seekBeginning()
                }
                onPaused: {
                    mainWindow.state = "playing_controls_shown"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {

                        if (video.playbackState === MediaPlayer.PlayingState || video.playbackState === MediaPlayer.PausedState)
                            mainWindow.state = "playing_controls_shown"
                    }
                }
                focus: true
            }

        }
        ProgressBar {
            id: progressBar
            y: controls.y - height
            backgroundOpacity:  controls.backgroundOpacity
        }

        ControlBar {
            id: controls
            y: frontScreen.height - controls.height
        }
        MediaList {
            id: list
        }
    }
}
