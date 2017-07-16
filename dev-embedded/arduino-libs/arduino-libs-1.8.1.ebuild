# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DK_V="20120606"
CS_P="CapacitiveSensor"
CS_V="0.5.1"

MY_P="Arduino"
DESCRIPTION="An open-source AVR electronics prototyping platform"
HOMEPAGE="http://arduino.cc/ https://arduino.googlecode.com/"
SRC_URI="https://github.com/arduino/${MY_P}/archive/${PV}.tar.gz -> arduino-${PV}.tar.gz
		 https://dl-ssl.google.com/android/adk/adk_release_${DK_V}.zip -> adk-${DK_V}.zip
		 https://github.com/PaulStoffregen/${CS_P}/archive/${CS_V}.tar.gz -> ${CS_P}-${CS_V}.tar.gz"
LICENSE="GPL-2 GPL-2+ LGPL-2 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND=""
DEPEND=""

S="${WORKDIR}"

# TODO: Use stripper provided by crossdev instead.
# TODO: Look into world writable issue.

src_install() {
	insinto "/usr/share/arduino/"
	doins -r "${MY_P}-${PV}"/{hardware,libraries}

	insinto "/usr/share/arduino/libraries"
	mv "${CS_P}-${CS_V}" "${CS_P}"
	doins -r "${CS_P}" "ADK_release_${DK_V}/arduino_libs/"{USB_Host_Shield,AndroidAccessory}

	insinto "/usr/share/arduino/hardware/adk"
	doins -r "ADK_release_${DK_V}/hardware/"{eng,fab}
	fowners -R root:uucp "/usr/share/arduino/hardware"

	dosym /usr/bin/avrdude "/usr/share/arduino/hardware/tools/avrdude"
	dosym /etc/avrdude.conf "/usr/share/arduino/hardware/tools/avrdude.conf"

	mkdir -p "${D}/usr/share/arduino/hardware/tools/avr/etc/"
	dosym /etc/avrdude.conf "/usr/share/arduino/hardware/tools/avr/etc/avrdude.conf"
}
