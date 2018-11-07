import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.4
import QtQuick.Layouts 1.11

import Fluid.Controls 1.0 as FluidControls

Page {
    property string overlayViewBodyPlaceholder: ""
    property string overlayViewBodyTitle: ""
    property int statusDialog: 0 //delete - 0 add - 1 edit - 2
    property string oldWordForEdit: ""

    ListView {
        id: wordsList
        anchors.fill: parent
        anchors.bottomMargin: 80
        model: VocabularyHandler.model
        delegate: FluidControls.ListItem {
            showDivider: true
            leftItem: CheckBox {
                visible: false
                Material.accent: Material.Blue
                onCheckedChanged: {
                    console.log(model.index);
                }
            }

            rightItem: Item {
                anchors.top:  parent.top
                anchors.topMargin: 5
                width: 80
                height: 40
                FluidControls.ToolButton {
                    id: btn_left
                    anchors.top:  parent.top
                    icon.source: FluidControls.Utils.iconUrl("action/delete")
                    Material.foreground: Material.Pink
                    onClicked: {
                        VocabularyHandler
                        overlayViewBodyTitle = "Подтверждение"
                        overlayViewBodyPlaceholder = "Вы действительно хотите удалить слово?"
                        statusDialog = 0
                        overlayView.open()
                    }
                }
                FluidControls.ToolButton {
                    id: btn_right
                    anchors.left: btn_left.right
                    anchors.leftMargin: -10
                    anchors.top:  parent.top
                    icon.source: FluidControls.Utils.iconUrl("image/edit")
                    Material.foreground: Material.Blue
                    onClicked: {
                        editWordTextArea.text = model.modelData
                        oldWordForEdit = model.modelData
                        overlayViewBodyTitle = "Редактирование"
                        overlayViewBodyPlaceholder = "Редактируемое слово"
                        statusDialog = 2
                        overlayView.open()
                    }
                }
            }
            text: model.modelData
        }
    }

    Rectangle {
        width: 60
        height: 60
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        anchors.right: parent.right
        anchors.rightMargin: 20
        color: Material.color(Material.Blue)
        radius: 40

        FluidControls.ToolButton {
            width: parent.width
            height: parent.height
            anchors.centerIn: parent
            icon.source: FluidControls.Utils.iconUrl("content/add")
            Material.foreground: "#FFF"
            onPressed: {
                overlayViewBodyTitle = "Добавление"
                overlayViewBodyPlaceholder = "Добавляемое слово"
                statusDialog = 1
                overlayView.open()
            }
        }
    }

    FluidControls.OverlayView {
        id: overlayView

        width: 300
        height: 160

        Pane {
            id: overlayViewBody
            anchors.fill: parent
            Material.elevation: 6
            Label {
                anchors.top: parent.top
                anchors.left: parent.left
                text: overlayViewBodyTitle
                font.pixelSize: 17
            }
            TextArea {
                id: editWordTextArea
                visible: statusDialog
                placeholderText: overlayViewBodyPlaceholder
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.bottom: editWordTextAreaCancelButton.top
                anchors.bottomMargin: 10
                Material.accent: Material.Blue
                //Material.foreground: Material.Indigo
            }

            Label {
                text: overlayViewBodyPlaceholder
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: editWordTextAreaCancelButton.top
                anchors.bottomMargin: 28
                visible: !statusDialog
            }

            Button {
                anchors.right: editWordTextAreaCancelButton.left
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                text: "Применить"
                Material.background: Material.Blue
                Material.foreground: "#FFF"
                onPressed: {
                    switch(statusDialog) {
                        case 0:
                            console.log(deletingWords)
                            VocabularyHandler.deleteWords(deletingWords)
                            break
                        case 1:
                            VocabularyHandler.saveWord(editWordTextArea.text)
                            break
                        case 2:
                            VocabularyHandler.editWord(oldWordForEdit, editWordTextArea.text)
                            break
                    }

                    overlayView.close()
                }
            }

            Button {
                id: editWordTextAreaCancelButton
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.bottom: parent.bottom
                text: "Отмена"
                onPressed: {
                    overlayView.close()
                }
            }
        }
    }
}
