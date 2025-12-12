// SPDX-FileCopyrightText: 2013-2018 Jolla Ltd.
// SPDX-FileCopyrightText: 2025 Jolla Mobile Ltd
// SPDX-FILECopyrightText: 2025 Peter G. <sailfish@nephros.org>
//
// SPDX-License-Identifier: BSD-3-Clause

import QtQuick 2.0
import Sailfish.Silica 1.0
import com.jolla.gallery 1.0

MediaSourceIcon {
    Image {
        anchors.centerIn: parent
        width: Theme.iconSizeLarge
        source: "image://theme/icon-m-folder-favorites"
        fillMode: Image.PreserveAspectFit
        clip: true
    }
}
// vim: ft=javascript ts=4 st=4 sw=4 expandtab
