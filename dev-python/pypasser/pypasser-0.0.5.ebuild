# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="${PN}"
HOMEPAGE="https://pypi.org/project/${PN}"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="
	dev-python/speech-recognition
	dev-python/pydub"
DEPEND="${RDEPEND}"

KEYWORDS="~amd64 ~x86"
MY_PN=PyPasser
MY_P="${MY_PN}-${PV}"

SRC_URI="https://github.com/xHossein/PyPasser/archive/refs/tags/${PV}.tar.gz -> ${MY_P}.tar.gz"

S="${WORKDIR}/${MY_P}"
