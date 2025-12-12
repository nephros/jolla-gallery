// SPDX-FileCopyrightText: 2013-2021 Jolla Ltd.
// SPDX-FileCopyrightText: 2021 Open Mobile Platform LLC.
// SPDX-FileCopyrightText: 2025 Jolla Mobile Ltd
// SPDX-FileCopyrightText: 2023,2025 Peter G. <sailfish@nephros.org>
//
// SPDX-License-Identifier: BSD-3-Clause

#include <QQmlExtensionPlugin>
#include <QQmlEngine>
#include <QtQml>

#include <QGuiApplication>
#include <QTranslator>
#include <QLocale>

// using custom translator so it gets properly removed from qApp when engine is deleted
class AppTranslator: public QTranslator
{
    Q_OBJECT

public:
    AppTranslator(QObject *parent)
        : QTranslator(parent)
    {
        qApp->installTranslator(this);
    }

    virtual ~AppTranslator()
    {
        qApp->removeTranslator(this);
    }
};

class JollaGalleryFavoritesPlugin : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "com.jolla.gallery.favorites")

public:
    void initializeEngine(QQmlEngine *engine, const char *uri)
    {
        Q_UNUSED(uri)
        Q_ASSERT(QLatin1String(uri) == QLatin1String("com.jolla.gallery.favorites"));
        AppTranslator *engineeringEnglish = new AppTranslator(engine);
        engineeringEnglish->load("gallery-extension-favorites-en", "/usr/share/translations");
        AppTranslator *translator = new AppTranslator(engine);
        translator->load(QLocale(), "gallery-extension-favorites", "-", "/usr/share/translations");
    }

    virtual void registerTypes(const char *uri)
    {
        Q_ASSERT(QLatin1String(uri) == QLatin1String("com.jolla.gallery.favorites"));
    }
};

#include "plugin.moc"

