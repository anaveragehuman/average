# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple toolchain-funcs git-r3

MY_PN="java-simple-serial-connector"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="gohai's fork of the Java Simple Serial Connector"
HOMEPAGE="https://github.com/gohai/java-simple-serial-connector"
EGIT_REPO_URI="https://github.com/gohai/java-simple-serial-connector"
SRC_URI=""

LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"

IUSE=""

RDEPEND=">=virtual/jre-1.8
		 !!dev-java/jssc"

DEPEND=">=virtual/jdk-1.8
		source? ( app-arch/zip )"

PATCHES=(
	"${FILESDIR}/${PN}-library-load.patch"
)

S="${WORKDIR}/${P}"

src_prepare() {
	epatch "${PATCHES[@]}"
	eapply_user
}

src_compile() {
	java-pkg-simple_src_compile
	$(tc-getCXX) \
		${CPP_FLAGS} ${CXX_FLAGS} \
		-c -o ${PN}.o \
		-fPIC -Wall \
		-I$(java-config-2 -o)/include \
		-I$(java-config-2 -o)/include/linux \
		"${S}/src/cpp/_nix_based/jssc.cpp" || die

	$(tc-getCXX) \
		-Wl,-soname,libjssc.so \
		-shared -o "libjssc.so.${PV}" \
		-Wall "${PN}.o" || die
}

src_install() {
	java-pkg-simple_src_install
	dolib libjssc*
	dosym "libjssc.so.${PV}" /usr/$(get_libdir)/libjssc.so
}
