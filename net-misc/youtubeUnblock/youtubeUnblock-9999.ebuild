# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit git-r3

DESCRIPTION="Bypasses Googlevideo detection systems that relies on SNI"
EGIT_REPO_URI="https://github.com/Waujito/youtubeUnblock.git"
EGIT_BRANCH="main"
HOMEPAGE="https://github.com/Waujito/youtubeUnblock"

LICENSE="Apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-firewall/iptables"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}
