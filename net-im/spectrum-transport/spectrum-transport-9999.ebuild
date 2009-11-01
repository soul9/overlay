# Copyright 1999-2009 soul9.org
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git cmake-utils

DESCRIPTION="a new xmpp transport based on libpurple"
HOMEPAGE="http://spectrum.im"

EGIT_REPO_URI="git://github.com/hanzz/spectrum.git"
EGIT_TREE="master"
EGIT_PROJECT="spectrum"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="extras"


RDEPEND=">=dev-libs/poco-1.3.3
                  >=net-im/pidgin-2.6.0
                  >=net-libs/gloox-1.0
                  extras? (
                      dev-python/twisted
                      dev-python/twisted-words
                  )"
DEPEND="${RDEPEND}
                  sys-devel/gettext"

src_unpack () {
    git_src_unpack
}

src_install () {
    cmake-utils_src_install
    newexe ${WORKDIR}/${P}/tools/spectrumctl/spectrumctl.py spectrumctl || die
#install stats
    if use extras; then
        newexe ${WORKDIR}/${P}/tools/stats/stats.py spectrumstats || die
    fi
#install init scripts and configs
    for protocol in msn yahoo facebook icq myspace gg aim  simple irc; do
        sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' ${FILESDIR}/spectrum.cfg > ${WORKDIR}/spectrum-${protocol}.cfg
        insinto /etc/spectrum
        doins ${WORKDIR}/spectrum-${protocol}.cfg || die

        sed -e 's,SPECTRUMGEN2PROTOCOL,'${protocol}',g' ${FILESDIR}/spectrum.init > ${WORKDIR}/spectrum-${protocol}
        doinitd ${WORKDIR}/spectrum-${protocol} || die
    done
}

