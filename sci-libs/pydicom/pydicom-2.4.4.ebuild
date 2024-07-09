# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..12} )

inherit distutils-r1

DESCRIPTION="A pure python package for parsing DICOM files"
HOMEPAGE="http://www.pydicom.org/"
SRC_URI="https://github.com/pydicom/pydicom/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

# Upstream bug: https://github.com/pydicom/pydicom/issues/663
RESTRICT="test"

DEPEND="test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	distutils-r1_install_for_testing
	py.test --cov=pydicom -r sx --pyargs pydicom --verbose || die
}
