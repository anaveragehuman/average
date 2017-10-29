# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_6,2_7} )

inherit autotools eutils python-any-r1 xdg-utils

DESCRIPTION="A Bitcoin client offering a dozen innovative features not found anywhere else."
HOMEPAGE="https://github.com/goatpig/BitcoinArmory"
SRC_URI="https://github.com/goatpig/BitcoinArmory/releases/download/v${PV}/armory_${PV}_src.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="mirror"

COMMON_DEPEND="${PYTHON_DEPS}
			   dev-libs/crypto++
			   dev-libs/leveldb
			   dev-python/PyQt4[X]
			   dev-python/twisted"

DEPEND="${COMMON_DEPEND}
		>=dev-lang/swig-3.0.0
		x11-misc/xdg-utils"

RDEPEND="${COMMON_DEPEND}
		 dev-python/psutil"
S="${WORKDIR}/${PN}_${PV}-src"

src_prepare() {
	sed -i "s|python /usr/lib/|${EPYTHON} $( python_get_sitedir)/|" \
		dpkgfiles/*.desktop || die "failed to modify desktop entry exec parameter"
	eapply_user
	./autogen.sh || die "autogen script failed"
}

src_install() {
	eautomake install

	dodoc README.md

	domenu dpkgfiles/*.desktop
	validate_desktop_entries

	echo "python2 $(python_get_sitedir)/armory/ArmoryQt.py $*" > "${T}/armory"
	dobin "${T}/armory"
	dobin ArmoryDB
}

pkg_postinst() {
	xdg-icon-resource install --novendor --context apps --size 64 /usr/share/armory/img/armory_icon_64x64.png armoryicon
	xdg-icon-resource install --novendor --context apps --size 64 /usr/share/armory/img/armory_icon_64x64.png armoryofflineicon
	xdg-icon-resource install --novendor --context apps --size 64 /usr/share/armory/img/armory_icon_green_64x64.png armorytestneticon
}

pkg_postrm() {
	xdg_desktop_database_update
}
