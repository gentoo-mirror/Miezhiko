# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd meson

MY_PV="${PV//_pre*}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Backend implementation for xdg-desktop-portal using GTK+"
HOMEPAGE="https://flatpak.org/ https://github.com/flatpak/xdg-desktop-portal-gtk"
SRC_URI="https://github.com/flatpak/${PN}/releases/download/${MY_PV}/${MY_P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ~loong ~ppc ~ppc64 ~riscv x86"
IUSE="wayland X"

BDEPEND="
	dev-util/gdbus-codegen
	sys-devel/gettext
	virtual/pkgconfig
"

DEPEND="
	dev-libs/glib:2
	gnome-base/gsettings-desktop-schemas
	media-libs/fontconfig
	sys-apps/dbus
	>=sys-apps/xdg-desktop-portal-1.14.0
	x11-libs/cairo[X?]
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3[wayland?,X?]
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	local emesonargs=(
	    -Dsystemd-user-unit-dir="$(systemd_get_userunitdir)"
		-Dsettings=enabled
		-Dwallpaper=enabled
		-Dlockdown=disabled
	)
	meson_src_configure
}
