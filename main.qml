import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.6

Window {
    id: mainWindow
    visible: true
    color: "#807F15"
    height: Screen.desktopAvailableHeight
    width: Screen.desktopAvailableWidth


    Component.onCompleted: {
        showTimer.start()
    }

    //!(video.playbackState === MediaPlayer.PlayingState)
    Item {

        id: frontScreen
        height: mainWindow.height - controls.height
        width: mainWindow.width
        state: "idle"



        states : [
            State {
                name: "idle"
                PropertyChanges{target: frontScreen; height: mainWindow.height - controls.height}
                PropertyChanges{target: controls; y:  frontScreen.height}
            },
            State {
                name: "playing"
                PropertyChanges{target: frontScreen; height: mainWindow.height}
                PropertyChanges{target: controls; y:  mainWindow.height}
            },
            State {
                name: "playing_controls_shown"
                PropertyChanges{target: frontScreen; height: mainWindow.height - controls.height}
                PropertyChanges{target: controls; y:  mainWindow.height}
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
            interval: 3000
            running: false
            onTriggered: {


            }
        }

        Video {
            id: video
            width : parent.width
            height : parent.height
            source: "file:///home/pi/liza.avi"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(video.duration - video.position)
                    showTimer.start()
                }
            }

            focus: true
            //            Keys.onSpacePressed: video.playbackState == MediaPlayer.PlayingState ? video.pause() : video.play()
            //            Keys.onLeftPressed: video.seek(video.position - 5000)
            //            Keys.onRightPressed: video.seek(video.position + 5000)
        }

    }

    ControlBar {
        id: controls

    }
}
