# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3 meson xdg

DESCRIPTION="GStreamer plugins written in Rust"
HOMEPAGE="https://gstreamer.freedesktop.org/"
SRC_URI="https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git -> ${P}.git"
EGIT_REPO_URI="https://gitlab.freedesktop.org/gstreamer/gst-plugins-rs.git"

LICENSE="|| ( LGPL-2.1+ MIT Apache-2.0 MPL-2.0 )"
SLOT="1.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

#TODO: vvdec media lib
DEPEND="
	media-libs/gstreamer:1.0
	media-libs/gst-plugins-base:1.0
	media-libs/dav1d
	gui-libs/gtk:4
	dev-libs/libsodium
	media-libs/libwebp
"
RDEPEND="${DEPEND}"

src_unpack() {
	# 1. Clone source
	git-r3_src_unpack
	cargo_live_src_unpack

	# 6. Prepare Meson build dir
	local builddir="${WORKDIR}/build"
	mkdir -p "${builddir}"
	
	tc-export CC CXX AR NM OBJCOPY PKG_CONFIG
	export CC=$(tc-getCC)
	export CXX=$(tc-getCXX)
	export LD=$(tc-getLD)
	export AR=$(tc-getAR)
	export NM=$(tc-getNM)
	export PKG_CONFIG=$(tc-getPKG_CONFIG)

	# 7. Set up Meson args (manually, without meson.eclass)
	local emesonargs=(
		--libdir="$(get_libdir)"
		--prefix="${EPREFIX}/usr"
		--sysconfdir="${EPREFIX}/etc"
		--localstatedir="${EPREFIX}/var/lib"
		-Dcsound=disabled
		-Ddoc=disabled
		-Dsodium-source=system
	)

	# 8. Run Meson setup
	pushd "${builddir}" || die
	meson setup "${emesonargs[@]}" "${S}" || die "meson setup failed"

	# 9. Compile with ninja
	ninja -j$(makeopts_jobs) || die "ninja build failed"

	# 10. Install to D (temporarily in WORKDIR)
	DESTDIR="${WORKDIR}/fake-root" ninja install || die "ninja install failed"
	popd
}

src_configure() { :; }
src_compile() { :; }
src_test() { :; }

src_install() {
	cp -r "${WORKDIR}/fake-root"/. "${D}" || die
	einstalldocs
}
