# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=(python3_{11..13})
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 git-r3

DESCRIPTION="A framework for building packages and for managing the dependencies"
HOMEPAGE="https://github.com/secondlife/autobuild"
EGIT_REPO_URI="https://github.com/secondlife/autobuild"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"

RDEPEND="
	${PYTHON_DEPS}
"
DEPEND="
	dev-python/pydot[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	games-simulation/llbase[${PYTHON_USEDEP}]
	${RDEPEND}
"

src_prepare() {
	rm -rf "${S}/tests"
	default
}

DOCS="README.md"

