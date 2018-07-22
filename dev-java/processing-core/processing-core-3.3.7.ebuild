# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
JAVA_PKG_IUSE="source"
JAVA_PKG_FORCE_VM="oracle-jdk-bin"	  # we need JavaFX
JAVA_ANT_REWRITE_CLASSPATH="true"

inherit java-pkg-2 java-ant-2

MY_PV="0264-${PV}"
MY_P="processing-${MY_PV}"

JOGL_SLOT=2.2

DESCRIPTION="Core libraries for Processing"
HOMEPAGE="https://www.processing.org/"
SRC_URI="https://github.com/processing/processing/archive/${MY_P}.tar.gz"

LICENSE="all-rights-reserved"  # actually not, TODO
SLOT="0"
KEYWORDS="~amd64 ~x86" # might also work on arm

CDEPEND="dev-java/gluegen:${JOGL_SLOT}
		 dev-java/jogl:${JOGL_SLOT}"
DEPEND="${CDEPEND}
		>=virtual/jdk-1.8
		>=dev-java/oracle-jdk-bin-1.8:1.8[javafx]"
RDEPEND="${CDEPEND}
		 >=virtual/jre-1.8
		 || ( >=dev-java/oracle-jdk-bin-1.8:1.8[javafx]
			  >=dev-java/oracle-jre-bin-1.8:1.8[javafx] )"

S="${WORKDIR}/processing-${MY_P}/core"
RESTRICT="mirror"

EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH="ant-core
					   gluegen:${JOGL_SLOT}
					   jogl:${JOGL_SLOT}"

src_prepare() {
	java-pkg_clean || die "Failed to remove bundled .jars"
	eapply_user

	# delete macos and Windows files for the time being
	java-pkg_rm_files "src/processing/core/ThinkDifferent.java"
}

src_install() {
	java-pkg_dojar "library/core.jar" #"methods/methods.jar"

	use source && java-pkg_dosrc "src/*" #"methods/src/*"
}
