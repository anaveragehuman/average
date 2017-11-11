# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit java-utils-2 java-pkg-2 java-pkg-simple

MY_PV="version_${PV}"
DESCRIPTION="Open Source Physics Core Library"
HOMEPAGE="https://www.compadre.org/osp/"
SRC_URI="https://github.com/OpenSourcePhysics/osp/archive/${MY_PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"
DEPEND=">=virtual/jdk-1.7"
RDEPEND=">=virtual/jre-1.7"
S="${WORKDIR}/osp-${MY_PV}"

JAVA_ENCODING="ISO-8859-1"
JAVA_SRC_DIR="${S}/src/org/"

src_prepare() {
	GENERALPATH=(${JAVA_SRC_DIR}/opensourcephysics/{display/{Grid,Dataset,FunctionDrawer},media/core/T{Vector,CoordAxes}}.java)
	for i in "${GENERALPATH[@]}"; do
		sed -i -e "s|protected GeneralPath g|public GeneralPath g|" "$i" || die "sed failed"
	done

	sed -i -e "s|GeneralPath g|public GeneralPath g|" "${JAVA_SRC_DIR}/opensourcephysics/display/Trail.java" || die "sed failed"
	eapply_user
}
