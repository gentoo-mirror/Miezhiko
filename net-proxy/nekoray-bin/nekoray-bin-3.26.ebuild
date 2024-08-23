EAPI=8

inherit desktop

DESCRIPTION="Qt based cross-platform GUI proxy configuration manager"
HOMEPAGE="https://github.com/MatsuriDayo/nekoray/"
LICENSE="BSD-3"
RESTRICT="strip"

SLOT="0"
KEYWORDS="~amd64"

IUSE="naiveproxy"

RDEPEND="
	x11-libs/libxcb
	!net-pxory/nekoray
	naiveproxy? ( net-proxy/naiveproxy )
"
RELEASE_DATE="2023-12-09"

SRC_URI="https://github.com/MatsuriDayo/nekoray/releases/download/${PV}/nekoray-${PV}-${RELEASE_DATE}-linux64.zip"

S="${WORKDIR}/nekoray"

src_install() {
	insinto /opt/nekoray-bin
	doins -r *
	fperms +x /opt/nekoray-bin/nekoray /opt/nekoray-bin/nekoray_core /opt/nekoray-bin/nekobox_core /opt/nekoray-bin/launcher
	dosym /opt/nekoray-bin/nekoray /usr/bin/nekoray
	make_desktop_entry "nekoray -appdata" Nekoray nekoray Network
	doicon -s 512 nekoray.png
	doicon -s scalable nekoray.png
}
