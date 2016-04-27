#include "timeconvert.h"
#include <QDebug>
#include <QTime>

TimeConvert::TimeConvert(QObject *parent)
    : QObject(parent)


{


}

void TimeConvert::setMilliseconds(int ms, int type)
{

    QTime t(0,0,0);

    if (ms > 0)
        t = t.addMSecs(ms);

    QString converted = t.toString("HH:mm:ss");
    QString shortForm = QString("%1:%2").arg(t.minute(),2,'0').arg(t.second(),2,'0');

    switch (type) {

    case CurrentTime :

        if (m_hasHour)
            m_currentTime = converted;
        else
            m_currentTime = shortForm;
        emit currentTimeChanged(m_currentTime);
        break;

    case TotalTime :
        if (t.hour() > 0)
            m_hasHour = true;
        if (m_hasHour)
            m_totalTime = converted;
        else
            m_totalTime = shortForm;
        emit totalTimeChanged(m_totalTime);
        break;

    default: break;
    }
}

