#ifndef USER_H
#define USER_H

#include <QObject>
#include <QString>

#include "project.h"


class User: public QObject
{
    Q_OBJECT
public:
    explicit User (QObject* parent = nullptr);
    virtual ~User() {};
    Q_INVOKABLE QStringList split(const QString&);
    Q_INVOKABLE QString getName() const;
    Q_INVOKABLE void setName (const QString&);
    Q_INVOKABLE QString getSurname() const;
    Q_INVOKABLE void setSurname(const QString&);
    Q_INVOKABLE void setEmail(const QString&);
    Q_INVOKABLE void setPassword(const QString&);
    Q_INVOKABLE void deleteAccount();
    Q_INVOKABLE QStringList getDevelopers();
    Q_INVOKABLE void setProject(const QString&);
    Q_INVOKABLE QStringList getProjects() const;
    Q_INVOKABLE void setAdminCurrentProject(const QString&);
    Q_INVOKABLE void setSelectedUser(const QString&);
    Q_INVOKABLE void setTask(QString, QString);
    Q_INVOKABLE QStringList getProjectDevelopers();
    Q_INVOKABLE void clearPerformersInfo();
    Q_INVOKABLE void getPerformerInfo(const QString&);
    Q_INVOKABLE void changeTaskStatus(const QString&, const QString&);
    Q_INVOKABLE QString getPosition() const;
    Q_INVOKABLE QStringList getUserTasks();
    Q_INVOKABLE void getAssignorInfo(const QString&);
public slots:
    void loginCheck(const QString&, const QString&);
    void signUpCheck(const QString&, const QString&, const QString&, const QString&, const QString&);
signals:
    void adminLoginSuccess();
    void userLoginSuccess();
    void signUpSuccess();
    void loginError(const QString& type);
    void signUpError(const QString& type);
    void userUpdateError(const QString& type);
    void nameChanged();
    void surnameChanged();
    void eMailChanged(const QString& type);
    void passwordChanged(const QString& type);
    void accountDeleted(const QString& type);
    void projectCreateError(const QString& type);
    void projectCreateSuccess();
    void taskAssignError(const QString& type);
    void taskAssignSuccess();
    void catchPerformerInfo(const QString& type);
    void catchAssignorInfo(const QString& type);
private:
    bool correctName(const QString&, bool, bool);
    bool correctSurname(const QString&, bool, bool);
    bool correctEmail(const QString&, bool, bool);
    bool correctPassword(const QString&, bool, bool);
private:
    QString m_name = "dddddd";
    QString m_surname;
    QString m_eMail;
    QString m_password;
    QString m_position;
    QString m_state;
    QString m_error;
    Project project;
    unsigned long long userId = 0;
};

#endif // USER_H
