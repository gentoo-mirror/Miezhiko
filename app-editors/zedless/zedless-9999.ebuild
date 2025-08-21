# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop cargo git-r3

ECARGO_HOME="${WORKDIR}/cargo_home"
ECARGO_VENDOR="${ECARGO_HOME}/gentoo"

DESCRIPTION="Code editor from the creators of Atom"
HOMEPAGE="https://github.com/zedless-editor/zed"
EGIT_REPO_URI="https://github.com/zedless-editor/zed.git"

RESTRICT="mirror strip bindist"

# no idea, those are randome ones:
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

src_unpack() {
	git-r3_src_unpack

	mkdir -p "${ECARGO_VENDOR}" "${ECARGO_HOME}" || die

	rust_pkg_setup

	pushd "${S}" > /dev/null || die

	cat > "${ECARGO_HOME}/config.toml" <<- _EOF_ || die
	[net]
	offline = false

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

	einfo "Fetching dependencies..."
	"${CARGO}" fetch || die "cargo fetch failed"

	einfo "Vendoring dependencies..."
	"${CARGO}" vendor "${ECARGO_VENDOR}" || die "cargo vendor failed"

	cat > "${ECARGO_HOME}/config.toml" <<- _EOF_ || die
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

	einfo "Pre-compiling in src_unpack to avoid network access later..."

	tc-export AR CC CXX PKG_CONFIG

	local -x \
		HOST_AR=$(tc-getBUILD_AR) \
		HOST_CC=$(tc-getBUILD_CC) \
		HOST_CXX=$(tc-getBUILD_CXX) \
		HOST_CFLAGS=${BUILD_CFLAGS} \
		HOST_CXXFLAGS=${BUILD_CXXFLAGS}
	
	local -x CARGO_BUILD_TARGET=$(rust_abi)
	local TRIPLE=${CARGO_BUILD_TARGET//-/_}
	local TRIPLE=${TRIPLE^^} LD_A=( $(tc-getCC) ${LDFLAGS} )
	local -Ix CARGO_TARGET_"${TRIPLE}"_RUSTFLAGS+=" -C strip=none -C linker=${LD_A[0]} -C target-feature=-crt-static"
	[[ ${#LD_A[@]} -gt 1 ]] && local CARGO_TARGET_"${TRIPLE}"_RUSTFLAGS+="$(printf -- ' -C link-arg=%s' "${LD_A[@]:1}")"
	local CARGO_TARGET_"${TRIPLE}"_RUSTFLAGS+=" ${RUSTFLAGS}"

	"${CARGO}" build --release || die "Pre-compilation failed"
	
	popd > /dev/null || die

	touch "${WORKDIR}/.cargo_precompiled" || die
}

src_configure() {
	[[ -f "${WORKDIR}/.cargo_precompiled" ]] || die "Pre-compilation marker not found"
	
	export CARGO_HOME="${ECARGO_HOME}"
	
	[[ -f "${ECARGO_HOME}/config.toml" ]] || die "Cargo config not found"
}

src_compile() {
	if [[ -f "${WORKDIR}/.cargo_precompiled" ]]; then
		einfo "Skipping compilation - already done in src_unpack"
		return 0
	fi

	die "Pre-compilation was not completed in src_unpack"
}

src_install() {
	export CARGO_HOME="${ECARGO_HOME}"
	
	pushd "${S}" > /dev/null || die
	
	local target_dir="target/$(rust_abi)/release"
	
	if [[ -d "${S}/${target_dir}" ]]; then
		local file
		for file in "${S}/${target_dir}"/*; do
			# Skip if not a file or not executable
			[[ -f "${file}" && -x "${file}" ]] || continue
			
			local basename_file="$(basename "${file}")"
			
			# Skip build artifacts and directories
			case "${basename_file}" in
				build|deps|examples|incremental)
					einfo "Skipping directory: ${basename_file}"
					continue
					;;
				*.d|*.rlib|*.so|*.a)
					einfo "Skipping build artifact: ${basename_file}"
					continue
					;;
				lib*)
					einfo "Skipping library: ${basename_file}"
					continue
					;;
				*)
					# This should be an actual binary
					einfo "Installing binary: ${basename_file}"
					dobin "${file}"
					;;
			esac
		done
	else
		die "Could not find target release directory at ${S}/${target_dir}"
	fi
	
	popd > /dev/null || die
	
	domenu "${FILESDIR}/${PN}.desktop"
}
