# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils xdg optfeature

DESCRIPTION="Multiplatform Visual Studio Code from Microsoft"
HOMEPAGE="https://code.visualstudio.com"
SRC_URI="https://update.code.visualstudio.com/${PV}/linux-x64/stable -> ${P}-amd64.tar.gz"
S="${WORKDIR}"

RESTRICT="mirror strip bindist"

LICENSE="
	Apache-2.0
	BSD
	BSD-1
	BSD-2
	BSD-4
	CC-BY-4.0
	ISC
	LGPL-2.1+
	Microsoft-vscode
	MIT
	MPL-2.0
	openssl
	PYTHON
	TextMate-bundle
	Unlicense
	UoI-NCSA
	W3C
"
SLOT="0"
KEYWORDS="-* ~amd64"

RDEPEND="
	app-accessibility/at-spi2-atk:2
	app-accessibility/at-spi2-core:2
	app-crypt/libsecret[crypt]
	dev-libs/atk
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libxkbfile
	x11-libs/libXrandr
	x11-libs/libxshmfence
	x11-libs/pango
"

QA_PREBUILT="
  /opt/vscode/chrome_crashpad_handler
	/opt/vscode/chrome-sandbox
	/opt/vscode/code
	/opt/vscode/libEGL.so
	/opt/vscode/libffmpeg.so
	/opt/vscode/libGLESv2.so
	/opt/vscode/libvk_swiftshader.so
	/opt/vscode/libvulkan.so*
	/opt/vscode/resources/app/extensions/*
	/opt/vscode/resources/app/node_modules.asar.unpacked/*
	/opt/vscode/swiftshader/libEGL.so
	/opt/vscode/swiftshader/libGLESv2.so
"

src_install() {
	if use amd64; then
		cd "${WORKDIR}/VSCode-linux-x64" || die
	elif use arm; then
		cd "${WORKDIR}/VSCode-linux-armhf" || die
	elif use arm64; then
		cd "${WORKDIR}/VSCode-linux-arm64" || die
	else
		die "Visual Studio Code only supports amd64, arm and arm64"
	fi

	# Disable update server
	sed -e "/updateUrl/d" -i ./resources/app/product.json || die

	# Install
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	fperms +x /opt/${PN}/{,bin/}code
	fperms +x /opt/${PN}/chrome_crashpad_handler
	fperms 4711 /opt/${PN}/chrome-sandbox
	fperms 755 /opt/${PN}/resources/app/extensions/git/dist/{askpass,git-editor,ssh-askpass}{,-empty}.sh
	fperms -R +x /opt/${PN}/resources/app/out/vs/base/node
	fperms +x /opt/${PN}/resources/app/node_modules/@vscode/ripgrep/bin/rg
	dosym "../../opt/${PN}/bin/code" "usr/bin/vscode"
	dosym "../../opt/${PN}/bin/code" "usr/bin/code"
	domenu "${FILESDIR}/vscode.desktop"
	domenu "${FILESDIR}/vscode-url-handler.desktop"
	domenu "${FILESDIR}/vscode-wayland.desktop"
	domenu "${FILESDIR}/vscode-url-handler-wayland.desktop"
	newicon "resources/app/resources/linux/code.png" "vscode.png"
}

pkg_postinst() {
	xdg_pkg_postinst
	optfeature "keyring support inside vscode" "gnome-base/gnome-keyring"
}
