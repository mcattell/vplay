#ifndef TIMECONVERT_H
#define TIMECONVERT_H

#include <QObject>


class TimeConvert : public QObject
{
    Q_OBJECT

    Q_PROPERTY(int hours MEMBER m_hours NOTIFY hoursChanged)
    Q_PROPERTY(int minutes MEMBER m_minutes NOTIFY minutesChanged)
    Q_PROPERTY(int seconds MEMBER m_seconds NOTIFY secondsChanged)

public:
    explicit TimeConvert(QObject *parent = 0);

signals:
    void hoursChanged(int hours);
    void minutesChanged(int minutes);
    void secondsChanged(int seconds);

public slots:
    void setMilliseconds(int ms);

private:


    int m_hours;
    int m_minutes;
    int m_seconds;

    int m_previous;
};

#endif // TIMECONVERT_H
