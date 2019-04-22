# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PN=${PN/-bin/}

inherit desktop

# See https://dl.pstmn.io/changelog for new versions

DESCRIPTION="Supercharge your API workflow"
HOMEPAGE="https://www.getpostman.com/"
SRC_URI="
	x86? ( https://dl.pstmn.io/download/version/${PV}/linux32 -> ${P}-32bit.tar.gz )
	amd64? ( https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}-64bit.tar.gz )
"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""

RDEPEND="
	media-video/ffmpeg[chromium]
"
DEPEND="${RDEPEND}"

RESTRICT="mirror"
QA_PREBUILT="
	opt/postman/libnode.so
	opt/postman/Postman
"

S="${WORKDIR}/Postman"

src_install() {
	local find_exp="-or -name"
	local find_name=()
	for match in "AUTHORS*" "CHANGELOG*" "CONTRIBUT*" "README*" ".travis.yml" \
		".eslint*" ".wercker.yml" ".npmignore" "*.md" "*.markdown" "*.bat" \
		"*.cmd"; do
		find_name+=( ${find_exp} "${match}" )
	done

	find app/resources/app/node_modules \
		\( -type d -name examples \) -or \( -type f \
		\( -iname "LICEN?E*" "${find_name[@]}" \) \) -exec rm -rf "{}" \;

	rm app/libffmpeg.so

	insinto "/opt/${MY_PN}"
	doins -r app/*

	exeinto "/opt/${MY_PN}"
	doexe Postman

	dosym ../../opt/postman/Postman "${EPREFIX}/usr/bin/${MY_PN}"

	cat > 99postman-bin <<-EOF
		LDPATH=${EROOT%/}/opt/postman:${EROOT%/}/usr/$(get_libdir)/chromium
	EOF
	doenvd 99postman-bin

	newicon -s 128 "${S}/app/resources/app/assets/icon.png" postman.png

	make_desktop_entry "postman" \
		"Postman" \
		"/usr/share/icons/hicolor/128x128/apps/postman.png" \
		"Development"
}
