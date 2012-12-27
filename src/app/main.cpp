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
#include <QApplication>
#include <qqml.h>
#include "declarativeview.h"

class PageStatus
{
    Q_GADGET
    Q_ENUMS(Status)
public:
    enum Status {
        Inactive,
        Activating,
        Active,
        Deactivating
    };
private:
    PageStatus();
};

class PageOrientation
{
    Q_GADGET
    Q_ENUMS(Orientation)
public:
    enum Orientation {
        Automatic,
        LockPortrait,
        LockLandscape,
        LockPrevious,
        Manual
    };
private:
    PageOrientation();
};

int main(int argc, char *argv[])
{
    qmlRegisterUncreatableType<PageStatus>("QtDesktop", 1, 0, "PageStatus", QLatin1String("Do not create objects of type pageStatus"));
    qmlRegisterUncreatableType<PageOrientation>("QtDesktop", 1, 0, "PageOrientation", QLatin1String("Do not create objects of type pageOrientation"));

    QApplication a(argc, argv);
    a.setApplicationName("vreen");
    a.setOrganizationName("vreen");
    a.setOrganizationDomain("https://github.com/gorthauer/vreen");

    DeclarativeView view;
    view.showNormal();
    return a.exec();
}

#include "main.moc"
