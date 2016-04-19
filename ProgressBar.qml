import QtQuick 2.0

Item {

    id: progress
    height: mainWindow.height / 100
    width: mainWindow.width
    property real position
    property real playedWidth
    property real unplayedWidth
    property alias barOpacity : unplayed.opacity
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
        playedWidth = Math.round((position*parent.width)/100)
        unplayedWidth = parent.width - indicator.width - played.width
    }

    Row
    {
        anchors.fill: parent
        Rectangle {
            id: played
            color: "red"
            height: progress.height
            width: Math.round(playedWidth)
        }
        Rectangle {
            id: indicator
            color: "white"
            width: 8
            height: progress.height

        }

        Rectangle {
            id: unplayed
            color: "#a8a8a9"
            height: progress.height
            width: Math.round(unplayedWidth)
        }
    }
}
//            Keys.onLeftPressed: video.seek(video.position - 5000)
//            Keys.onRightPressed: video.seek(video.position + 5000)
