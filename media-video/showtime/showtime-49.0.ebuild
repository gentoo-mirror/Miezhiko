# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome.org meson xdg

DESCRIPTION="A modern video player for GNOME"
HOMEPAGE="https://apps.gnome.org/Showtime/"
SRC_URI="https://download.gnome.org/sources/showtime/${PV%.*}/showtime-${PV}.tar.xz"

LICENSE="GPL-3.0-or-later"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-libs/glib-2.76:2
	>=media-libs/gstreamer-1.22:1.0
	>=media-libs/gst-plugins-base-1.22:1.0
	>=gui-libs/gtk-4.15:4
"
RDEPEND="${DEPEND}"

