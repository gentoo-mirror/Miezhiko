# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..13} )

inherit git-r3 python-any-r1 desktop xdg wrapper

DESCRIPTION="Alchemy SL Viewer"
HOMEPAGE="https://alchemyviewer.org"
IUSE="fork fmod kde lto"

SLOT="0"
KEYWORDS="~amd64"
LICENSE="GPL-2-with-Linden-Lab-FLOSS-exception"

BDEPEND="${BDEPEND}
	dev-build/cmake"

DEPEND="${DEPEND}
	media-libs/libpng
	sys-libs/zlib[abi_x86_64,abi_x86_32]
	gui-libs/gtk
	media-libs/mesa
	media-libs/libsdl2
	dev-perl/XML-XPath
	media-video/vlc
	dev-python/pip
	dev-python/virtualenv
	"

RDEPEND="${DEPEND}
	net-dns/libidn-compat
	kde? ( kde-plasma/kde-cli-tools )"

# https://www.fmod.com/download#fmodstudiosuite
# register or login
# FMOD Engine -> Linux -> Download
# sudo mv ~/Downloads/fmod* /var/
: ${FMOD_VERSION:="2.02.22"}
: ${FMOD_FILE_PATH="/var"}

FMOD_DIR="${WORKDIR}/fmod"
FMOD_VERSION_NO_DOTS=${FMOD_VERSION//./}
FMOD_FILE="${FMOD_FILE_PATH}/fmodstudioapi${FMOD_VERSION_NO_DOTS}linux.tar.gz"
FMOD_OUT_FILE="${FMOD_DIR}/fmodstudio-${FMOD_VERSION}-linux64-0.tar.bz2"

src_unpack() {
	if use lto; then
		ewarn "LTO only works fine with clang and will lead to problems with GCC!"
	fi

	if use fmod; then
		EGIT_REPO_URI="https://github.com/AlchemyViewer/3p-fmodstudio.git"
		EGIT_BRANCH="main"
		EGIT_SUBMODULES=()
		EGIT_CHECKOUT_DIR="${FMOD_DIR}"
		git-r3_src_unpack
		if [[ -f "${FMOD_FILE}" ]]; then
			mkdir -p "${FMOD_DIR}/fmodstudio"
			cp "${FMOD_FILE}" "${FMOD_DIR}/fmodstudio/" || die
		else
			die "can't find FMOD_FILE at ${FMOD_FILE}, please download from https://www.fmod.com/download#fmodstudiosuite"
		fi
	fi

	if use fork; then
		# Personal fork:
		EGIT_REPO_URI="https://github.com/Miezhiko/Alchemy.git"
		EGIT_BRANCH="mawa"
	else
		# Official repository:
		EGIT_REPO_URI="https://github.com/AlchemyViewer/Alchemy.git"
		EGIT_BRANCH="main"
	fi
	EGIT_SUBMODULES=( '*' )
	EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"

	git-r3_src_unpack

	cd "${S}"
	virtualenv ".venv" -p python3 || die "failed to create virtual env"
	source .venv/bin/activate
	pip3 install --upgrade llbase certifi autobuild || die

	if use fmod; then
		cd "${FMOD_DIR}"
		AUTOBUILD_BUILD_ID=0 autobuild build -A64 || die "failed to compile fmod studio"
		AUTOBUILD_BUILD_ID=0 autobuild package -A64 || die "failed to package fmod studio"
		cd "${S}"
		if [[ -f ${FMOD_OUT_FILE} ]]; then
			autobuild installables edit -a file://${FMOD_OUT_FILE} || die "failed to add fmod to autobuild.xml"
		else
			eerror "${FMOD_OUT_FILE} missing"
			die "failed to find compiled fmod studio"
		fi
	fi

	autobuild configure -A 64 -c ReleaseOS -- \
		-DLL_TESTS:BOOL=FALSE \
		-DLLCOREHTTP_TESTS=FALSE \
		-DDISABLE_FATAL_WARNINGS=ON \
		-DENABLE_MEDIA_PLUGINS=ON \
		-DUSE_VLC=ON \
		-DUSE_X11=ON \
		-DUSE_CEF=ON \
		-DUSE_OPENAL=ON \
		-DEXAMPLEPLUGIN=OFF \
		-DREVISION_FROM_VCS=ON \
		-DUSE_DISCORD=OFF \
		-DUSE_LTO=$(usex lto ON OFF) \
		-DUSESYSTEMLIBS=OFF \
		-DUSE_FMODSTUDIO=$(usex fmod ON OFF) || die "configure failed"

	if ! use fork; then
		eapply "${FILESDIR}"/alchemy-desktop.patch
	fi

	autobuild build -A 64 -c ReleaseOS --no-configure || die "build failed"
}

src_configure() {
	:;
}

src_compile() {
	:;
}

src_install() {
	insinto "/opt/alchemy-install"
	doins -r "${WORKDIR}/${P}"/build-linux-64/newview/packaged/*

	fperms +x /opt/alchemy-install/bin/llplugin/chrome-sandbox
	fperms +x /opt/alchemy-install/bin/llplugin/dullahan_host
	fperms +x /opt/alchemy-install/bin/alchemy-bin
	fperms +x /opt/alchemy-install/bin/ALPlugin
	fperms +x /opt/alchemy-install/bin/SLVoice
	fperms +x /opt/alchemy-install/alchemy
	fperms -R +x /opt/alchemy-install/etc/

	make_wrapper alchemy "/opt/alchemy-install/alchemy"

	domenu "${FILESDIR}/alchemy-viewer.desktop"
}

pkg_postinst() {
	xdg_pkg_postinst
}
