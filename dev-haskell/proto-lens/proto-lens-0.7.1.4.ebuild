# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="A lens-based implementation of protocol buffers in Haskell"
HOMEPAGE="https://github.com/google/proto-lens#readme"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/lens-family-1.2:=[profile?] <dev-haskell/lens-family-2.2:=[profile?]
	>=dev-haskell/parsec-3.1:=[profile?] <dev-haskell/parsec-3.2:=[profile?]
	>=dev-haskell/primitive-0.6:=[profile?] <dev-haskell/primitive-0.9:=[profile?]
	>=dev-haskell/profunctors-5.2:=[profile?] <dev-haskell/profunctors-6.0:=[profile?]
	>=dev-haskell/tagged-0.8:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/text-1.2:=[profile?] <dev-haskell/text-2.2:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
	test? ( dev-haskell/quickcheck
		dev-haskell/tasty
		dev-haskell/tasty-quickcheck )
"