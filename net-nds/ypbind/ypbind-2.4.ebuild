# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools readme.gentoo-r1 systemd

MY_P=${PN}-mt-${PV}
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Multithreaded NIS bind service (ypbind-mt)"
HOMEPAGE="http://www.linux-nis.org/nis/ypbind-mt/index.html"
SRC_URI="http://www.linux-nis.org/download/ypbind-mt/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="nls systemd"

RDEPEND="
	net-libs/libtirpc:=
	>=net-nds/yp-tools-4
	systemd? (
		net-nds/rpcbind
		>=sys-apps/systemd-209 )
	!systemd? ( || ( net-nds/portmap net-nds/rpcbind ) )
"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.19.8 )
"

DOC_CONTENTS="
	If you are using dhcpcd, be sure to add the -Y option to
	dhcpcd_eth0 (or eth1, etc.) to keep dhcpcd from clobbering
	/etc/yp.conf.
"

PATCHES=( "${FILESDIR}"/${PN}-2.4-systemd.patch )

src_prepare() {
	sed -i -e 's/AM_GNU_GETTEXT_VERSION/AM_GNU_GETTEXT_VERSION(0.19.8)/' configure.ac || die
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable systemd)
}

src_install() {
	default

	insinto /etc
	newins etc/yp.conf yp.conf.example

	newconfd "${FILESDIR}/ypbind.confd-r1" ypbind
	newinitd "${FILESDIR}/ypbind.initd" ypbind
	use systemd && systemd_dounit "${FILESDIR}/ypbind.service"

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
