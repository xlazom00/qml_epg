#ifndef TVSTREAM_H
#define TVSTREAM_H

#include <QObject>
#include <QString>
#include <QVariant>

class QLSqlTableModel;

class TvStream : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)
//    Q_PROPERTY(QLSqlTableModel * streammodel READ streammodel WRITE setStreammodel)
    Q_PROPERTY(QLSqlTableModel * streammodel READ streammodel CONSTANT)

public:
    TvStream(QObject *parent=0);
    TvStream(const QString & name, QLSqlTableModel * streamModel, QObject *parent=0);
    ~TvStream();
public:
    QLSqlTableModel * streammodel() const;
//    void setStreammodel(QLSqlTableModel * model);

    QString name() const;
    void setName(const QString &name);

signals:
    void nameChanged();
//    void streammodelChanged();


private:
    QLSqlTableModel * m_StreamModel;
    QString m_Name;
};

#endif // TVSTREAM_H
