import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0



Window {
    id: mainWindow
    height: 800
    width: 1200
    minimumHeight: 800
    minimumWidth: 1200
    visible: true
    title: qsTr("TMS")
    
    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: login
    }

    Rectangle {
        id: mainWindowNotification
        anchors.fill: parent
        color: "white"
        opacity: 0.90
        visible: false

        Label {
            id: notificationText
            anchors.centerIn: parent
            font.pointSize: 15
            color: "black"
        }

        Button {
            id: okButton
            anchors.top: notificationText.bottom
            anchors.left: notificationText.left
            anchors.right: notificationText.right
            anchors.topMargin: 30
            anchors.leftMargin: 50
            anchors.rightMargin: 50
            background: Rectangle {
                id: okButtonBackground
                width: parent.width
                height: parent.height
                color: okButton.hovered ? "darkmagenta" : "magenta"
                radius: 10
            }
            contentItem: Text {
                id: okButtonText
                text: "Ok"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
            onClicked: {
                notificationText.text = "";
                mainWindowNotification.visible = false;
            }
        }
    }


    LogInPage {
        id: login
        onSignUpButtonClicked: { stackView.push(signUpPage); }
        onAdminLoginButtonClicked: { stackView.push(adminGeneralPage); }
        onUserLoginButtonClicked: { stackView.push(userGeneralPage); }
    }

    SIgnUpPage {
        id: signUpPage
        onSignUpButtonClicked: { stackView.pop(); }
    }

    AdminGeneralPage {
        id: adminGeneralPage
        onMyPageButtonClicked:  { stackView.push(adminInfoPage); }
        onProjectsButtonClicked: { stackView.push(projectsPage); }
        onDevelopersButtonClicked: { stackView.push(developersPage); }
        onSignOutButtonClicked:  { stackView.pop(); }
    }

    AdminInfoPage {
        id: adminInfoPage
        visible: false
    }

    ProjectsPage {
        id: projectsPage
    }


    DevelopersPage {
        id: developersPage
    }

    AdminTaskPage {
        id: tasksPage
    }

    UserGeneralPage {
        id: userGeneralPage
        onMyPageButtonClicked: { stackView.push(adminInfoPage); }
        onMyTasksButtonClicked: { stackView.push(userTasksPage); }
        onSignOutButtonClicked: { stackView.pop(); }
    }

    UserTasksPage {
        id: userTasksPage
    }



}

