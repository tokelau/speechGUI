import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.11

import Fluid.Controls 1.0 as FluidControls
import RNnoise 1.0

FluidControls.ApplicationWindow {
    id: window
    visible: true
    width: 1024
    height: 800
    minimumWidth: width / 3
    minimumHeight: height / 3
    title: qsTr("Text analyser")

    Material.theme: Material.Dark

    TextField {
        id: searchArea
        visible: false
        focus: true
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: -45
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.leftMargin: (navDrawer.modal ? 0 : navDrawer.position * navDrawer.width) + 10
        z: 100
        selectByMouse: true

        Material.accent: "#FFF"
        Material.foreground: "#FFF"
        onTextChanged: {
            VocabularyHandler.search(searchArea.text);
        }
        onFocusChanged: {
            searchArea.focus = true
        }
    }

    FluidControls.NavigationDrawer {
        id: navDrawer
        readonly property bool mobileAspect: window.width < (600 + navDrawer.width)

        modal: mobileAspect
        interactive: mobileAspect
        position: mobileAspect ? 0.0 : 1.0
        visible: !mobileAspect

        GridLayout {
            columns: 1
            Layout.alignment: Qt.AlignTop | Qt.AlignVCenter

            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("action/book")
                text: "Словарь"
                onPressed: {
                    stackView.push("qrc:/qml/VocabularyWork.qml")
                    if (navDrawer.mobileAspect)
                        navDrawer.close()
                }
            }
            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("editor/format_align_justify")
                text: "Текст"
                onPressed: {
                    searchArea.visible = false
                    stackView.push("qrc:/qml/TextWork.qml")
                    if (navDrawer.mobileAspect) {
                        navDrawer.close()
                    }
                }
            }
            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("av/music_video")
                text: "Мультимедиа"
                onPressed: {
                    searchArea.visible = false
                    stackView.push("qrc:/qml/MediaWork.qml")
                }
            }
            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("action/history")
                text: "История"
                onPressed: {
                    searchArea.visible = false
                    stackView.push("qrc:/qml/HistoryWork.qml")
                }
            }
            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("action/settings")
                text: "Настройки"
            }
            FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl("action/info")
                text: "О программе"
            }
        }
    }
    initialPage: FluidControls.Page {
        id: page
        title: window.title

        x: navDrawer.modal ? 0 : navDrawer.position * navDrawer.width
        width: window.width - x

        leftAction: FluidControls.Action {
            id: menuButton
            icon.source: FluidControls.Utils.iconUrl("navigation/menu")
            visible: navDrawer.modal
            onTriggered: navDrawer.visible ? navDrawer.close() : navDrawer.open()
        }

        actions: [
            FluidControls.Action {
                icon.source: FluidControls.Utils.iconUrl("action/search")
                id: searchButton
                property bool searchOn: false
                onTriggered: {
                    if (!searchButton.searchOn) {
                        searchButton.icon.source = FluidControls.Utils.iconUrl("navigation/close");
                        menuButton.visible = false
                        searchArea.visible = true
                        page.title = ""
                        searchButton.searchOn = true
                        searchArea.focus = true
                    } else {
                        searchButton.icon.source = FluidControls.Utils.iconUrl("action/search");
                        menuButton.visible = true
                        searchArea.visible = false
                        page.title = window.title
                        searchButton.searchOn = false
                        searchArea.text = ""
                    }
                }
            }
        ]

        StackView {
            id: stackView
            anchors.fill: parent
            initialItem: "qrc:/qml/MediaWork.qml"
        } //ListView

        FileDialog {
            id: explorer
            onAccepted: {
                fileName = explorer.fileUrl.toString()
                Qt.quit()
            }
            onRejected: {
                Qt.quit()
            }
        }
    }



    /*NoiseDeleter {
        id: noise_deleter
    }

    Button {
        id: button_wav
        text: "Выбрать wav файл"
        onPressed: {
            fileDialog.open();
        }
    }

    Button {
        anchors.left: button_wav.right
        id: button_txt
        text: "Выбрать txt файл"
        onPressed: {
            fileDialog_txt.open();
        }
    }

    FileDialog {
        id: fileDialog_txt
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "txt (*.txt)" ]
        onAccepted: {
            console.log("You chose: " + ("" + fileDialog_txt.fileUrls).split("///")[1])
            TextHandler.openTextFromFile(("" + fileDialog_txt.fileUrls).split("///")[1]);
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        nameFilters: [ "PCM 16bit 44100khz (*.wav *.pcm)" ]
        onAccepted: {
            console.log("You chose: " + ("" + fileDialog.fileUrls).split("///")[1])
            noise_deleter.openFile(("" + fileDialog.fileUrls).split("///")[1]);
            pathDialog.open();
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    FileDialog {
        id: pathDialog
        title: "Please choose a folder to save out.wav"
        folder: shortcuts.home
        nameFilters: [ "PCM 16bit 44100khz ()" ]
        selectFolder: true
        onAccepted: {
            console.log("You chose: " + pathDialog.fileUrls)
            noise_deleter.saveDataToFile(("" + pathDialog.fileUrls).split("///")[1] + "/out.wav");
            noise_deleter.computeData();
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    ListView {
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: button_txt.right
        spacing: 1
        model: TextHandler.model
        delegate: Rectangle {
            height: 25
            width: parent.width
            color: "lightgray"
            Text { text: modelData; anchors.centerIn: parent }
        }
    }*/
}
