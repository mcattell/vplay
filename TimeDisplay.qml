import QtQuick 2.5
import QtQuick.Controls 1.4
import QtMultimedia 5.6
import com.vplay.qmltypes 1.0

Item {
    id: timerDisplay


    Row {
        Label {
            id: current
            width: 1.8*controlBar.height
            height: controlBar.height
            text: currentTimeObject.currentTime
            font.pixelSize: 24*mainWindow.scaleFactor
            font.bold: true
            font.family: openSans.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
        Label {
            id: oblique
            width: controlBar.height/2
            height: controlBar.height
            text: (video.playbackState === MediaPlayer.PlayingState || video.playbackState === MediaPlayer.PausedState) ? "/" : ""
            font.pixelSize: 24*mainWindow.scaleFactor
            font.bold: true
            font.family: openSans.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
        Label {
            id: total
            width: 1.8*controlBar.height
            height: controlBar.height
            text: startTimeObject.totalTime
            font.pixelSize: 24*mainWindow.scaleFactor
            font.bold: true
            font.family: openSans.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
    }
}
