# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit unpacker eutils

DESCRIPTION="A beautiful cross platform Desktop Player for Google Play Music"
HOMEPAGE="http://www.googleplaymusicdesktopplayer.com"

SRC_URI_AMD64="https://github.com/MarshallOfSound/Google-Play-Music-Desktop-Player-UNOFFICIAL-/releases/download/v${PV}/google-play-music-desktop-player_${PV}_amd64.deb"
SRC_URI_X86="https://github.com/MarshallOfSound/Google-Play-Music-Desktop-Player-UNOFFICIAL-/releases/download/v${PV}/google-play-music-desktop-player_${PV}_i386.deb"
SRC_URI="
		amd64? ( ${SRC_URI_AMD64} )
		x86? ( ${SRC_URI_X86} )
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
RDEPEND="gnome-base/gconf"

S="${WORKDIR}"


src_unpack() {
	unpack_deb ${A}
}

src_install() {
	cp -R "${WORKDIR}/usr" "${D}" || die "install failed!"
}
