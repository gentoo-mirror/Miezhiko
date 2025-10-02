# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake multilib-minimal

DESCRIPTION="MPEG-5 LCEVC Decoder SDK by V-Nova"
HOMEPAGE="https://github.com/v-novaltd/LCEVCdec"
SRC_URI="https://github.com/v-novaltd/LCEVCdec/archive/refs/tags/${PV}.tar.gz"
#EGIT_REPO_URI="https://github.com/v-novaltd/LCEVCdec.git"

LICENSE="V-Nova-LCEVC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# This package uses a custom non-free license
RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="virtual/pkgconfig"

S="${WORKDIR}/LCEVCdec-${PV}"

multilib_src_configure() {
	cmake_src_configure
}

multilib_src_compile() {
	cmake_src_compile
}

multilib_src_install() {
	cmake_src_install
}
