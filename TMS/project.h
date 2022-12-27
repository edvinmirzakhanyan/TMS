#ifndef PROJECT_H
#define PROJECT_H

#include <QString>
#include <QObject>



class Project: public QObject
{
    Q_OBJECT
public:
    explicit Project (QObject* parent = nullptr);
    virtual ~Project() {};
    void setSelectedUserId(const QString&);
    QString setProject(QString&, const QString&);
    QString setTask(QString&, QString&, QString&);
    QStringList getProjects(const QString&) const;
    QStringList getProjectTasks(const QString&, const QString&);
    QStringList getUserTasks(const QString&);
    void chnageStatus();
    void setCurrentProjectName(const QString&);
    QStringList getProjectDevelopers(const QString&);
    void clearProjectPerformers();
    QString getPerformer(const QString&);
    void changeTaskStatus(const QString&, QString);
private:
    void addWs(QString&,const int, const int);
    bool correctProjectName(const QString&);
    bool correctTaskName(const QString&);
private:
    QStringList projectPerformers;
    QString m_projectName;
    QString m_taskName;
    QString m_userId;
    QString m_status;
    QString m_adminId;
    QString m_error;
    const int adminIdIndex = 0;
    const int projectNameIndex = 25;
    const int userIdIndex = 50;
    const int taskNameIndex = 75;
    const int statusIndex = 100;
};

#endif // PROJECT_H
