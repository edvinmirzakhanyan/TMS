import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0



Page {
    id: developersPage
    width: parent.width
    height: parent.height
    visible:false
    title: "Developers"

    onFocusChanged: root.devList();

    header: ToolBar {
        id:tBar
        height: 50
        ToolButton {
            id:tBotton
            contentItem: Text {
                text: "<"
                font.pointSize: 14
                color: tBotton.hovered ? "dmagenta" : "darkmagenta"
            }
            anchors.verticalCenter: parent.verticalCenter
            onClicked: { stackView.pop();  developersInfo.clear();}
            background: Rectangle {
                anchors.fill: parent
                color: "transparent"
            }
        }
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            id: toolButtonText
            anchors.centerIn: parent
            text: developersPage.title
            font.pointSize: 17
            color: "darkmagenta"
        }
    }



    Rectangle {
        id: root
        width: parent.width
        height: parent.height
        anchors.topMargin: 50
        color: "white"

        Image {
            id: mainImage
            anchors.fill: parent
            anchors.topMargin: 50
            anchors.rightMargin: 130
            anchors.leftMargin: 130
            anchors.bottomMargin: 130
            opacity: 0.50
            source: "images/main.jpg"
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            id: name
            anchors.top: parent.top
            height: parent.height / 20
            width: parent.width / 5
            anchors.left: parent.left
            anchors.topMargin: parent.height / 10
            anchors.leftMargin: parent.width / 25
            radius: 20
            color: "magenta"
            Text {
                id: nameText
                anchors.centerIn: parent
                font.pointSize: 12
                text: "Name"
                color: "white"
            }
        }

        Rectangle {
            id: surname
            anchors.top: parent.top
            height: name.height
            width: name.width
            anchors.left: name.right
            anchors.topMargin: root.height / 10
            anchors.leftMargin: 20
            radius: 20
            color: "magenta"
            Text {
                id: surnameText
                anchors.centerIn: parent
                font.pointSize: 12
                text: qsTr("Surname")
                color: "white"
            }
        }

        Rectangle {
            id: eMail
            anchors.top: parent.top
            height: name.height
            width: parent.width / 3.5
            anchors.left: surname.right
            anchors.topMargin: parent.height / 10
            anchors.leftMargin: 20
            radius: 20
            color: "magenta"
            Text {
                id: eMailText
                anchors.centerIn: parent
                font.pointSize: 12
                text: qsTr("E-Mail")
                color: "white"
            }
        }

        Rectangle {
            id: assignTaskWindow
            anchors.fill: parent
            opacity: 0.90
            color: "white"
            visible: false

            TextField {
                id: projectNameText
                height: parent.height / 17
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: parent.height / 3
                anchors.leftMargin: parent.width / 3
                anchors.rightMargin: parent.width / 3
                placeholderText: "Project name"
                background: Rectangle {
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }

            TextField {
                id: taskNameText
                height: parent.height / 17
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: projectNameText.bottom
                anchors.topMargin: 20
                anchors.leftMargin: parent.width / 3
                anchors.rightMargin: parent.width / 3
                placeholderText: "Task name"
                background: Rectangle {
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }

            Button {
                id: acceptButton
                anchors.top: taskNameText.bottom
                anchors.left: taskNameText.left
                anchors.right: taskNameText.right
                anchors.topMargin: 20
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                background: Rectangle {
                    anchors.fill: parent
                    color: acceptButton.hovered ? "lightgray" : "white"
                    border.color: "darkmagenta"
                    border.width: 2
                    radius: 20
                }
                contentItem: Text {
                    id: acceptButtonText
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: "Assign"
                    font.pointSize: 14
                    color: "darkmagenta"
                }
                onClicked: {
                    user.setTask(projectNameText.text, taskNameText.text);
                    projectNameText.text = "";
                    taskNameText.text = "";
                }

            }
        }



        Rectangle {
            anchors.top: name.bottom
            anchors.topMargin: 10
            anchors.bottom: parent.bottom
            anchors.left: name.left
            anchors.right: parent.right
            color: "transparent"
            ListModel {
                    id: developersInfo
            }
            ListView {
                id:devList
                anchors.fill: parent
                model: developersInfo
                clip: true
                spacing: 10
                delegate: Rectangle {
                    height: root.height / 20
                    width: root.width
                    color: "transparent"

                    Label {
                        id: developerName
                        height: parent.height
                        width: root.width / 5
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: developerNameText
                        color: "magenta"
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 20
                            color: "white"
                            border.color: "magenta"
                        }
                    }

                    Label {
                        id: developerSurname
                        height:  developerName.height
                        width: root.width / 5
                        anchors.left: developerName.right
                        anchors.leftMargin: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: developerSurnameText
                        color: "magenta"
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 20
                            color: "white"
                            border.color: "magenta"
                        }
                    }

                    Label {
                        id: developerEmail
                        height:  developerName.height
                        width: root.width / 3.5
                        anchors.left: developerSurname.right
                        anchors.leftMargin: 20
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        text: developerEmailText
                        color: "magenta"
                        background: Rectangle {
                            anchors.fill: parent
                            radius: 20
                            color: "white"
                            border.color: "magenta"
                        }
                    }

                    Button {
                        id: assignButton
                        anchors.top: parent.top
                        height: developerName.height
                        width: developerName.width
                        anchors.left: developerEmail.right
                        anchors.leftMargin: 20
                        background: Rectangle {
                            id: assignButtonBackground
                            width: parent.width
                            height: parent.height
                            color: assignButton.hovered ? "lightgray" : "white"
                            border.color: "darkmagenta"
                            border.width: 2
                            radius: 20
                        }
                        contentItem: Text {
                            id: assignButtonText
                            text: qsTr("Assign Task")
                            font.pointSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            color: "darkmagenta"
                        }
                        onClicked: {
                                tBar.visible = false;
                                devList.visible = false;
                                name.visible = false;
                                surname.visible = false;
                                eMail.visible = false;
                                assignTaskWindow.visible = true;
                                user.setSelectedUser(developersInfo.get(index).developerEmailText)
                            }
                        }
                    }
                }
            }

        function devList(arr = user.getDevelopers()) {
        let narr;
        for (let i = 0; i < arr.length; ++i) {
            if (arr[i].length) {
                narr = user.split(arr[i]);
                developersInfo.append( { developerNameText: narr[0], developerSurnameText: narr[1], developerEmailText: narr[2], } )
                }
            }
        }
    }
        Connections {
            target:user
            onTaskAssignError: {
                mainWindowNotification.visible = true;
                notificationText.text = type;
                tBar.visible = true;
                devList.visible = true;
                name.visible = true;
                surname.visible = true;
                eMail.visible = true;
                assignTaskWindow.visible = false;
            }
            onTaskAssignSuccess: {
                mainWindowNotification.visible = true;
                notificationText.text = "Task added successfully!"
                tBar.visible = true;
                devList.visible = true;
                name.visible = true;
                surname.visible = true;
                eMail.visible = true;
                assignTaskWindow.visible = false;
            }
    }
}
