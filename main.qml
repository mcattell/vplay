import QtQuick 2.5
import QtQuick.Window 2.2
import QtMultimedia 5.6

Window {
    id: mainWindow
    visible: true
    color: "#000000"
    height: Screen.desktopAvailableHeight
    width: Screen.desktopAvailableWidth
    property alias videoPosition : video.position
    property alias videoDuration : video.duration

    Component.onCompleted: {
        showTimer.start()
    }


    Item {

        id: frontScreen
        height: mainWindow.height - controls.height
        width: mainWindow.width
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
                PropertyChanges{target: progressBar; y: mainWindow.height}
            },
            State {
                name: "playing_controls_shown"
                PropertyChanges{target: frontScreen; height: mainWindow.height}
                PropertyChanges{target: controls; y:  frontScreen.height - controls.height}
                PropertyChanges{target: progressBar; y: controls.y - progressBar.height}
                PropertyChanges{target: controls; backgroundOpacity: 0.4}
                PropertyChanges{target: progressBar; barOpacity: 0.4}
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
            source: "file:///home/pi/video/Bates.Motel.S02E03.720p.HDTV.x264-2HD.mkv"
            //source:"http://download.wavetlan.com/SVV/Media/HTTP/AVI/SUPER/SUPER_test2_H264_16bit_320x240_AR4to3_15fps_KF1to1_1057kbps_AAC_Mono_11025Hz_64kbps.AVI"

            onPlaying: {
                frontScreen.state = "playing_controls_shown"
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
