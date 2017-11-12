# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-pkg-2 java-pkg-simple

MY_PV="version_${PV}"
DESCRIPTION="Video engine support for Open Source Physics programs"
HOMEPAGE="https://physlets.org/tracker/"
SRC_URI="https://github.com/OpenSourcePhysics/video-engines/archive/${MY_PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
DEPEND=">=virtual/jdk-1.7
		"
RDEPEND=">=virtual/jre-1.7"
S="${WORKDIR}/osp-${MY_PV}"

JAVA_ENCODING="ISO-8859-1"
JAVA_SRC_DIR="${S}/src/org/"

src_prepare() {
	java-pkg_clean
	eapply_user
}
