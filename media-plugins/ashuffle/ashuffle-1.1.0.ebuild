# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Automatic library-wide shuffle for mpd"
HOMEPAGE="https://github.com/joshkunz/ashuffle"
SRC_URI="https://github.com/joshkunz/ashuffle/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="media-libs/libmpdclient"
RDEPEND="${DEPEND}"

src_install() {
	dobin ashuffle
	dodoc readme.md
}
