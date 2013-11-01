/*
 * Copyright (C) 2010 Canonical, Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef DIRECTORYMODEL_H
#define DIRECTORYMODEL_H

#include <QAbstractListModel>
#include <QDir>
#include <QObject>
#include <qqml.h>
#include <QVariant>

class DirectoryModel : public QAbstractListModel
{  
    Q_OBJECT
    Q_PROPERTY(QString path READ path WRITE setPath)
    Q_PROPERTY(int count READ count NOTIFY countChanged)
    Q_PROPERTY(bool exists READ exists NOTIFY existsChanged)
    Q_ENUMS(RoleNames)

public:
    DirectoryModel(QObject *parent = 0);
//    ~DirectoryModel();

    void setPath(const QString& path);
    QString path() const;
    bool exists() const;
    int count() const { return rowCount(); }

    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    int rowCount(const QModelIndex & parent = QModelIndex()) const;

    virtual QHash<int, QByteArray> roleNames() const{return m_roles;}

    enum RoleNames {
        RoleFileName,
        RoleFilePath,
        RoleIsDirectory
    };

public Q_SLOTS:
    void update();

Q_SIGNALS:
    void countChanged();
    void existsChanged();

protected:
    QString m_path;
    QFileInfoList m_entries;

    QHash<int, QByteArray> m_roles;
};

QML_DECLARE_TYPE(DirectoryModel)

#endif // DIRECTORYMODEL_H
