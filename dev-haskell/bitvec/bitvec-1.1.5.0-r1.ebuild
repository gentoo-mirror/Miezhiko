# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.8.5.1.9999

CABAL_HACKAGE_REVISION=1

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Space-efficient bit vectors"
HOMEPAGE="https://github.com/Bodigrim/bitvec"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE="+simd +gmp"

RDEPEND=">=dev-haskell/primitive-0.5:=[profile?]
	>=dev-haskell/vector-0.11:=[profile?] <dev-haskell/vector-0.14:=[profile?]
	>=dev-lang/ghc-9.0.2:=
	gmp? (
		dev-libs/gmp
	)
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
	test? ( >=dev-haskell/primitive-0.5 <dev-haskell/primitive-0.9
		>=dev-haskell/quickcheck-classes-0.6.1 <dev-haskell/quickcheck-classes-0.7
		<dev-haskell/quickcheck-classes-base-0.7
		<dev-haskell/tasty-1.6
		<dev-haskell/tasty-quickcheck-0.11 )
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag simd simd) \
		$(cabal_flag gmp libgmp)
}