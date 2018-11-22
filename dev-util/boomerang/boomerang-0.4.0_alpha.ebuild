# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

MY_PV=${PV/_/-}

DESCRIPTION="A general, open source, retargetable decompiler of machine code programs"
HOMEPAGE="https://github.com/BoomerangDecompiler/boomerang"
SRC_URI="https://github.com/BoomerangDecompiler/${PN}/archive/v${MY_PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"
S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	sed -i 's/-Werror.*)/)/' cmake-scripts/boomerang-flags.cmake || die # workaround for upstream bug
	default
}
