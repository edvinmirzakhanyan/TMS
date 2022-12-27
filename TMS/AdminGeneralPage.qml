import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0



Page {
    id: adminGeneralPage
    width: parent.width
    height: parent.height
    visible: false
    title: "General Page"

    signal myPageButtonClicked();
    signal projectsButtonClicked();
    signal developersButtonClicked();
    signal signOutButtonClicked();

    header: ToolBar {
        height: 50
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            id: toolButtonText
            anchors.centerIn: parent
            text: "General Page"
            font.pointSize: 17
            color: "darkmagenta"

        }
    }

    Rectangle {
        id: main
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

        Button {
            id: myPageButton
            height: parent.height / 10
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 150
            anchors.leftMargin: 150
            anchors.topMargin: 100
            background: Rectangle {
                id: myPageButtonBackground
                width: parent.width
                height: parent.height
                color: myPageButton.hovered ? "darkmagenta" : "magenta"
                radius: 30
            }
            contentItem: Text {
                id: mypageButtonText
                text: qsTr("My Page")
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            onClicked: {
                myPageButtonClicked();
            }
        }

        Button {
            id: projectsButton
            height: parent.height / 10
            anchors.top: myPageButton.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 150
            anchors.leftMargin: 150
            anchors.topMargin: 30
            background: Rectangle {
                id: projectsButtonBackground
                width: parent.width
                height: parent.height
                color: projectsButton.hovered ? "darkmagenta" : "magenta"
                radius: 30
            }
            contentItem: Text {
                id: projectsButtonText
                text: qsTr("Projects & Tasks")
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            onClicked: {
                projectsButtonClicked();
            }
        }

        Button {
            id: developersButton
            height: parent.height / 10
            anchors.top: projectsButton.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 150
            anchors.leftMargin: 150
            anchors.topMargin: 30
            background: Rectangle {
                id: developersButtonBackground
                width: parent.width
                height: parent.height
                color: developersButton.hovered ? "darkmagenta" : "magenta"
                radius: 30
            }
            contentItem: Text {
                id: developersButtonText
                text: qsTr("Developers")
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            onClicked: {
                developersButtonClicked();
            }
        }

        Button {
            id: signOutButton
            height: parent.height / 10
            anchors.top: developersButton.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 150
            anchors.leftMargin: 150
            anchors.topMargin: 30
            background: Rectangle {
                id: signOutButtonBackground
                width: parent.width
                height: parent.height
                color: signOutButton.hovered ? "lightgray" : "white"
                border.color: "magenta"
                radius: 30
            }
            contentItem: Text {
                id: signInButtonText
                text: qsTr("Sign Out")
                font.pointSize: 14
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "magenta"
            }
            onClicked: {
                signOutButtonClicked();
            }
        }
    }
}
