
#include "streamtablemodel2.h"

StreamTableModel2::StreamTableModel2(QObject * parent, QSqlDatabase db) :
    SqlTableModel2(parent,  db), m_StreamId(-1)
{

}

StreamTableModel2::StreamTableModel2(QObject *parent, QSqlDatabase db, int streamId) :
    SqlTableModel2(parent, db), m_StreamId(streamId)
{
}

void StreamTableModel2::setFrom(int startTime, int duration )
{
//    setFilter(QString("(streamid=%1) AND (startime > %2)").arg(m_StreamId).arg(startTime) );
    setTable("event");
    generateRoleNames();
    setFilter(QString("(streamid=%1) AND (startime BETWEEN %2 AND %3)").arg(m_StreamId).arg(startTime).arg(startTime + duration) );
    bool ret = select();
    if(!ret){
        qDebug() << "select failed";
    }
}

QDateTime StreamTableModel2::toDate(int time)
{
    qint64 timeMs = ((qint64)time * 1000ll);
    return QDateTime::fromMSecsSinceEpoch(timeMs);
}
