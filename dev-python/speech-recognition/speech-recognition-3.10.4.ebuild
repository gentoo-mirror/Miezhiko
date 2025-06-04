# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="${PN}"
HOMEPAGE="https://pypi.org/project/${PN}"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

KEYWORDS="~amd64 ~x86"
MY_PN=speech_recognition
MY_P="${MY_PN}-${PV}"

SRC_URI="https://github.com/Uberi/speech_recognition/archive/refs/tags/${PV}.tar.gz -> ${MY_P}.tar.gz"
RESTRICT="mirror"

S="${WORKDIR}/${MY_P}"
