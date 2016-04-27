import QtQuick 2.0
import QtMultimedia 5.6
import com.vplay.qmltypes 1.0

Item {

    id: progress

    height: parent.height / 100
    width: parent.width

    property real position
    property real playedWidth
    property real unplayedWidth
    property real draggedPosition

    property real backgroundOpacity


    Timer {
        id: updateTimer
        interval: 500
        repeat: true
    }

    Component.onCompleted: {

        updateTimer.triggered.connect(calculatePosition)
        updateTimer.start()
    }

    function updateWidth() {

        calculatePosition()
    }

    function calculatePosition() {

        position = 100 - (((mainWindow.videoDuration - mainWindow.videoPosition)/mainWindow.videoDuration)*100)
        playedWidth = (position*parent.width)/100
        unplayedWidth = progress.width - played.width - indicator.width
        currentTimeObject.setMilliseconds(mainWindow.videoPosition, TimeDisplayType.CurrentTime)

    }

    function calculateDraggedPosition(xPos) {

        playedWidth = xPos
        unplayedWidth = progress.width - xPos - indicator.width
        video.seek((xPos/progress.width)*mainWindow.videoDuration)
    }

    Row
    {
        anchors.fill: parent

        Rectangle {
            id: played
            opacity: backgroundOpacity
            color: "red"
            height: progress.height
            width: playedWidth

            border.color: "black"
            border.width: 1

            MouseArea {
                id: rewindArea
                anchors.fill: parent
            }
        }
        Rectangle {
            id: indicator
            opacity: backgroundOpacity
            color: "white"
            width: height
            height: 4*progress.height
            radius: width/2
            y: -1.5*progress.height
            border.color: "black"
            border.width: 1

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
                        mainWindow.state = "seeking"
                    }
                }
                onReleased: {

                    if (video.playbackState === MediaPlayer.PausedState) {
                        video.pause()
                        updateTimer.start()
                        mainWindow.state = "playing_controls_shown"
                    }
                    else if (video.playbackState === MediaPlayer.PlayingState) {
                        updateTimer.start()
                        video.play()
                        mainWindow.state = "playing_controls_shown"
                    }
                }
            }
        }

        Rectangle {
            id: unplayed
            opacity: backgroundOpacity
            color: "#a8a8a9"
            height: progress.height
            width:unplayedWidth
            border.color: "black"
            border.width: 1
            MouseArea {
                id: fastForwardArea
                anchors.fill: parent
            }
        }
    }
}

