# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.4.0.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Parsers for types in 'time'"
HOMEPAGE="https://github.com/phadej/time-parsers#readme"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND=">=dev-haskell/parsers-0.12.2.1:=[profile?] <dev-haskell/parsers-0.13:=[profile?]
	>=dev-lang/ghc-8.10.6:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.2.1.0
	test? ( >=dev-haskell/attoparsec-0.12.1.6 <dev-haskell/attoparsec-0.15
		>=dev-haskell/bifunctors-4.2.1 <dev-haskell/bifunctors-5.7
		>=dev-haskell/parsec-3.1.9 <dev-haskell/parsec-3.2
		>=dev-haskell/parsers-0.12.3 <dev-haskell/parsers-0.13
		>=dev-haskell/tasty-0.10.1.2 <dev-haskell/tasty-1.5
		>=dev-haskell/tasty-hunit-0.9.2 <dev-haskell/tasty-hunit-0.11
		dev-haskell/text )
"