import QtQml 2.12
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0



Page {
    id: adminInfoPage
    width: parent.width
    height: parent.height
    visible: false
    title: "My Page"


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
            text: "My Page"
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
            id: position
            anchors.top: parent.top
            height: parent.height / 20
            width: parent.width / 3
            anchors.left: parent.left
            anchors.topMargin: parent.height / 5
            anchors.leftMargin: parent.width / 20
            radius: 20
            color: "magenta"
            Text {
                id: positionText
                anchors.centerIn: parent
                font.pointSize: 12
                text: qsTr("Position")
                color: "white"
            }
        }

        Rectangle {
            id: positionField
            anchors.top: parent.top
            height: position.height
            width: position.width
            anchors.left: position.right
            anchors.topMargin: parent.height / 5
            anchors.leftMargin: 20
            radius: 20
            color: "white"
            border.color: "magenta"
            Text {
                id: positionFieldText
                anchors.centerIn: parent
                font.pointSize: 12
                text: adminInfoPage.activeFocus ? user.getPosition() : ""
                color: "magenta"
            }
        }

        Rectangle {
            id: name
            anchors.top: position.bottom
            height: position.height
            width: position.width
            anchors.left: position.left
            anchors.topMargin: 30
            radius: 20
            color: "magenta"
            Text {
                id: nameText
                anchors.centerIn: parent
                font.pointSize: 12
                text: qsTr("Name")
                color: "white"
            }
        }

        Rectangle {
            id: nameField
            anchors.top: positionField.bottom
            height: position.height
            width: position.width
            anchors.left: name.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            radius: 20
            color: "white"
            border.color: "magenta"
            Text {
                id: nameFieldText
                anchors.centerIn: parent
                font.pointSize: 12
                text:  adminInfoPage.activeFocus ? user.getName() : ""
                color: "magenta"
            }
        }

        TextField {
            id: nameChangeField
            visible: false
            anchors.top: positionField.bottom
            height: position.height
            width: position.width
            anchors.left: name.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            color: "black"
                placeholderText: "New Name"
                font.pointSize: 12
        }

        Button {
            id: nameChangeButton
            anchors.top: position.bottom
            anchors.left: nameField.right
            width: parent.width / 5
            height: position.height
            anchors.topMargin: 30
            anchors.leftMargin: 20
            background: Rectangle{
                id: nameChangeButtonBackground
                height: parent.height
                width: parent.width
                color: nameChangeButton.hovered ? "lightgray" : "white"
                radius: 20
                border.width: 2
                border.color: "darkmagenta"
            }
            contentItem: Text {
                id: nameChangeButtonText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Change")
                font.pointSize: 12
                color: "darkmagenta"
            }
            onClicked: { nameChangeField.visible == true ? user.setName(nameChangeField.text) : nameChangeField.visible = true; }
            }


        Rectangle {
            id: surname
            anchors.top: name.bottom
            height: position.height
            width: position.width
            anchors.left: name.left
            anchors.topMargin: 30
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
            id: surnameField
            anchors.top: name.bottom
            height: position.height
            width: position.width
            anchors.left: surname.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            radius: 20
            color: "white"
            border.color: "magenta"
            Text {
                id: surnameFieldText
                anchors.centerIn: parent
                font.pointSize: 11
                text:  adminInfoPage.activeFocus ? user.getSurname() : ""
                color: "magenta"
            }
        }

        TextField {
            id: surnameChangeField
            visible: false
            anchors.top: nameField.bottom
            height: position.height
            width: position.width
            anchors.left: surname.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            color: "black"
            placeholderText: "New Surname"
            font.pointSize: 12
        }


        Button {
            id: surnameChangeButton
            anchors.top: name.bottom
            anchors.left: surnameField.right
            width: parent.width / 5
            height: position.height
            anchors.topMargin: 30
            anchors.leftMargin: 20
            background: Rectangle{
                id: surnameChangeButtonBackground
                height: parent.height
                width: parent.width
                color: surnameChangeButton.hovered ? "lightgray" : "white"
                radius: 20
                border.width: 2
                border.color: "darkmagenta"
            }
            contentItem: Text {
                id: surnameChangeButtonText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Change")
                font.pointSize: 12
                color: "darkmagenta"
            }
            onClicked: { surnameChangeField.visible == true ? user.setSurname(surnameChangeField.text) : surnameChangeField.visible = true; }

        }

        Rectangle {
            id: eMail
            anchors.top: surname.bottom
            height: position.height
            width: position.width
            anchors.left: name.left
            anchors.topMargin: 30
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
            id: eMailField
            anchors.top: surname.bottom
            height: position.height
            width: position.width
            anchors.left: eMail.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            radius: 20
            color: "white"
            border.color: "magenta"
            Text {
                id: eMailFieldText
                anchors.centerIn: parent
                font.pointSize: 12
                text:  "***@gmail.com"
                color: "magenta"
            }
        }

        TextField {
            id: eMailChangeField
            visible: false
            anchors.top: surnameField.bottom
            height: position.height
            width: position.width
            anchors.left: eMail.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            color: "black"
            placeholderText: "New E-Mail"
            font.pointSize: 12
        }

        Button {
            id: eMailChangeButton
            anchors.top: surname.bottom
            anchors.left: eMailField.right
            width: parent.width / 5
            height: position.height
            anchors.topMargin: 30
            anchors.leftMargin: 20
            background: Rectangle{
                id: eMailChangeButtonBackground
                height: parent.height
                width: parent.width
                color: eMailChangeButton.hovered ? "lightgray" : "white"
                radius: 20
                border.width: 2
                border.color: "darkmagenta"
            }
            contentItem: Text {
                id: eMailChangeButtonText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Change")
                font.pointSize: 12
                color: "darkmagenta"
            }
            onClicked: { eMailChangeField.visible == true ? user.setEmail(eMailChangeField.text) : eMailChangeField.visible = true; }

        }

        Rectangle {
            id: password
            anchors.top: eMail.bottom
            height: position.height
            width: position.width
            anchors.left: name.left
            anchors.topMargin: 30
            radius: 20
            color: "magenta"
            Text {
                id: passwordText
                anchors.centerIn: parent
                font.pointSize: 12
                text: qsTr("Password")
                color: "white"
            }
        }

        Rectangle {
            id: passwordField
            anchors.top: eMail.bottom
            height: position.height
            width: position.width
            anchors.left: eMail.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            radius: 20
            color: "white"
            border.color: "magenta"
            Text {
                id: passwordFieldText
                anchors.centerIn: parent
                font.pointSize: 17
                text:  "•••••••"
                color: "magenta"
            }
        }

        TextField {
            id: passwordChangeField
            visible: false
            anchors.top: eMailField.bottom
            height: position.height
            width: position.width
            anchors.left: password.right
            anchors.topMargin: 30
            anchors.leftMargin: 20
            color: "black"
            echoMode: TextInput.Password
            placeholderText: "New Password"
            font.pointSize: 12
        }


        Button {
            id: passwordChangeButton
            anchors.top: eMail.bottom
            anchors.left: eMailField.right
            width: parent.width / 5
            height: position.height
            anchors.topMargin: 30
            anchors.leftMargin: 20
            background: Rectangle{
                id: passwordChangeButtonBackground
                height: parent.height
                width: parent.width
                color: passwordChangeButton.hovered ? "lightgray" : "white"
                radius: 20
                border.width: 2
                border.color: "darkmagenta"
            }
            contentItem: Text {
                id: passwordChangeButtonText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Change")
                font.pointSize: 12
                color: "darkmagenta"
            }
            onClicked: { passwordChangeField.visible == true ? user.setPassword(passwordChangeField.text) : passwordChangeField.visible = true; }
        }

        Button {
            id: deleteAccountButton
            anchors.top: password.bottom
            anchors.left: eMail.left
            anchors.right: eMailChangeButton.right
            height: position.height
            anchors.topMargin: 30
            background: Rectangle{
                id: deleteAccountButtonBackground
                height: parent.height
                width: parent.width
                color: deleteAccountButton.hovered ? "lightgray" : "white"
                radius: 20
                border.width: 2
                border.color: "darkmagenta"
            }
            contentItem: Text {
                id: deleteAccountButtonText
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: qsTr("Delete Account")
                font.pointSize: 14
                color: "darkmagenta"
            }
            onClicked: { user.deleteAccount(); }
        }
    }

        Rectangle {
            id: updateResult
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
                    updateResult.visible = false;
                }
            }

            function showResult(type) {
                        errorText.text = type;
                        updateResult.visible = true;
                        if (eMailChangeField.visible == true) { eMailChangeField.text = ""; eMailChangeField.visible = false; }
                        else if (passwordChangeField.visible == true) {passwordChangeField.text = ""; passwordChangeField.visible = false; }
                    }

            function changeName() {
                nameFieldText.text = nameChangeField.text;
                nameChangeField.visible = false;
            }

            function changeSurname() {
                surnameFieldText.text = surnameChangeField.text;
                surnameChangeField.visible = false;
            }

            function deleteAccount(type) {
                notificationText.text = type;
                mainWindowNotification.visible = true;
            }


        }


        Connections {
            target: user
            onNameChanged: { updateResult.changeName(); }
            onUserUpdateError: { updateResult.showResult(type); }
            onSurnameChanged: { updateResult.changeSurname(); }
            onEMailChanged: { updateResult.showResult(type); }
            onPasswordChanged: { updateResult.showResult(type); }
            onAccountDeleted: { updateResult.deleteAccount(type); stackView.pop(login); }
        }
}
