# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A Qt5 library to write cross-platform clients for Matrix"
HOMEPAGE="https://github.com/qmatrixclient/libqmatrixclient"

inherit cmake

if [[ ${PV} == "9999" ]]; then
	inherit git-r3

	SRC_URI=""
	EGIT_REPO_URI="https://github.com/quotient-im/${PN}.git"
else
	SRC_URI="https://gitlab.com/quotient-im/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"	
fi

KEYWORDS="~amd64 ~x86"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-qt/qtcore
	dev-qt/qtmultimedia
	!!dev-libs/libqmatrixclient
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_INCLUDEDIR=include/libquotient
	)

	cmake_src_configure
}
