# Copyright 2023-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

ANANICY_COMMIT="a0fa41339ab204aba08397b7e58d68cd780e769e" # for rules
MYPV="${PV/_rc/-rc}"

inherit cmake git-r3

DESCRIPTION="Ananicy rewritten in C++ for much lower CPU and memory usage (powered by CachyOS rules)"
EGIT_REPO_URI="https://gitlab.com/ananicy-cpp/ananicy-cpp.git"
SRC_URI="
	https://github.com/CachyOS/ananicy-rules/archive/${ANANICY_COMMIT}.tar.gz -> ananicy-rules-${ANANICY_COMMIT}.tar.gz
"
S="${WORKDIR}/ananicy-cpp-9999"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="systemd"

RDEPEND="
	dev-cpp/nlohmann_json
	dev-libs/libfmt
	dev-libs/spdlog
	systemd? ( sys-apps/systemd )
"
DEPEND="
	${RDEPEND}
	dev-cpp/std-format
	sys-auth/rtkit
"

src_unpack() {
	default
	git-r3_src_unpack
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_SYSTEMD=$(usex systemd)
		-DUSE_EXTERNAL_FMTLIB=ON
		-DUSE_EXTERNAL_JSON=ON
		-DUSE_EXTERNAL_SPDLOG=ON
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	mv "${WORKDIR}/ananicy-rules-${ANANICY_COMMIT}" "${WORKDIR}/ananicy.d" || die
	doins -r "${WORKDIR}/ananicy.d"
}
