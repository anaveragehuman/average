# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN='processing'
MY_PV="0265-${PV}"
MY_P="${MY_PN}-${MY_PV}"
DESCRIPTION="Visual context programming language"
HOMEPAGE="https://www.processing.org/"
SRC_URI="
	amd64? ( https://github.com/processing/processing/releases/download/${MY_P}/${MY_PN}-${PV}-linux64.tgz )
	x86? ( https://github.com/processing/processing/releases/download/${MY_P}/${MY_PN}-${PV}-linux32.tgz )
"

LICENSE="all-rights-reserved"  # actually not, TODO
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_P}"
RESTRICT="mirror strip"

src_install() {
	local dest=/opt/${MY_P}

	dodir "${dest}"
	insinto "${dest}"
	doins -r .

	dodir /usr/bin
	for command in processing processing-java ; do
		dosym "${dest}"/${command} /usr/bin/${command} || die
	done

	# Cannot use fperms with wildcards, it seems
	chmod a+x "${D}/${dest}"/java/bin/* || die
	chmod a+x "${D}/${dest}"/processing* || die
}
