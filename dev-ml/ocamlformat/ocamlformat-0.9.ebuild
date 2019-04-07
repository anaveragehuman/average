# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit opam jbuilder

DESCRIPTION="Auto-formatter for OCaml code"
HOMEPAGE="https://github.com/ocaml-ppx/ocamlformat"
SRC_URI="https://github.com/ocaml-ppx/ocamlformat/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-ml/base-0.11.0
	dev-ml/cmdliner
	dev-ml/fpath
	>=dev-ml/ocaml-migrate-parsetree-1.0.10
	>=dev-ml/octavius-1.2.0
	dev-ml/stdio
	dev-ml/uutf
"

RDEPEND="${DEPEND}"
