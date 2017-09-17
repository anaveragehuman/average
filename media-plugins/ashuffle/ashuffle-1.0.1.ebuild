# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Automatic library-wide shuffle for mpd"
HOMEPAGE="https://github.com/joshkunz/ashuffle"
SRC_URI="https://github.com/joshkunz/ashuffle/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND=""
RDEPEND="media-libs/libmpdclient"

DOCS=()

PATCHES=()

src_install() {
	dobin ashuffle
	dodoc readme.md
}
