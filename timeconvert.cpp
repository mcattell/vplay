#include "timeconvert.h"
#include <QDebug>
#include <QTime>

TimeConvert::TimeConvert(QObject *parent)
    : QObject(parent)
    , m_hours(0)
    , m_minutes(0)
    , m_seconds(0)
{


}

void TimeConvert::setMilliseconds(int ms)
{

    QTime t(0,0,0);
    t = t.addMSecs(ms);

    m_hours = t.hour();
    m_seconds = t.second();
    m_minutes = t.minute();

    emit hoursChanged(t.hour());
    emit minutesChanged(t.minute());
    emit secondsChanged(t.second());
}

