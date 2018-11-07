import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.11
import QtMultimedia 5.8

import Fluid.Controls 1.0 as FluidControls

FluidControls.Page {
    GridLayout {
        columns: 1
        width: parent.width
        Button {
            anchors.right: parent.right
            anchors.centerIn: parent.Center
            anchors.rightMargin: 10
            text: "Загрузить"
            onClicked: {
                explorer.open()
            }
        }
        MediaPlayer {
            id: playMusic
            source: "rec_15s.wav"
        }
        Button {
            text: "Проиграть"
            onClicked:  {
                console.log(playMusic.source)
                playMusic.play()
            }
        }
     }
    
    FileDialog {
        id: explorer
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "(*.wav *.pcm)" ]
        onAccepted: {
            //console.log("You chose: " + ("" + explorer.fileUrls).split("///")[1])
            playMusic.source = ("" + explorer.fileUrls).split("///")[1]
        }
        onRejected: {
            console.log("Canceled")
        }
    }
}
