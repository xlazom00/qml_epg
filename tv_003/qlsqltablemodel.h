#ifndef QLSQLTABLEMODEL_H
#define QLSQLTABLEMODEL_H

#include <QSqlRelationalTableModel>
#include <QHash>
#include <QModelIndex>

#include <qjsengine.h>
#include <qqml.h>
#include <qqmlinfo.h>

#include <QtCore/qurl.h>
#include <QtCore/qstringlist.h>
#include <QtCore/qabstractitemmodel.h>
#include <private/qv8engine_p.h>

class QLSqlTableModel : public QSqlRelationalTableModel
{
    Q_OBJECT
private:
    QHash<int, QByteArray> roles;
    QHash<int, QString> stringRoles;
    QQmlEngine * m_QmlEngine;

public:
    QLSqlTableModel(QObject *parent = 0,  QQmlEngine * qmlEngine = NULL, QSqlDatabase db = QSqlDatabase());
    Q_INVOKABLE QVariant data(const QModelIndex &index, int role=Qt::DisplayRole ) const;
    Q_INVOKABLE int rowCount() const;
    void generateRoleNames();
    Q_INVOKABLE void setFilter(const QString &filter);
    Q_INVOKABLE QQmlV4Handle get(int index) const;



    virtual QHash<int, QByteArray> roleNames() const{return roles;}
};

#endif // QLSQLTABLEMODEL_H
