import QtQuick 2.5
import QtQuick.Controls 1.4

Item {
    id: timerDisplay

    property int totalHours : startTimeObject.hours
    property int totalMinutes : startTimeObject.minutes
    property int totalSeconds : startTimeObject.seconds

    property int currentHours : currentTimeObject.hours
    property int currentMinutes : currentTimeObject.minutes
    property int currentSeconds : currentTimeObject.seconds

    function pad(n, width, z) {

        z = z || '0';
        n = n + '';
        return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
    }



    Row {
        Label {
            id: current
            width: 1.8*controlBar.height
            height: controlBar.height
            text: pad(currentHours, 2) + ":" + pad(currentMinutes, 2) + ":" + pad(currentSeconds, 2)
            font.pixelSize: 24
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
            text: "/"
            font.pixelSize: 24
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
            text: pad(totalHours, 2) + ":" + pad(totalMinutes, 2) + ":" + pad(totalSeconds, 2)
            font.pixelSize: 24
            font.bold: true
            font.family: openSans.name
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
        }
    }
}
