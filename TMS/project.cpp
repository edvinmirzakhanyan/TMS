#include <QFile>
#include <QTextStream>

#include "project.h"


Project::Project(QObject* parent): QObject(parent) {}

void Project::addWs(QString& data, const int index, const int size) {
    for (int i = data.length() + index; i < size; ++i) { data += ' '; }
}

bool Project::correctProjectName(const QString& projectName) {
    const int dataSize = 20;
    int inputSize = projectName.length();

    if (inputSize > dataSize || inputSize < 3) { m_error = "Project name must contain from 3 to 20 characters!"; return false; }
    if (projectName.contains(' ')) { m_error = "Use underscores instead of white spaces in project name!"; return false; }

    m_projectName = projectName;
    return true;
}

bool Project::correctTaskName(const QString& taskName) {
    const int dataSize = 20;
    int inputSize = taskName.length();

    if (inputSize > dataSize || inputSize < 3) { m_error = "Task name name must contain from 3 to 20 characters!"; return false; }
    if (taskName.contains(' ')) { m_error = "Use underscores instead of white spaces in task name!"; return false; }

    m_taskName = taskName;
    return true;
}


QStringList Project::getProjects(const QString& adminId) const {
    QStringList arr;
    QString line;
    int idLength = adminId.length();

    QFile file("projects.data");
    file.open(QIODevice::ReadWrite);
    QTextStream read(&file);

    int i = 0;
    while (!read.atEnd()) {
       line = read.readLine();
       if (line.mid(adminIdIndex,idLength) == adminId) {
           arr.push_back(line.mid(projectNameIndex, 20));
           arr[i] = arr[i].trimmed();
           ++i;
       }
    }

    file.close();

    return arr;
}

QString Project::setProject(QString& adminId, const QString& projectName) {
    if (!correctProjectName(projectName)) { return m_error; }

    int adminIdSize = adminId.length();
    int projectNameSize = projectName.length();

    QString line;
    QFile file("projects.data");
    file.open(QIODevice::ReadWrite);
    QTextStream readWrite(&file);

    while (!readWrite.atEnd()) {
        line = readWrite.readLine();
        if (line.midRef(adminIdIndex, adminIdSize) == adminId && line.midRef(projectNameIndex, projectNameSize) == projectName)
        { file.close(); return "Project already exists!"; }
    }
    addWs(adminId, adminIdIndex, projectNameIndex);
    addWs(m_projectName, projectNameIndex, userIdIndex);

    readWrite << adminId + m_projectName + '\n';

    return "success";
}

void Project::setSelectedUserId(const QString& userId) {
    m_userId = userId;
}

QString Project::setTask(QString& adminId, QString& projectName, QString& taskName) {
    if (!correctTaskName(taskName)) { return m_error; }

    QString line;
    int adminIdSize = adminId.length();
    int projectNameSize = projectName.length();
    int taskNameSize = taskName.length();
    bool projectFound = false;

    QFile searchProject("projects.data");
    searchProject.open(QIODevice::ReadOnly);
    QTextStream read(&searchProject);

    while (!read.atEnd()) {
        line = read.readLine();
        if (line.midRef(adminIdIndex, adminIdSize) == adminId && line.midRef(projectNameIndex, projectNameSize) == projectName) { projectFound = true; break; }
    }

    if (projectFound) {
        QFile taskAppend("projects&tasks.data");
        taskAppend.open(QIODevice::ReadWrite);
        QTextStream append(&taskAppend);

        while (!taskAppend.atEnd()) {
            line = taskAppend.readLine();
            if (line.midRef(adminIdIndex, adminIdSize) == adminId && line.mid(projectNameIndex, projectNameSize) == projectName
            && line.midRef(taskNameIndex, taskNameSize) == taskName) { taskAppend.close(); return "In this project already exists this task!"; }
            }
        m_status = "Progressing";
        addWs(adminId, adminIdIndex, projectNameIndex);
        addWs(projectName, projectNameIndex, userIdIndex);
        addWs(m_userId, userIdIndex, taskNameIndex);
        addWs(taskName, taskNameIndex, statusIndex);

        append << adminId + projectName + m_userId + taskName + m_status + '\n';
        return "success";

        taskAppend.close();
    }
    return "Project not found!";
}

void Project::setCurrentProjectName(const QString& projectName) {
    m_projectName = projectName;
}

QStringList Project::getProjectDevelopers(const QString& adminId) {
    QFile file("projects&tasks.data");
    file.open(QIODevice::ReadOnly);
    QTextStream read(&file);
    QString line;

    int adminIdSize = adminId.length();
    int projectSize = m_projectName.length();

    while (!read.atEnd()) {
        line = read.readLine();
        if (line.midRef(adminIdIndex, adminIdSize) == adminId && line.midRef(projectNameIndex, projectSize) == m_projectName) {
            bool same = false;
            for (int i = 0; i < projectPerformers.length(); ++i) {
                if (projectPerformers[i].midRef(taskNameIndex, 20) == line.midRef(taskNameIndex, 20)) { projectPerformers[i] = line; same = true; break; }
            }
            if(!same) { projectPerformers.push_back(line); }
        }
    }
    file.close();

    return projectPerformers;
}

void Project::clearProjectPerformers() {
    projectPerformers.clear();
}

QString Project::getPerformer(const QString& taskName) {
    int size = projectPerformers.length();
    int taskNameSize = taskName.length();

    for (int i = 0; i < size; ++i) {
        if (projectPerformers[i].midRef(taskNameIndex, taskNameSize) == taskName) { return projectPerformers[i].mid(userIdIndex,20).trimmed(); }
    }
    return "";
}

void Project::changeTaskStatus(const QString& taskName, QString status) {
    int taskNameSize = taskName.length();
    int size = projectPerformers.length();

    QFile taskAppend("projects&tasks.data");
    taskAppend.open(QIODevice::Append);
    QTextStream append(&taskAppend);

    for (int i = 0; i < size; ++i) {
        if (projectPerformers[i].midRef(taskNameIndex, taskNameSize) == taskName) {
            projectPerformers[i].resize(statusIndex);
            append << projectPerformers[i] + status +'\n';
            taskAppend.close();
            return;
        }
    }
}

QStringList Project::getUserTasks(const QString& userId) {
    QFile file("projects&tasks.data");
    file.open(QIODevice::ReadOnly);
    QTextStream read(&file);
    QString line;

    int userIdSize = userId.length();


    while (!read.atEnd()) {
        line = read.readLine();
        if (line.midRef(userIdIndex, userIdSize) == userId) {
            bool same = false;
            for (int i = 0; i < projectPerformers.length(); ++i) {
                if (projectPerformers[i].midRef(adminIdIndex, statusIndex - 1) == line.midRef(adminIdIndex, statusIndex - 1)) {
                    projectPerformers[i].resize(statusIndex);
                    projectPerformers[i] += line.midRef(statusIndex);
                    same = true;
                    break;
                }
            }
            if (!same) { projectPerformers.push_back(line); }
        }
    }

    return projectPerformers;
}




























