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

#include "directorymodel.h"

//#include "config.h"

#include <QDebug>
#include <QFileInfo>

DirectoryModel::DirectoryModel(QObject *parent) :
    QAbstractListModel(parent)
{
    m_roles[DirectoryModel::RoleFileName] = "name";
    m_roles[DirectoryModel::RoleFilePath] = "path";
    m_roles[DirectoryModel::RoleIsDirectory] = "isDirectory";
}

//DirectoryModel::~DirectoryModel()
//{
//}

int DirectoryModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)

    return m_entries.size();
}

QVariant DirectoryModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    QFileInfo info = m_entries.at(index.row());
    switch (role) {
    case DirectoryModel::RoleFileName:
        return QVariant::fromValue(info.fileName());
    case DirectoryModel::RoleFilePath:
        return QVariant::fromValue(info.canonicalFilePath());
    case DirectoryModel::RoleIsDirectory:
        return QVariant::fromValue(info.isDir());
    default:
        qWarning() << "Requested invalid role (index" << role << ")";
        return QVariant();
    }
}

void DirectoryModel::update()
{
    int oldCount = m_entries.count();
    if (m_entries.count() > 0) {
        beginRemoveRows(QModelIndex(), 0, m_entries.count() - 1);
        m_entries.clear();
        endRemoveRows();
    }

    QDir directory(m_path);
    if (!directory.exists()) {
        return;
    }

    // FIXME: this is not ideal since we get the list of entries and store it internally,
    // but when asking for details in data() the data is gathered live. If the file is gone
    // in the meantime the results will be bogus. Ideally we should gather all info in a list of
    // custom objects and use these for data(). Or use a QFileSystemWatcher to keep everything up
    // to date.
    QFileInfoList entries;
    entries = directory.entryInfoList(QStringList(), QDir::AllEntries | QDir::NoDotAndDotDot);
    beginInsertRows(QModelIndex(), 0, entries.count());
    m_entries = entries;
    endInsertRows();

    if (m_entries.count() != oldCount) {
        Q_EMIT countChanged();
    }
}

QString DirectoryModel::path() const
{
    return m_path;
}

void DirectoryModel::setPath(const QString &path)
{
    // Make sure we expand ~ to home dir and canonicalize the path so we can compare
    // properly with the path we are currently using.
    QString fixedPath = path;
    if (path == "~" || path.startsWith("~/")) {
        fixedPath = QDir::homePath() + fixedPath.right(fixedPath.length() - 1);
    } else if (path.startsWith("unity-2d:")) {
        // Special prefix unity-2d: will be replaced with the unity-2d installation dir
        // or source dir if running uninstalled.
        // FIXME adding trailing slash to unity2dDirectory()
//        fixedPath = unity2dDirectory() + "/" + fixedPath.right(fixedPath.length() - 9);
    }

    QDir newDir(fixedPath);

    fixedPath = newDir.absolutePath();
//    fixedPath = newDir.absolutePath().mid(2);

    if (m_path != fixedPath) {
        QDir oldDir(m_path);
        m_path = fixedPath;
        update();
        if (oldDir.exists() != newDir.exists()) {
            Q_EMIT existsChanged();
        }
    }
}

bool DirectoryModel::exists() const
{
    return QDir(m_path).exists();
}

//#include "directorymodel.moc"
