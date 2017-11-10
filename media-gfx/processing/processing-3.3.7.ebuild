# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
JAVA_PKG_IUSE="doc examples source"
JAVA_PKG_FORCE_VM="oracle-jdk-bin"
JAVA_ANT_REWRITE_CLASSPATH="true"
WANT_ANT_TASKS="ant-antlr ant-eclipse-ecj:4.5"

inherit java-pkg-2 java-ant-2

MY_PV=0264-${PV}
MY_P=${PN}-${MY_PV}

JOGL_SLOT=2.3
NB_SLOT=8.2

DESCRIPTION="A flexible software sketchbook for a visual context programming language"
HOMEPAGE="https://www.processing.org/"
SRC_URI="https://github.com/processing/processing/archive/${MY_P}.tar.gz"

LICENSE="all-rights-reserved"  # actually not, TODO
SLOT="0"
KEYWORDS="~amd64 ~x86" # might also work on arm
IUSE="examples"

CDEPEND="dev-java/antlr:0
		 dev-java/ant-core:0
		 dev-java/batik:1.9
		 dev-java/gohai-jssc:0
		 dev-java/itext:0
		 dev-java/netbeans-platform:${NB_SLOT}
		 =dev-java/processing-core-${PV}:${SLOT}
		 =dev-java/processing-pde-${PV}:${SLOT}"
DEPEND="${CDEPEND}
		>=virtual/jdk-1.8
		>=dev-java/oracle-jdk-bin-1.8:1.8[javafx]"
RDEPEND="${CDEPEND}
		 >=virtual/jre-1.8
		 || ( >=dev-java/oracle-jdk-bin-1.8:1.8[javafx]
			  >=dev-java/oracle-jre-bin-1.8:1.8[javafx] )"

S="${WORKDIR}/processing-${MY_P}"
RESTRICT="mirror"

EANT_BUILD_TARGET="build"
EANT_BUILD_XML="build/build.xml"
EANT_DOC_TARGET="doc"
EANT_GENTOO_CLASSPATH="antlr
					   ant-core
					   batik:1.9
					   gohai-jssc
					   itext
					   processing-core
					   processing-pde"
EANT_GENTOO_CLASSPATH_EXTRA="/usr/share/netbeans-platform-${NB_SLOT}/modules/org-netbeans-swing-outline.jar"
EANT_NEEDS_TOOLS="yes"

#src_configure() {
#	java-ant-2_src_configure
#}
#
src_prepare() {
	java-pkg_clean || die "Failed to remove bundled .jars"
	epatch "${FILESDIR}/3.3.6-no-download-java.patch"
	epatch "${FILESDIR}/3.3.7-no-build-core.patch"
	eapply_user

	# we've already built dev-java/processing-core and dev-java/processing-pde
	find . -name "build.xml" -print0 | xargs -0 sed -i '/build the core library/d'
	find . -name "build.xml" -print0 | xargs -0 sed -i '/build app/d'
}

# TODO: We're missing Eclipse, particularly JDT. This is pretty much stalled
# until that can be found in the main tree, or in an overlay.
