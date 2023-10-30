# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_PN="dart-sdk"

DESCRIPTION="A client-optimized langauge for fast apps on any platform"
HOMEPAGE="https://dart.dev/"

BASE_URI="https://storage.googleapis.com/dart-archive/channels/stable/release/${PV}/sdk"
SRC_URI="
amd64? ( ${BASE_URI}/dartsdk-linux-x64-release.zip -> dartsdk-linux-x64-${PV}.zip )
	arm? ( ${BASE_URI}/dartsdk-linux-arm-release.zip -> dartsdk-linux-arm-${PV}.zip  )
	arm64? ( ${BASE_URI}/dartsdk-linux-arm64-release.zip -> dartsdk-linux-arm64-${PV}.zip )
	x86? ( ${BASE_URI}/dartsdk-linux-ia32-release.zip -> dartsdk-linux-ia32-release-${PV}.zip )
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="-* ~amd64"

BDEPEND="app-arch/unzip"

S="${WORKDIR}/${MY_PN}"

src_install() {

	mkdir -p "${ED}/opt/bin" || die
	mv "${S}" "${ED}/opt/" || die
	dosym "../$MY_PN/bin" "/opt/bin/$MY_PN"
}
