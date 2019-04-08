# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_{5,6} pypy pypy3 )

inherit distutils-r1
DESCRIPTION="Python parser for bash"
HOMEPAGE="https://github.com/idank/bashlex"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

RDEPEND=""
DEPEND="
	${RDEPEND}
	virtual/python-enum34[${PYTHON_USEDEP}]
"

python_install_all() {
	use doc && local DOCS=( README.md )
	distutils-r1_python_install_all
}
