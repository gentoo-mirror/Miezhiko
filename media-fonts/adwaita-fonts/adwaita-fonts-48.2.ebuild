# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Adwaita fonts, the default font set for GNOME"
HOMEPAGE="https://gitlab.gnome.org/GNOME/adwaita-fonts"
SRC_URI="https://gitlab.gnome.org/GNOME/adwaita-fonts/-/archive/${PV}/${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

FONT_SUFFIX="ttf"
FONT_S="/usr/share/fonts/Adwaita"

src_install() {
    meson_src_install
}

pkg_postinst() {
    einfo "Adwaita fonts have been installed. You may need to run 'fc-cache -fv' to update your font cache."
}
