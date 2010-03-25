# Copyright 1999-2009 soul9.org
# Distributed under the terms of the WTFPL

inherit cmake-utils

DESCRIPTION="A new xmpp transport based on libpurple"
HOMEPAGE="http://spectrum.im"

SRC_URI="http://cloud.github.com/downloads/hanzz/spectrum/spectrum-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 "

RDEPEND="dev-libs/poco
	>=net-im/pidgin-2.6.0
	>=net-libs/gloox-1.0"
DEPEND="${RDEPEND}
	sys-devel/gettext"


src_unpack() {
    unpack ${A}
    mv hanzz-spectrum-744fe5e spectrum-transport-0.1
}

src_install () {
	cmake-utils_src_install

	#install init scripts and configs
	insinto /etc/spectrum
	for protocol in msn yahoo facebook icq myspace gg aim simple irc; do
		sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' "${FILESDIR}/spectrum.cfg" > "${WORKDIR}/spectrum-${protocol}.cfg" || die
		doins "${WORKDIR}/spectrum-${protocol}.cfg" || die

		sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' "${FILESDIR}/spectrum.init" > "${WORKDIR}/spectrum-${protocol}" || die
		doinitd "${WORKDIR}/spectrum-${protocol}" || die
	done
}
