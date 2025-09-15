# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATE_PN="glycin"
inherit meson git-r3 cargo vala

DESCRIPTION="Glycin image loading library - sandboxed and extendable image decoding"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glycin  "
SRC_URI=""
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/glycin.git"
EGIT_COMMIT="2.0.0"

LICENSE="MIT"
SLOT="2"
KEYWORDS="~amd64"
IUSE="jpeg2000 +svg test"

RDEPEND="
	dev-libs/glib:2
	media-libs/libjpeg-turbo:=
	media-libs/libpng:=
	>=media-libs/lcms-2.12:=
	jpeg2000? ( media-libs/openjpeg:= )
	svg? ( gnome-base/librsvg:= )
	media-libs/glycin-loaders[heif,svg?]
"
DEPEND="${RDEPEND}
	dev-lang/vala
	virtual/pkgconfig
"
BDEPEND="
	$(vala_depend)
"

S="${WORKDIR}/${P}"

pkg_pretend() {
    ewarn ""
    ewarn "=================================================================="
    ewarn "BEFORE EMERGING ${PN}:"
    ewarn ""
    ewarn "you can instrall it following way:"
    ewarn "FEATURES=\"-network-sandbox\" emerge -av1 media-libs/glycin"
    ewarn ""
    ewarn "=================================================================="
    ewarn ""
}

src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
}

src_prepare() {
	vala_setup
	cargo_gen_config
	default
}

src_configure() {
	export CARGO_PROFILE_RELEASE_DEBUG=2 CARGO_PROFILE_RELEASE_STRIP=false

	local emesonargs=(
		-Dtest_skip_install=true
		-Dwerror=false
		-Db_pch=false
		-Db_lto=true
		-Db_lto_mode=thin
		-Dlibglycin=true
		-Dvapi=true
		-Dglycin-loaders=false  # Use external loaders package
		-Dintrospection=true
		-Dglycin-thumbnailer=true
		-Dtests=$(usex test true false)
	)

	meson_src_configure
}

src_compile() {
	meson_src_compile
}

src_install() {
	meson_src_install
}
