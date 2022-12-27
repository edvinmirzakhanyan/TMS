import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0



Page {
    id: projectsPage
    width: parent.width
    height: parent.height
    visible:false
    title: "Projects"

    onFocusChanged: root.projectList();

    header: ToolBar {
        id: tBar
        height: 50
        ToolButton {
            id:tBotton
            contentItem: Text {
                text: "<"
                font.pointSize: 14
                color: tBotton.hovered ? "magenta" : "darkmagenta"
            }
            anchors.verticalCenter: parent.verticalCenter
            onClicked: { stackView.pop();  projects.clear();}
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
            text: "Projects"
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
            id: projectNameWindow
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
        }

        Button {
            id: projectCreateButton
            anchors.top: parent.top
            anchors.left: parent.left
            height: parent.height / 13
            width: parent.width / 1.7
            anchors.topMargin: 30
            anchors.leftMargin: root.width / 5

            background: Rectangle {
                anchors.fill: parent
                color: projectCreateButton.hovered ? "lightgray" : "white"
                border.color: "darkmagenta"
                border.width: 2
                radius: 20
            }

            contentItem: Text {
                id: projectCreateButtonText
                text: "Create Project"
                color: "darkmagenta"
                font.pointSize: 17
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: {
                if (!projectNameWindow.visible) {
                    tBar.visible = false;
                    list.visible = false;
                    project.visible = false;
                    projectNameWindow.visible = true;
                }
                else {
                    user.setProject(projectNameText.text);
                }
            }
        }

        Rectangle {
            id: project
            anchors.top: projectCreateButton.bottom
            anchors.left: parent.left
            height: parent.height / 13
            width: parent.width / 1.7
            anchors.topMargin: 10
            anchors.leftMargin: root.width / 5
            radius: 20
            color: "magenta"
            Text {
                id: nameText
                anchors.centerIn: parent
                font.pointSize: 17
                text: "Projects"
                color: "white"
            }
        }

        Rectangle {
            anchors.top: project.bottom
            anchors.topMargin: 10
            anchors.bottom: root.bottom
            anchors.left: project.left
            anchors.right: project.right

            color: "transparent"
            ListModel {
                id: projects
            }
            ListView {
                id:list
                anchors.fill: parent

                model: projects
                clip: true
                focus: true
                spacing: 10
                delegate: Rectangle {
                    id: listButton
                    height: root.height / 13
                    width: root.width / 1.7
                    color: "transparent"

                    Button {
                        id: projectsButton
                        anchors.fill: parent
                        background: Rectangle {
                            anchors.fill: parent
                            color: projectsButton.hovered ? "lightgray" : "white"
                            border.color: "magenta"
                            radius: 20
                        }

                        contentItem: Text {
                            id: projectsButtonText
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            text: projectName ? projects.get(index).projectName : ""
                            color: "magenta"
                            font.pointSize: 14
                        }

                        onClicked: {
                            user.setAdminCurrentProject(projects.get(index).projectName);
                            stackView.push(tasksPage);
                            projects.clear();
                        }
                    }

            }
        }
    }

        function projectList(arr = user.getProjects()) {
        for (let i = 0; i < arr.length; ++i) { projects.append({ projectName: arr[i]});}
        }
    }

        Connections {
        target: user
        onProjectCreateError: {
            mainWindowNotification.visible = true;
            notificationText.text = type;
            tBar.visible = true;
            list.visible = true;
            project.visible = true;
            projectNameWindow.visible = false;
        }
        onProjectCreateSuccess: {
            mainWindowNotification.visible = true;
            notificationText.text = "Project successfully created!";
            tBar.visible = true;
            list.visible = true;
            project.visible = true;
            projectNameWindow.visible = false;
        }
    }
}

