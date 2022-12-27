import QtQuick 2.6
import QtQuick.Window 2.12
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQml 2.12


Page {
    id: loginPage
    width: parent.width
    height: parent.height
    visible: true
    title: "Login"

    signal signUpButtonClicked();
    signal adminLoginButtonClicked();
    signal userLoginButtonClicked();

    header: ToolBar {
        height: 50
        background: Rectangle {
            anchors.fill: parent
            color: "transparent"
        }
        Text {
            id: toolButtonText
            anchors.centerIn: parent
            text: "Sign in"
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
        height: parent.height / 2
        anchors.top: logo.bottom
        anchors.left: parent.left
        anchors.topMargin: 50
        width: parent.width / 2
        anchors.leftMargin: parent.width / 4
        color: "transparent"

        TextField {
            id: eMail
            height: parent.height / 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 10
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            placeholderText: "E-Mail"
            background: Rectangle {
                id: eMailBorder
                height: 1
                anchors.bottom: parent.bottom
                color: "magenta"
            }
        }

        TextField {
            id: password
            height: parent.height / 10
            anchors.top: eMail.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 30
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            placeholderText: "Password"
            echoMode: TextInput.Password
            background: Rectangle {
                id:passwordBorder
                height: 1
                anchors.bottom: parent.bottom
                color: "magenta"
            }
        }

        Button {
            id: loginButton
            height: parent.height / 10
            anchors.top: password.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.leftMargin: 100
            anchors.topMargin: 40
            background: Rectangle {
                id: loginButtonBackground
                width: parent.width
                height: parent.height
                color: loginButton.hovered ? "darkmagenta" : "magenta"
                radius: 10
            }
            contentItem: Text {
                id: loginButtonText
                text: qsTr("Sign in")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "white"
            }
            onClicked: {
                user.loginCheck(eMail.text, password.text);
                //stackView.push(adminGeneralPage);
            }
        }
        Button {
            id: signUpButton
            height: parent.height / 10
            anchors.top: loginButton.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.leftMargin: 100
            anchors.topMargin: 10
            background: Rectangle {
                id: signUpButtonBackground
                width: parent.width
                height: parent.height
                color: signUpButton.hovered ? "lightgray" : "white"
                border.color: "magenta"
                radius: 10
            }
            contentItem: Text {
                id: userSignUpButtonText
                text: qsTr("Sign up")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: "magenta"
            }
            onClicked: {
                loginPage.signUpButtonClicked();
            }
        }
    }

        Rectangle {
            id: loginError
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
                    id: okButtonText
                    text: "Ok"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    errorText.text = "";
                    loginError.visible = false;
                }
            }

            function showError(type) {
                errorText.text = type;
                visible = true;
            }
        }

    }
        Connections {
            target: user
            onAdminLoginSuccess: {
                loginPage.adminLoginButtonClicked();
                eMail.text = "";
                password.text = "";
            }
            onUserLoginSuccess: {
                loginPage.userLoginButtonClicked();
                eMail.text = "";
                password.text = "";
            }

            onLoginError: {
                loginError.showError(type);
            }
        }
}
