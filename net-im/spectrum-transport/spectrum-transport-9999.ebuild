# Copyright 1999-2009 soul9.org
# Distributed under the terms of the WTFPL

inherit cmake-utils git

DESCRIPTION="A new xmpp transport based on libpurple"
HOMEPAGE="http://spectrum.im"

EGIT_REPO_URI="git://github.com/hanzz/${PN}.git"
EGIT_TREE="master"
EGIT_PROJECT="spectrum"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 "
IUSE="python"

RDEPEND="dev-libs/poco
	>=net-im/pidgin-2.6.0
	>=net-libs/gloox-1.0
	extras? (
		dev-lang/python
		dev-python/twisted
		dev-python/twisted-words
	)"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install () {
	cmake-utils_src_install
	if use python; then
		doexe "${WORKDIR}/${P}/tools/spectrumctl/spectrumctl" || die
	fi

#install init scripts and configs
	insinto /etc/spectrum
	for protocol in msn yahoo facebook icq myspace gg aim simple irc; do
		sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' "${FILESDIR}/spectrum.cfg" > "${WORKDIR}/spectrum-${protocol}.cfg"
		doins "${WORKDIR}/spectrum-${protocol}.cfg" || die

		sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' "${FILESDIR}/spectrum.init" > "${WORKDIR}/spectrum-${protocol}"
		doinitd "${WORKDIR}/spectrum-${protocol}" || die
	done
}
