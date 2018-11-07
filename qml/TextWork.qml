import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.11

import Fluid.Controls 1.0 as FluidControls

FluidControls.Page {
    GridLayout {
        columns: 2
        width: parent.width
        Button {
            anchors.left: parent.left
            anchors.topMargin: 50
            anchors.leftMargin: 10
            text: "Обработка"
        }
        Button {
            id: openFileButton
            anchors.right: parent.right
            anchors.topMargin: 50
            anchors.rightMargin: 10
            text: "Открыть файл"
            onClicked: {
                explorer.open()
            }
        }

        ScrollBar {
            anchors.fill: parent
            enabled: true
            clip: true
            TextArea {
                clip: true
                id:ta
                anchors.fill: parent
                wrapMode: TextArea.WordWrap
                text:"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nan\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\nxxxxxx" //TextHandler.source_text
            }
        }
    }

    FileDialog {
        id: explorer
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "(*.docx *.dox *.txt)" ]
        onAccepted: {
            console.log("You chose: " + ("" + explorer.fileUrls).split("///")[1])
            TextHandler.openTextFromFile(("" + explorer.fileUrls).split("///")[1])
            console.log(TextHandler.source_text)
//            noise_deleter.openFile(("" + fileDialog.fileUrls).split("///")[1]);
//            pathDialog.open();
        }
        onRejected: {
            console.log("Canceled")
        }
    }
}
