# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
JAVA_ANT_REWRITE_CLASSPATH="true"
JAVA_PKG_IUSE="doc"
WANT_ANT_TASKS="ant-contrib"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Decode and encode a variety of media file formats directly from Java"
HOMEPAGE="http://www.xuggle.com/xuggler"
SRC_URI="https://github.com/artclarke/xuggle-${PN}/archive/xuggle-${P}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64"

CDEPEND="dev-java/commons-cli:1"
RDEPEND="${CDEPEND}
		 >=virtual/jre-1.6" #dev-java/logback?
DEPEND="${CDEPEND}
		>=dev-java/ant-1.7
		dev-java/javatoolkit
		dev-java/slf4j-api:0
		>=dev-lang/perl-5.6
		>=dev-lang/yasm-0.7
		>=virtual/jdk-1.6
		virtual/pkgconfig"

S="${WORKDIR}/xuggle-${PN}-xuggle-${P}"
RESTRICT="mirror"

EANT_BUILD_TARGET="stage-java"
EANT_DOC_TARGET="doc-java"
EANT_GENTOO_CLASSPATH="commons-cli:1
					   slf4j-api"

src_prepare() {
	java-pkg_clean
	epatch "${FILESDIR}/5.3-no-ivy.patch"
	epatch "${FILESDIR}/5.3-no-proguard.patch"
	epatch "${FILESDIR}/5.3-system-libs.patch"
	mkdir -p "${S}"/build/lib/{compile,test,default}
	eapply_user
}

src_configure() {
	java-ant_bsfix_files "mk/buildtools/buildhelper.xml"
}

src_install() {
	java-pkg_dojar "${S}/dist/lib/xuggle-${PN}.jar"
}
