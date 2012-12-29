/****************************************************************************
**
** Vreen - vk.com API Qt bindings
**
** Copyright © 2012 Aleksey Sidorov <gorthauer87@ya.ru>
**
*****************************************************************************
**
** $VREEN_BEGIN_LICENSE$
** This program is free software: you can redistribute it and/or modify
** it under the terms of the GNU Lesser General Public License as published by
** the Free Software Foundation, either version 3 of the License, or
** (at your option) any later version.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
** See the GNU Lesser General Public License for more details.
**
** You should have received a copy of the GNU General Public License
** along with this program.  If not, see http://www.gnu.org/licenses/.
** $VREEN_END_LICENSE$
**
****************************************************************************/
#include "declarativeview.h"
#include <QDir>
#include <QFileInfo>
#include <QCoreApplication>
#include <QQmlEngine>
#include <QQmlComponent>
#include <QDebug>

namespace  {

static QString testPath(const QString &source)
{
    QString path = QCoreApplication::applicationDirPath() + source;
    if (QFileInfo(path).exists())
        return path;
    else
        return QString();
}

QString adjustPath(const QString &source)
{
    QString path = testPath(QLatin1String("/../share/") + source);
    if (!path.isEmpty())
        return path;
    path = testPath(QLatin1String("/../Resources/") + source);
    if (!path.isEmpty())
        return path;
    path = testPath(QLatin1String("/../share/apps/") + qApp->applicationName() + QLatin1String("/") + source);
    if (!path.isEmpty())
        return path;
    path = testPath("/" + source);
    return path;
}

} //namespace

DeclarativeView::DeclarativeView(QObject *parent) :
    QObject(parent),
    m_engine(new QQmlEngine(this))
{
    connect(m_engine, SIGNAL(quit()), SLOT(quit()));

    setMainQmlFile("qml/main.qml");
}

void DeclarativeView::setMainQmlFile(const QString &file)
{
    m_currentFile = adjustPath(file);

    engine()->clearComponentCache();
    m_component = QSharedPointer<QQmlComponent>(new QQmlComponent(m_engine, m_currentFile, this));
    if (!m_component->isLoading()) {
        continueExecute();
    } else {
        connect(m_component.data(), SIGNAL(statusChanged(QQmlComponent::Status)), this, SLOT(continueExecute()));
    }
}

void DeclarativeView::addImportPath(const QString &path)
{
    engine()->addImportPath(path);
}

QQmlEngine *DeclarativeView::engine() const
{
    return m_engine;
}

QQmlContext *DeclarativeView::rootContext() const
{
    return m_engine->rootContext();
}

void DeclarativeView::quit()
{
}

void DeclarativeView::continueExecute()
{
    disconnect(m_component.data(), SIGNAL(statusChanged(QQmlComponent::Status)), this, SLOT(continueExecute()));

    if (m_component->isError()) {
        QList<QQmlError> errorList = m_component->errors();
        foreach (QQmlError error, errorList) {
            qWarning() << error;
        }
        return;
    }

    QObject *obj = m_component->create();
    obj->setParent(m_engine);

    if (m_component->isError()) {
        QList<QQmlError> errorList = m_component->errors();
        foreach (QQmlError error, errorList) {
            qWarning() << error;
        }
        return;
    }
}
