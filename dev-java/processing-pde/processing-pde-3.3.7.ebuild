# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
JAVA_PKG_IUSE="source"
JAVA_ANT_REWRITE_CLASSPATH="true"

inherit java-pkg-2 java-ant-2

MY_PV="0264-${PV}"
MY_P="processing-${MY_PV}"

DESCRIPTION="The Processing PDE"
HOMEPAGE="https://www.processing.org/"
SRC_URI="https://github.com/processing/processing/archive/${MY_P}.tar.gz"

LICENSE="all-rights-reserved"  # actually not, TODO
SLOT="0"
KEYWORDS="~amd64 ~x86" # might also work on arm

CDEPEND="dev-java/jna:0
		 =dev-java/processing-core-${PV}"
DEPEND="${CDEPEND}
		>=virtual/jdk-1.8"
RDEPEND="${CDEPEND}
		 >=virtual/jre-1.8"

S="${WORKDIR}/processing-${MY_P}/app"
RESTRICT="mirror"

EANT_BUILD_TARGET="build"
EANT_GENTOO_CLASSPATH="jna
					   processing-core"

src_prepare() {
	java-pkg_clean || die "Failed to remove bundled .jars"
	eapply_user

	# we've already built dev-java/processing-core
	find . -name "build.xml" -print0 | xargs -0 sed -i '/Please build the core library first/d'

	# delete macos and Windows files for the time being
	java-pkg_rm_files "src/processing/app/platform/MacPlatform.java" \
					  "src/processing/app/platform/ThinkDifferent.java" \
					  "src/processing/app/platform/WindowsPlatform.java"
}

src_install() {
	java-pkg_dojar "pde.jar"

	use source && java-pkg_dosrc "src/*"
}
