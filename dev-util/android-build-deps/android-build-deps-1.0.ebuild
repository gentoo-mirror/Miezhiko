# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Meta package for Android build dependencies"
HOMEPAGE="https://source.android.com/"
SRC_URI=""

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RESTRICT="mirror"

RDEPEND="
	sys-devel/bc
	sys-devel/bison
	dev-util/ccache
	net-misc/curl
	sys-devel/flex
	sys-devel/gcc[multilib]
	dev-vcs/git
	dev-vcs/git-lfs
	app-crypt/gnupg
	dev-util/gperf
	media-gfx/imagemagick
	dev-libs/protobuf
	dev-python/protobuf
	sys-libs/readline
	sys-libs/zlib
	dev-libs/elfutils
	app-arch/lz4
	media-libs/libsdl
	dev-libs/openssl
	dev-libs/libxml2
	app-arch/lzop
	media-gfx/pngcrush
	net-misc/rsync
	sys-process/schedtool
	sys-fs/squashfs-tools
	dev-libs/libxslt
	app-arch/zip
"

pkg_setup() {
	ewarn "this needs to be built with ABI_X86=\"64 32\""
	default
}

pkg_postinst() {
	elog "For Android builds, 32-bit multilib libraries are required for:"
	elog "  sys-libs/readline"
	elog "  sys-libs/zlib"
	elog "  media-libs/libsdl"
	elog "  dev-libs/elfutils (optional, but often needed)"
	elog ""
	elog "If not already done, add to /etc/portage/package.use/android-build:"
	elog "  sys-libs/readline abi_x86_32"
	elog "  sys-libs/zlib abi_x86_32"
	elog "  media-libs/libsdl abi_x86_32"
	elog "  dev-libs/elfutils abi_x86_32"
	elog ""
	default
}
