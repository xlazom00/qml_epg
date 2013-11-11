#ifndef SQLTABLEMODEL2_H
#define SQLTABLEMODEL2_H

#include <QSqlRelationalTableModel>

#include <QHash>
#include <QSqlDatabase>
#include <QVariant>

//#include <QtCore/qurl.h>
//#include <QtCore/qstringlist.h>
//#include <QtCore/qabstractitemmodel.h>
#include <private/qv8engine_p.h>

class SqlTableModel2: public QSqlRelationalTableModel
{
    Q_OBJECT
public:
    SqlTableModel2(QObject *parent, QSqlDatabase db );
    QVariant data(const QModelIndex &index, int role=Qt::DisplayRole ) const;
    Q_INVOKABLE int rowCount() const;

    //    Q_INVOKABLE void setFilter(const QString &filter);
    Q_INVOKABLE QQmlV4Handle get(int index) const;

    void generateRoleNames();

    virtual QHash<int, QByteArray> roleNames() const{return roles;}

private:
    QHash<int, QByteArray> roles;
    QHash<int, QString> stringRoles;

};

#endif // SQLTABLEMODEL2_H
