# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi

DESCRIPTION="Python client library for the OpenAI API"
HOMEPAGE="https://github.com/openai/openai-python"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm64 x86"
IUSE="datalib"

RDEPEND=">=dev-python/requests-2.20[${PYTHON_USEDEP}]
	dev-python/tqdm[${PYTHON_USEDEP}]
	dev-python/aiohttp[${PYTHON_USEDEP}]
	datalib? (
		dev-python/numpy[${PYTHON_USEDEP}]
		>=dev-python/pandas-1.2.3[${PYTHON_USEDEP}]
		>=dev-python/pandas-stubs-1.1.0.11[${PYTHON_USEDEP}]
		>=dev-python/openpyxl-3.0.7[${PYTHON_USEDEP}]
	)"

DEPEND="${RDEPEND}"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RESTRICT="test"
