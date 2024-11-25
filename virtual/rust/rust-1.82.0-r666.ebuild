# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit multilib-build

DESCRIPTION="Virtual for Rust language compiler"

LICENSE=""

SLOT="0/llvm-19"

KEYWORDS="~amd64"
IUSE="rustfmt profiler"

BDEPEND=""
RDEPEND="~dev-lang/rust-${PV}[profiler?,rustfmt?,${MULTILIB_USEDEP}]"
