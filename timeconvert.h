#ifndef TIMECONVERT_H
#define TIMECONVERT_H

#include <QObject>
#include <QtQml>

class TimeConvert : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString totalTime MEMBER m_totalTime NOTIFY totalTimeChanged)
    Q_PROPERTY(QString currentTime MEMBER m_currentTime NOTIFY currentTimeChanged)

public:

    Q_ENUMS(TimeDisplayType)

    enum TimeDisplayType {
        CurrentTime,
        TotalTime
    };

    explicit TimeConvert(QObject *parent = 0);

    static void declareQML() {
        qmlRegisterType<TimeConvert>("com.vplay.qmltypes", 1, 0, "TimeDisplayType");
    }

signals:
    void totalTimeChanged(QString total);
    void currentTimeChanged(QString current);

public slots:
    void setMilliseconds(int ms, int type);

private:

    QString m_totalTime, m_currentTime;
    bool m_hasHour;
};

#endif // TIMECONVERT_H
