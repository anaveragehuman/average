# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
USE_RUBY="ruby23 ruby24 ruby25"

inherit ruby-fakegem

DESCRIPTION="A tool to check markdown files and flag style issues."
HOMEPAGE="https://github.com/markdownlint/markdownlint"
SRC_URI="https://github.com/markdownlint/markdownlint/archive/v${PV}.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RESTRICT="mirror"

ruby_add_rdepend "
	>=dev-ruby/kramdown-1.12.0
	>=dev-ruby/mixlib-config-2.2.1
	>=dev-ruby/mixlib-cli-1.7.0"
