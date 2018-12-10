# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=(python2_7 python3_6)

inherit distutils-r1

DESCRIPTION="A python client library for Google Play Services OAuth"
HOMEPAGE="https://github.com/simon-weber/gpsoauth"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-python/requests[${PYTHON_USEDEP}]
	dev-python/pycryptodome[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]"

src_prepare() {
	# revert https://github.com/simon-weber/gpsoauth/pull/12
	sed -i 's/pycryptodomex/pycryptodome/' setup.py || die
	sed -i 's/Cryptodome/Crypto/' gpsoauth/google.py || die
	default
}
