# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATE_PN="glycin"

inherit meson git-r3 cargo vala

DESCRIPTION="Glycin image loading library - sandboxed and extendable image decoding"
HOMEPAGE="https://gitlab.gnome.org/GNOME/glycin"
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

_custom_src_unpack() {
	git-r3_src_unpack
	cargo_live_src_unpack
	
	_do_configure_and_compile
}

_do_configure_and_compile() {
	pushd "${S}" || die

	vala_setup

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
	
	einfo "Configuring with meson (in unpack phase)..."
	meson_src_configure
	
	einfo "Compiling with meson (in unpack phase)..."
	meson_src_compile
	
	popd || die
}

_custom_cargo_gen_config() {
	mkdir -p "${ECARGO_HOME}" || die

	cat > "${ECARGO_HOME}/config.toml" <<- _EOF_ || die "Failed to create cargo config"
	[source.gentoo]
	directory = "${ECARGO_VENDOR}"

	[source.crates-io]
	replace-with = "gentoo"
	local-registry = "/nonexistent"

	[net]
	offline = true

	[build]
	jobs = $(makeopts_jobs)
	incremental = false

	[env]
	RUST_TEST_THREADS = "$(makeopts_jobs)"

	[term]
	verbose = true
	$([[ "${NOCOLOR}" = true || "${NOCOLOR}" = yes ]] && echo "color = 'never'")

	_EOF_

	export CARGO_HOME="${ECARGO_HOME}"
}

src_unpack() {
	_custom_src_unpack
}

src_prepare() {
	default
}

src_configure() {
	:;
}

src_compile() {
	:;
}

src_install() {
	meson_src_install
}
