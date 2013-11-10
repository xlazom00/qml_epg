#ifndef STREAMTABLEMODEL_H
#define STREAMTABLEMODEL_H

#include "qlsqltablemodel.h"

#include <QDateTime>

class StreamTableModel : public QLSqlTableModel
{
    Q_OBJECT
public:
    explicit StreamTableModel(QObject *parent, QQmlEngine * qmlEngine, QSqlDatabase db, int streamId);

    Q_INVOKABLE void setFrom(int startTime, int duration );

    Q_INVOKABLE QDateTime toDate(int time);


signals:

public slots:

private:
    int m_StreamId;

};

#endif // STREAMTABLEMODEL_H
