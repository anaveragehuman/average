# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 java-pkg-simple

MY_PV="version_${PV}"
DESCRIPTION="Video analysis/modeling tool built on the Open Source Physics framework"
HOMEPAGE="https://physlets.org/tracker/"
SRC_URI="https://github.com/OpenSourcePhysics/tracker/archive/${MY_PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
IUSE="+video-engines"

CP_DEPEND="dev-java/osp-core:0 "
DEPEND="${CP_DEPEND}
		>=virtual/jdk-1.7"
RDEPEND="${CP_DEPEND}
		 >=virtual/jre-1.7"
S="${WORKDIR}/${PN}-${MY_PV}"

JAVA_SRC_DIR="${S}/src/org"

src_prepare() {
	use video-engines && JAVA_GENTOO_CLASSPATH+=" osp-video-engines"
	java-pkg_clean

	# remove OSX specific files
	rm "${S}"/src/org/opensourcephysics/cabrillo/tracker/deploy/OSXServices.java
	eapply_user
}

src_install() {
	java-pkg-simple_src_install
	java-pkg_dolauncher tracker --jar tracker.jar \
		--main org.opensourcephysics.cabrillo.tracker.deploy.TrackerStarter
}
