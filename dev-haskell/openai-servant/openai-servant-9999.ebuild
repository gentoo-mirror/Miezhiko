# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_PN="${PN}"

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour"
inherit haskell-cabal git-r3

LIVE_EBUILD=yes

DESCRIPTION="Unofficial OpenAI servant types"
HOMEPAGE="https://github.com/agrafix/openai-hs#readme"
EGIT_REPO_URI="https://github.com/agrafix/openai-hs.git"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-haskell/aeson:=[profile?]
	dev-haskell/casing:=[profile?]
	dev-haskell/mime-types:=[profile?]
	dev-haskell/servant:=[profile?]
	dev-haskell/servant-auth:=[profile?]
	dev-haskell/servant-auth-client:=[profile?]
	dev-haskell/servant-multipart-api:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/vector:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
"

S="${WORKDIR}/${P}/${PN}"

src_prepare() {
	# no chance to link to -threaded on ppc64, alpha and others
	# who use UNREG, not only ARM
	if ! ghc-supports-threaded-runtime; then
		cabal_chdeps '-threaded' ' '
	fi
	eapply_user
}
