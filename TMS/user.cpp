#include <QFile>
#include <QTextStream>

#include "user.h"
#include "project.h"

User::User(QObject* parent): QObject(parent) {}

QStringList User::split(const QString& str) {
    int length = str.length();
    QStringList arr;
    QString word;

    for (int i = 0; i < length; ++i) {
        if (str[i] != ' ') { word += str[i]; continue; }
        if (word.length()) { arr.push_back(word); word = "";}
    }
    if (word.length()) { arr.push_back(word); }

    return arr;
}

bool User::correctName(const QString& name, bool check, bool change) {
    const int dataSize = 15;
    int inputSize = name.size();

    if (check && (inputSize > dataSize || inputSize < 3)) { m_error = "Name must contain from 3 to 15 letters!"; return false; }

    for (int i = 0; i < inputSize && check; ++i) {
        if ((name[i] < 'a' || name[i] > 'z') && (name[i] < 'A' || name[i] > 'Z')) { m_error = "Name must contain only letters!"; return false; }
    }

    if (inputSize <= dataSize && change) {
        m_name = name;
       for (int i = inputSize; i < dataSize; ++i) { m_name += ' '; }
    }
    return true;
}

bool User::correctSurname(const QString& surname,bool check, bool change) {
    const int dataSize = 20;
    int inputSize = surname.size();

    if (check && (inputSize > dataSize || inputSize < 3)) { m_error = "Surname must contain from 3 to 20 letters!"; return false; }

    for (int i = 0; i < inputSize && check; ++i) {
        if ((surname[i] < 'a' || surname[i] > 'z') && (surname[i] < 'A' || surname[i] > 'Z')) { m_error = "Surname must contain only letters!"; return false; }
    }

    if (inputSize <= dataSize && change) {
        m_surname = surname;
       for (int i = inputSize; i < dataSize; ++i) { m_surname += ' '; }
    }
    return true;
}

bool User::correctEmail(const QString& eMail, bool check, bool change){
    const int dataSize = 30;
    int inputSize = eMail.size();

    if (!inputSize) { m_error = "The E-Mail field is required!"; return false; }
    if (eMail.mid(inputSize - 10).toLower() != "@gmail.com" || inputSize < 11) { m_error = "Incorrect E-Mail!"; return false; }
    if (check && (inputSize > dataSize)) { m_error = "E-Mail can contain maximum 30 characters!"; return false; }
    if (eMail.contains(' ')) { m_error = "Don't use white spaces in E-Mail!"; return false; }

    if (inputSize <= dataSize && change) {
        m_eMail = eMail.toLower();
       for (int i = inputSize; i < dataSize; ++i) { m_eMail += ' '; }
    }
    return true;
}

bool User::correctPassword(const QString& password, bool check, bool change) {
    const int dataSize = 12;
    int inputSize = password.length();

    if (check && !inputSize) { m_error = "The Password field is required!"; return false; }
    if (check && (inputSize > 12 || inputSize < 7)) { m_error = "Password can contain from 7 to 12 characters!"; return false; }
    if (password.contains(' ')) { m_error = "Don't use white spaces in password!"; return false; }


    if (inputSize <= dataSize && change) {
        m_password = password;
        for (int i = inputSize; i < dataSize; ++i) { m_password += ' '; }
    }
    return true;
}

void User::loginCheck(const QString& eMail,const QString& password) {

    if (!correctEmail(eMail, true, true) || !correctPassword(password, true, false)) { emit loginError(m_error); return; }
    const int eMailIndex = 37;
    const int passwordIndex = 68;
    const int stateIndex = 87;
    int inputEmailSize = eMail.length();
    m_eMail = eMail.toLower();

    QFile file("user.data");
    if (!file.open(QIODevice::ReadWrite)) { emit loginError("Connection error. Try later!"); return; }

    QTextStream read(&file);
    QString line;
    QString data;

    while (!read.atEnd()) {
        line = read.readLine();
        if (line.mid(eMailIndex, inputEmailSize) == m_eMail) {
            if (line.mid(stateIndex, 7) == "deleted") { emit loginError("Wrong E-Mail or Password"); return; }
            data = line;
        }
    }
    if (data.mid(passwordIndex, password.length()) != password || !data.length()) { emit loginError("Wrong E-Mail  and/or  Password!"); return; }

    QStringList arr = data.split(u' ', QString::SkipEmptyParts);
    m_name = arr[0];
    m_surname = arr[1];
    m_password = arr[3];
    m_position = arr[4];
    m_state = arr[5];
    userId = arr[6].toULongLong();

    m_position == "admin" ? emit adminLoginSuccess() : emit userLoginSuccess();

    file.close();
}

void User::signUpCheck(const QString& name, const QString& surname, const QString& eMail, const QString& password, const QString& position) {
    if (!correctName(name, true, true) || !correctSurname(surname, true, true) || !correctEmail(eMail, true, true) || !correctPassword(password, true, true)) { emit signUpError(m_error); return; }
    if (position.toUpper() != "USER" && position.toUpper() != "ADMIN") { emit signUpError("Incorrect User/Admin field!"); return; }

    QFile file("user.data");
    if (!file.open(QIODevice::ReadWrite)) { emit signUpError("Connection error. Try later!"); return; }

    QTextStream readWrite(&file);
    QString line;
    const int eMailIndex = 37;
    int inputSize = eMail.length();
    const int userIdIndex = 98;

    while (!readWrite.atEnd()) {
        line = readWrite.readLine();
        if (line.mid(eMailIndex, inputSize)  == eMail) { emit signUpError("E-Mail already exists!");  file.close(); return; }
        if (userId <= line.midRef(userIdIndex).toULongLong()) { userId = line.midRef(userIdIndex).toULongLong();  ++userId; }
    }
    position.toLower() == "user" ? m_position = position.toLower() + ' ' : m_position = position.toLower();
    m_position == "user " ? m_state = "activUser " : m_state = "activAdmin";

    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position.toLower() + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    file.close();
    m_name = ""; m_surname = ""; m_eMail = ""; m_password = ""; m_position = ""; userId = 0;
   emit signUpSuccess();

}

QString User::getPosition() const {
    if (m_position == "admin") { return "Administator"; }

    return "Developer";
}

QString User::getName() const {
    return m_name;
}

void User::setName (const QString& name) {
    if (m_name == name) { emit nameChanged(); return; }
    if (!correctName(name, true, true)) { emit userUpdateError(m_error); return; }

    QFile file("user.data");
    if (!file.open(QIODevice::Append)) { emit userUpdateError("Connection error. Try later!"); return; }
    emit nameChanged();
    QTextStream readWrite(&file);

    correctSurname(m_surname, false, true);
    correctEmail(m_eMail, false, true);
    correctPassword(m_password, false, true);
    if (m_position.length() == 4) { m_position += ' '; m_state += ' '; }


    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    file.close();
}

QString User::getSurname () const {
    return m_surname;
}

void User::setSurname(const QString& surname) {
    if (m_surname == surname) { emit surnameChanged(); return; }
    if (!correctSurname(surname, true, true)) { emit userUpdateError(m_error); return; }

    QFile file("user.data");
    if (!file.open(QIODevice::Append)) { emit userUpdateError("Connection error. Try later!"); return; }
    emit surnameChanged();
    QTextStream readWrite(&file);

    correctName(m_name, false, true);
    correctEmail(m_eMail, false, true);
    correctPassword(m_password, false, true);
    if (m_position.length() == 4) { m_position += ' '; m_state += ' ';}

    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    file.close();
}

void User::setEmail(const QString& eMail) {
    if (m_eMail == eMail.toLower()) { emit eMailChanged("Your E-Mail successfully changed!"); return; }
    if (!correctEmail(eMail, true, false)) { emit userUpdateError(m_error); return; }

    QString line;
    const int eMailIndex = 37;
    int inputSize = eMail.length();


    QFile file("user.data");
    if (!file.open(QIODevice::ReadWrite)) { emit userUpdateError("Connection error. Try later!"); return; }
    QTextStream readWrite(&file);

    while (!readWrite.atEnd()) {
        line = readWrite.readLine();
        if (line.mid(eMailIndex, inputSize)  == eMail) { emit userUpdateError("E-Mail already exists!");  file.close(); return; }
    }

    emit eMailChanged("Your E-Mail successfully changed!");

    correctName(m_name, false, true);
    correctSurname(m_surname, false, true);
    correctPassword(m_password, false, true);
    if (m_position.length() == 4) { m_position += ' '; }
    correctEmail(m_eMail, false, true);
    m_state = "deleted   ";

    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    correctEmail(eMail, false, true);

    m_position == "user " ? m_state = "activUser " : m_state = "activAdmin";

    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    file.close();

}

void User::setPassword(const QString& password) {
    if (m_password == password) { emit passwordChanged("Your password successfully changed!"); return; }
    if (!correctPassword(password, true, true)) { emit userUpdateError(m_error); return; }

    QFile file("user.data");
    if (!file.open(QIODevice::Append)) { emit userUpdateError("Connection error. Try later!"); return; }
    emit passwordChanged("Your password successfully changed!");
    QTextStream readWrite(&file);

    correctName(m_name, false, true);
    correctSurname(m_surname, false, true);
    correctEmail(m_eMail, false, true);
    if (m_position.length() == 4) { m_position += ' '; m_state += ' '; }

    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    file.close();

}

void User::deleteAccount() {
    correctName(m_name, false, true);
    correctSurname(m_surname, false, true);
    correctEmail(m_eMail, false, true);
    correctPassword(m_password, false, true);
    if (m_position.length() == 4) { m_position += ' '; }
    m_state = "deleted   ";

    QFile file("user.data");
    if (!file.open(QIODevice::Append)) { emit userUpdateError("Connection error. Try later!"); return; }
    QTextStream readWrite(&file);

    readWrite << m_name + ' ' + m_surname + ' ' + m_eMail + ' ' + m_password + ' ' + m_position + ' ' + m_state + ' ' + QString::number(userId) +'\n';

    file.close();

    emit accountDeleted("Your account is deleted!\n We wish You success!");
}

QStringList User::getDevelopers() {
    QStringList arr;
    QString line;
    const int stateIndex = 87;

    QFile file("user.data");
    file.open(QIODevice::ReadOnly);
    QTextStream readWrite(&file);

    int length = arr.length();
    QString tmp;

    while (!readWrite.atEnd()) {
        line = readWrite.readLine();
            if (line.mid(stateIndex, 7) == "deleted") {
                tmp = line.mid(98);
                for (int i = 0; i < length; ++i) {
                    if (arr[i].mid(98) == line) { arr[i] = "";  continue; }
                }
            }
            else if (line.mid(stateIndex, 9) == "activUser") {
                bool same = false;
                tmp = line.mid(98);
                for (int i = 0; i < length; ++i) {
                    if (arr[i].mid(98) == tmp) {  same = true; arr[i] = line; }
                }
                if(!same) { arr.push_back(line); ++length; }
            }
    }
    file.close();

    return arr;
}

QStringList User::getProjects() const {
    return project.getProjects(QString::number(userId));
}

void User::setProject(const QString& projectName) {
    QString adminId = QString::number(userId);
    m_error = project.setProject(adminId, projectName);

    if (m_error != "success") { emit projectCreateError(m_error); return; }

    emit projectCreateSuccess();
}

void User::setSelectedUser(const QString& userEmail) {
    const int eMailIndex = 37;
    const int userIdIndex = 98;

    QString line;
    int size = userEmail.length();

    QFile file("user.data");
    file.open(QIODevice::ReadOnly);
    QTextStream read(&file);

    while(!read.atEnd()) {
        line = read.readLine();
        if (line.midRef(eMailIndex, size) == userEmail) { file.close(); project.setSelectedUserId(line.mid(userIdIndex)); return; }
    }

    file.close();
}

void User::setTask(QString projectName, QString taskName) {
    QString adminId = QString::number(userId);
    m_error = project.setTask(adminId, projectName, taskName);

    if (m_error != "success") { emit taskAssignError(m_error); return; }

    emit taskAssignSuccess();
}

void User::setAdminCurrentProject(const QString& projectName) {
    project.setCurrentProjectName(projectName);
}

QStringList User::getProjectDevelopers() {
    return project.getProjectDevelopers(QString::number(userId));
}

void User::clearPerformersInfo() {
    project.clearProjectPerformers();
}

void User::getPerformerInfo(const QString& taskName) {
    QString userId = project.getPerformer(taskName);
    QString line;
    QString data;
    const int userIdIndex =98;
    int userIdSize = userId.length();

    QFile file("user.data");
    file.open(QIODevice::ReadOnly);
    QTextStream read(&file);

    while (!read.atEnd()) {
        line = read.readLine();
        if (line.midRef(userIdIndex,userIdSize) == userId) { data = line; }
    }

    emit catchPerformerInfo(data);
    file.close();
}

void User::changeTaskStatus(const QString& taskName, const QString& status) {
    project.changeTaskStatus(taskName, status);
}

QStringList User::getUserTasks() {
    return project.getUserTasks(QString::number(userId));
}

void User::getAssignorInfo(const QString& adminId) {
    const int adminIdIndex = 98;
    int adminIdSize = adminId.length();

    QFile file("user.data");
    file.open(QIODevice::ReadOnly);
    QTextStream read(&file);
    QString line;
    QString data;

    while (!read.atEnd()) {
        line = read.readLine();

        if (line.midRef(adminIdIndex, adminIdSize) == adminId) {
            data = line;
        }
    }

    emit catchAssignorInfo(data);
}
























