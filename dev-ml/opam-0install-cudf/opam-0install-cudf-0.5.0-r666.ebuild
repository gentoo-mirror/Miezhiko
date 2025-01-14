# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Opam solver using 0install backend using the CUDF interface"
HOMEPAGE="https://github.com/ocaml-opam/opam-0install-cudf"
SRC_URI="https://github.com/ocaml-opam/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ppc ppc64 ~riscv x86"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.08:=[ocamlopt=]
	dev-ml/0install-solver:=
	dev-ml/cudf:=
"

DEPEND+="${RDEPEND}"

# missing test data
RESTRICT="test"

QA_FLAGS_IGNORED='.*'

src_compile() {
    dune-compile "${PN}"
}

src_test() {
    dune-test "${PN}"
}

src_install() {
    dune-install "${PN}"
}
