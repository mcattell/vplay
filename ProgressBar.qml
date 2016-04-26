import QtQuick 2.0
import QtMultimedia 5.6

Item {

    id: progress

    height: mainWindow.height / 100
    width: mainWindow.width

    property real position
    property real playedWidth
    property real unplayedWidth
    property real draggedPosition

    Timer {
        id: updateTimer
        interval: 500
        repeat: true
    }

    Component.onCompleted: {

        updateTimer.triggered.connect(calculatePosition)
        updateTimer.start()
    }

    function calculatePosition() {

        position = 100 - (((mainWindow.videoDuration - mainWindow.videoPosition)/mainWindow.videoDuration)*100)
        playedWidth = (position*parent.width)/100
        unplayedWidth = progress.width - played.width
    }

    function calculateDraggedPosition(xPos) {

        playedWidth = xPos
        unplayedWidth = progress.width - xPos
        video.seek((xPos/progress.width)*mainWindow.videoDuration)
    }

    Row
    {
        anchors.fill: parent
        Rectangle {
            id: played

            color: "red"
            height: progress.height
            width: Math.round(playedWidth)
            MouseArea {
                id: rewindArea
                anchors.fill: parent
            }
        }
        Rectangle {
            id: indicator
            color: "white"
            width: height
            height: 4*progress.height
            radius: width/2
            y: -1.5*progress.height

            onXChanged: {
                if (indicatorMouseArea.drag.active) {
                    calculateDraggedPosition(x)
                }
            }

            MouseArea {

                id: indicatorMouseArea
                anchors.fill: parent
                drag.target: indicator
                drag.axis: "XAxis"
                drag.minimumX: 0
                drag.maximumX: progress.width

                onPressed: {

                    if (video.playbackState === MediaPlayer.PlayingState) {
                        updateTimer.stop()
                        video.pause()
                        frontScreen.state = "seeking"
                    }
                }
                onReleased: {

                    if (video.playbackState === MediaPlayer.PausedState) {
                        video.play()
                        updateTimer.start()
                        frontScreen.state = "playing_controls_shown"
                    }
                }
            }
        }

        Rectangle {
            id: unplayed
            color: "#a8a8a9"
            height: progress.height
            width: Math.round(unplayedWidth)
            MouseArea {
                id: fastForwardArea
                anchors.fill: parent
            }
        }
    }
}

