import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0



Page {
    id:signUpPage
    width: parent.width
    height: parent.height
    visible: false
    title: "Sign up"

    signal signUpButtonClicked();

    header: ToolBar {
        height: 50
        ToolButton {
            id:tBotton
            contentItem: Text {
                text: "<"
                font.pointSize: 14
                color: tBotton.hovered ? "dmagenta" : "darkmagenta"
            }
            anchors.verticalCenter: parent.verticalCenter
            onClicked: stackView.pop()
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
            text: "Sign Up"
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
            id: logo
            source: "images/logo.png"
            height: parent.height / 5
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.left: parent.left
            fillMode: Image.PreserveAspectFit
            anchors.topMargin: 50
            anchors.leftMargin: 20
            anchors.rightMargin: 20
        }

        Rectangle {
            id: inputArea
            height: 300
            width: parent.width / 2
            anchors.top: logo.bottom
            anchors.left: parent.left
            anchors.topMargin: 50
            anchors.leftMargin: parent.width / 4
            color: "transparent"

            TextField {
                id: name
                height: parent.height / 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                placeholderText: "Name"
                background: Rectangle {
                    id: nameBorder
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }

            TextField {
                id: surname
                height: parent.height / 10
                anchors.top: name.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 30
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                placeholderText: "Surname"
                background: Rectangle {
                    id:surnameBorder
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }

            TextField {
                id: eMail
                height: parent.height / 10
                anchors.top: surname.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 30
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                placeholderText: "E-Mail"
                background: Rectangle {
                    id:eMailBorder
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }

            TextField {
                id: password
                height: parent.height / 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: eMail.bottom
                anchors.topMargin: 30
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                echoMode: TextInput.Password
                placeholderText: "Password"
                background: Rectangle {
                    id: passworBorder
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }


            TextField {
                id: userAdmin
                height: parent.height / 10
                anchors.top: password.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 30
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                placeholderText: "User/Admin"
                background: Rectangle {
                    id:userAdminBorder
                    height: 1
                    anchors.bottom: parent.bottom
                    color: "magenta"
                }
            }



            Button {
                id: signUpButton
                height: parent.height / 10
                anchors.top: userAdmin.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 100
                anchors.leftMargin: 100
                anchors.topMargin: 30
                background: Rectangle {
                    id: signUpButtonBackground
                    width: parent.width
                    height: parent.height
                    color: signUpButton.hovered ? "darkmagenta" : "magenta"
                    radius: 10
                }
                contentItem: Text {
                    id: signUpButtonText
                    text: qsTr("Sign up")
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    color: "white"
                }
                onClicked: {
                    user.signUpCheck(name.text, surname.text, eMail.text, password.text, userAdmin.text);
                }
            }
        }

        Rectangle {
            id: signUpError
            anchors.fill: parent
            color: "white"
            opacity: 0.90
            visible: false

            Label {
                id: errorText
                anchors.centerIn: parent
                font.pointSize: 15
                color: "black"
            }

            Button {
                id: okButton
                anchors.top: errorText.bottom
                anchors.left: errorText.left
                anchors.right: errorText.right
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
                    id: errorOkButtonText
                    text: "Ok"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    errorText.text = "";
                    signUpError.visible = false;
                }
            }

            function showError(type) {
                errorText.text = type;
                visible = true;
            }
        }

        Rectangle {
            id: signUpSuccess
            anchors.fill: parent
            color: "white"
            opacity: 0.90
            visible: false

            Label {
                id: successText
                anchors.centerIn: parent
                font.pointSize: 15
                color: "black"
            }

            Button {
                id: successOkButton
                anchors.top: successText.bottom
                anchors.left: successText.left
                anchors.right: successText.right
                anchors.topMargin: 30
                anchors.leftMargin: 50
                anchors.rightMargin: 50
                background: Rectangle {
                    id: successOkButtonBackground
                    width: parent.width
                    height: parent.height
                    color: okButton.hovered ? "darkmagenta" : "magenta"
                    radius: 10
                }
                contentItem: Text {
                    id: successOkButtonText
                    text: "Ok"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    name.text = "";
                    surname.text = "";
                    eMail.text = "";
                    password.text = "";
                    userAdmin.text = "";
                    successText.text = "";
                    signUpSuccess.visible = false;
                    signUpButtonClicked();
                }
            }

            function showSuccess() {
                successText.text = "You are registered successfully!";
                visible = true;
            }
        }
    }

    Connections {
        target: user
        onSignUpSuccess: {
           signUpSuccess.showSuccess();
        }
        onSignUpError: {
            signUpError.showError(type);
        }
    }
}
