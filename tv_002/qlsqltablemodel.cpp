#include <QString>
#include <QVariant>
#include <QSqlTableModel>
#include <QSqlRelationalTableModel>
#include <QSqlRecord>
#include <QDebug>

#include "qlsqltablemodel.h"

QLSqlTableModel::QLSqlTableModel(QObject *parent, QSqlDatabase db)
    : QSqlRelationalTableModel(parent, db)
{
}

void QLSqlTableModel::setFilter(const QString &filter)
{
    QSqlRelationalTableModel::setFilter(filter);
//    bool ret = select();
//    qDebug() << ret;
}

QVariant QLSqlTableModel::data ( const QModelIndex & index, int role ) const
{
    if(index.row() >= rowCount())
    {
        return QString("");
    }

    if(role < Qt::UserRole)
    {
        QVariant data = QSqlQueryModel::data(index, role);
//        qDebug() << data;
        return data;
    }
    else {
        // search for relationships
        for (int i = 0; i < columnCount(); i++) {
            if (this->relation(i).isValid()) {
                return record(index.row()).value(QString(roles.value(role)));
            }
        }
        // if no valid relationship was found
        QVariant data = QSqlQueryModel::data(this->index(index.row(), role - Qt::UserRole - 1), Qt::DisplayRole);
//        qDebug() << data;
        return data;
    }
}

void QLSqlTableModel::generateRoleNames()
{
    roles.clear();
    int nbCols = this->columnCount();
    for (int i = 0; i < nbCols; i++) {
            roles[Qt::UserRole + i + 1] = QVariant(this->headerData(i, Qt::Horizontal).toString()).toByteArray();

    }
//#ifndef HAVE_QT5
//    setRoleNames(roles);
//#endif
}
