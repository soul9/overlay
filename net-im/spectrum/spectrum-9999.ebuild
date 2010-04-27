# Copyright 1999-2009 soul9.org
# Distributed under the terms of the WTFPL
EAPI="2"

inherit cmake-utils git

DESCRIPTION="A new xmpp transport based on libpurple"
HOMEPAGE="http://spectrum.im"

EGIT_PROJECT="${PN}"
EGIT_REPO_URI="git://github.com/hanzz/${EGIT_PROJECT}.git"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 "

PURPLE_PROTOCOLS="qq"

IUSE="msn yahoo facebook icq myspace gg aim simple irc ${PURPLE_PROTOCOLS} mysql sqlite"

RDEPEND="dev-libs/poco
	>=net-im/pidgin-2.6.0[qq?]
	>=net-libs/gloox-1.0"
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install () {
	cmake-utils_src_install

	#install init scripts and configs
	insinto /etc/spectrum
	for protocol in msn yahoo facebook icq myspace gg aim simple irc $PURPLE_PROTOCOLS; do
		if use $protocol; then
			sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' "${FILESDIR}/spectrum.cfg" > "${WORKDIR}/spectrum-${protocol}.cfg" || die
			doins "${WORKDIR}/spectrum-${protocol}.cfg" || die

			sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' "${FILESDIR}/spectrum.init" > "${WORKDIR}/spectrum-${protocol}" || die
			doinitd "${WORKDIR}/spectrum-${protocol}" || die
		fi
	done

	# install SQL schemas and tools
	insinto /usr/share/spectrum/schemas
	doins schemas/*
	insinto /usr/share/spectrum/tools
	doins tools/*
}
