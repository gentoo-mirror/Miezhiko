# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999
#hackport: flags: -it
# Integration tests fail expecting a server running on localhost

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Kafka bindings for Haskell"
HOMEPAGE="https://github.com/haskell-works/hw-kafka-client"

LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="examples it"

RDEPEND="dev-haskell/bifunctors:=[profile?]
	dev-haskell/text:=[profile?]
	>=dev-lang/ghc-8.10.6:=
	dev-libs/librdkafka
"
DEPEND="${RDEPEND}
	dev-haskell/c2hs
	>=dev-haskell/cabal-3.2.1.0
	test? ( dev-haskell/either
		dev-haskell/hspec
		dev-haskell/monad-loops
		it? ( dev-haskell/random ) )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples examples) \
		--flag=-it
}
src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples examples) \
		$(cabal_flag it it)
}
