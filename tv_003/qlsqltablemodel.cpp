#include <QString>
#include <QVariant>
#include <QSqlTableModel>
#include <QSqlRelationalTableModel>
#include <QSqlRecord>
#include <QDebug>
#include <qqmlcontext.h>

#include <qqmlcontext.h>
#include <private/qqmlengine_p.h>
#include <private/qv8engine_p.h>
#include <private/qv4value_p.h>
#include <private/qv4engine_p.h>
#include <private/qv4object_p.h>

#include "qlsqltablemodel.h"

using namespace QV4;
using namespace QtQml;

QLSqlTableModel::QLSqlTableModel(QObject *parent, QQmlEngine * qmlEngine, QSqlDatabase db )
    : QSqlRelationalTableModel(parent, db), m_QmlEngine(qmlEngine)
{
}

int QLSqlTableModel::rowCount() const
{
    return QSqlTableModel::rowCount();
}

void QLSqlTableModel::setFilter(const QString &filter)
{
    QSqlRelationalTableModel::setFilter(filter);
//    bool ret = select();
//    qDebug() << ret;
}

QVariant QLSqlTableModel::data ( const QModelIndex & index, int role ) const
{
//    qDebug() << index.column() << " " << index.row();
    if(index.row() >= rowCount())
    {
        return QString("");
    }

    if(role < Qt::UserRole)
    {
        QVariant data = QSqlQueryModel::data(index, role);
//        qDebug() << "role:" << role << " " << data;
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
//        qDebug() << "role:" << role << " " << data;
        return data;
    }
}

QQmlV4Handle QLSqlTableModel::get(int rowIndex) const
{
    // Must be called with a context and handle scope
//    Q_D(const QQuickXmlListModel);

    if (rowIndex < 0 || rowIndex >= rowCount())
        return QQmlV4Handle(Encode::undefined());

//    QQmlEngine *engine = qmlContext(this)->engine();
//    QV8Engine *v8engine = QQmlEnginePrivate::getV8Engine(engine);
    QV8Engine *v8engine = QQmlEnginePrivate::getV8Engine(m_QmlEngine);
    ExecutionEngine *v4engine = QV8Engine::getV4(v8engine);
    Scope scope(v4engine);
    Scoped<Object> o(scope, v4engine->newObject());
//    for (int ii = 0; ii < d->roleObjects.count(); ++ii) {
//        ScopedString name(scope, v4engine->newIdentifier(d->roleObjects[ii]->name()));
//        Property *p = o->insertMember(name, PropertyAttributes());
//        p->value = v8engine->fromVariant(d->data.value(ii).value(index));
//    }

    QHash<int, QString>::const_iterator it = stringRoles.begin();
    while (it != stringRoles.end()) {
        ScopedString name(scope, v4engine->newIdentifier(it.value()));
        Property *p = o->insertMember(name, PropertyAttributes());

        int column(it.key() - Qt::UserRole - 1);
        QModelIndex modelIndex(this->index(rowIndex, column));
        QVariant res = data(modelIndex);
//        QVariant data = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
        qDebug() << "val:" << it.value() << " column:" << column  << " column" << modelIndex.column() << " row:" << modelIndex.row();
        qDebug() << res;
        p->value = v8engine->fromVariant(res);
        ++it;
    }

    return QQmlV4Handle(o);
}

void QLSqlTableModel::generateRoleNames()
{
    roles.clear();
    stringRoles.clear();
    int nbCols = this->columnCount();
    for (int i = 0; i < nbCols; i++) {
            roles[Qt::UserRole + i + 1] = QVariant(this->headerData(i, Qt::Horizontal).toString()).toByteArray();
            stringRoles[Qt::UserRole + i + 1] = this->headerData(i, Qt::Horizontal).toString();
    }
//#ifndef HAVE_QT5
//    setRoleNames(roles);
//#endif
}
