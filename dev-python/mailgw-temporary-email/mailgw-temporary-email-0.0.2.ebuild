# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..12} )

inherit distutils-r1

DESCRIPTION="Mail.gw is a free 10 minute temporary mail service"
HOMEPAGE="https://pypi.org/project/${PN}"

LICENSE="GPL-3.0"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

KEYWORDS="~amd64 ~x86"
SRC_URI="https://github.com/bontoutou00/MailGw/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/MailGw-${PV}"
