# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome.org gnome2-utils meson readme.gentoo-r1 virtualx xdg

DESCRIPTION="Default file manager for the GNOME desktop"
HOMEPAGE="https://apps.gnome.org/Nautilus/"

LICENSE="GPL-3+ LGPL-2.1+"
SLOT="0"

KEYWORDS="~amd64 ~arm ~arm64 ~loong ~ppc ~ppc64 ~riscv ~x86"

IUSE="+cloudproviders doc gnome +gstreamer +introspection +previewer selinux"

DEPEND="
	>=dev-libs/glib-2.82.0:2
	>=media-libs/gexiv2-0.14.2
	>=x11-libs/gdk-pixbuf-2.30.0:2
	gstreamer? ( media-libs/gstreamer:1.0
		media-libs/gst-plugins-base:1.0 )
	>=app-arch/gnome-autoar-0.4.4
	>=gnome-base/gnome-desktop-43:4=
	>=gnome-base/gsettings-desktop-schemas-42
	>=gui-libs/gtk-4.13.6:4[introspection?]
	>=gui-libs/libadwaita-1.4.0:1
	>=dev-libs/libportal-0.5:=[gtk]
	>=x11-libs/pango-1.28.3
	selinux? ( >=sys-libs/libselinux-2.0 )
	>=app-misc/tinysparql-3.0:3
	app-misc/localsearch
	cloudproviders? ( >=net-libs/libcloudproviders-0.3.1 )
	introspection? ( >=dev-libs/gobject-introspection-1.54:= )
"
BDEPEND="
	>=dev-util/gdbus-codegen-2.51.2
	dev-util/glib-utils
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	test? ( sys-apps/dbus )
"
PDEPEND="
	gnome? ( x11-themes/adwaita-icon-theme )
	previewer? ( >=gnome-extra/sushi-0.1.9 )
	>=gnome-base/gvfs-1.14[gtk(+)]
" # Need gvfs[gtk] for recent:/// support; always built (without USE=gtk) since gvfs-1.34

PATCHES=(
	"${FILESDIR}"/43.0-optional-gstreamer.patch # Allow controlling audio-video-properties build
)

src_prepare() {
	default
	xdg_environment_reset

	# Disable -Werror
	sed -e '/-Werror=/d' -i meson.build ||  die

	if use previewer; then
		DOC_CONTENTS="nautilus uses gnome-extra/sushi to preview media files.
			To activate the previewer, select a file and press space; to
			close the previewer, press space again."
	fi

	# Disable test-nautilus-search-engine-tracker; bug #831170
	sed -e '/^tracker_tests = /{n;N;N;d}' -i test/automated/displayless/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_use doc docs)
		-Dextensions=true # image file properties, also required for -Dgstreamer=true
		$(meson_use introspection)
		-Dpackagekit=false
		$(meson_use selinux)
		$(meson_use cloudproviders)
		-Dtests=$(usex test all none)

		$(meson_use gstreamer) # gstreamer audio-video-properties extension
	)
	meson_src_configure
}

src_install() {
	use previewer && readme.gentoo_create_doc
	meson_src_install
}

src_test() {
	# Avoid dconf that looks at XDG_DATA_DIRS, which can sandbox fail if flatpak is installed
	gnome2_environment_reset
	# TODO: Tests require tracker testutils (e.g. tracker-sandbox), which may
	# need some sorting out with tracker use flag deps
	# GIO_USE_VOLUME_MONITOR=unix due to https://gitlab.gnome.org/GNOME/gvfs/-/issues/629#note_1467280
	GIO_USE_VOLUME_MONITOR=unix XDG_SESSION_TYPE=x11 virtx dbus-run-session meson test -C "${BUILD_DIR}" || die
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update

	if use previewer; then
		readme.gentoo_print_elog
	else
		elog "To preview media files, emerge nautilus with USE=previewer"
	fi
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
