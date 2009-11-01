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
IUSE="extras msn yahoo facebook"


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
    exeinto /usr/bin
    newexe ${WORKDIR}/${P}/tools/spectrumctl/spectrumctl.py spectrumctl || exit 1
#install stats
    if use extras; then
        newexe ${WORKDIR}/${P}/tools/stats/stats.py spectrumstats || exit 1
    fi
#install init scripts and configs
    if use msn; then
        sed -e 's,SPECTRUMGEN2PROTOCOL,msn,g' ${FILESDIR}/spectrum.cfg > ${WORKDIR}/spectrum-msn.cfg
        insinto /etc/spectrum
        newins ${WORKDIR}/spectrum-msn.cfg spectrum-msn.cfg || exit 1

        sed -e 's,SPECTRUMGEN2PROTOCOL,msn,g' ${FILESDIR}/spectrum.init > ${WORKDIR}/spectrum-msn
        doinitd ${WORKDIR}/spectrum-msn || exit 1
    fi
    if use yahoo; then
        sed -e 's,SPECTRUMGEN2PROTOCOL,yahoo,g' ${FILESDIR}/spectrum.cfg > ${WORKDIR}/spectrum-yahoo.cfg
        insinto /etc/spectrum
        newins ${WORKDIR}/spectrum-yahoo.cfg spectrum-yahoo.cfg || exit 1

        sed -e 's,SPECTRUMGEN2PROTOCOL,yahoo,g' ${FILESDIR}/spectrum.init > ${WORKDIR}/spectrum-yahoo
        doinitd ${WORKDIR}/spectrum-yahoo || exit 1
    fi
    if use facebook; then
         sed 's,SPECTRUMGEN2PROTOCOL,facebook,g' ${FILESDIR}/spectrum.cfg > ${WORKDIR}/spectrum-facebook.cfg
         insinto /etc/spectrum
         newins ${WORKDIR}/spectrum-facebook.cfg spectrum-facebook.cfg || exit 1

         sed 's,SPECTRUMGEN2PROTOCOL,facebook,g' ${FILESDIR}/spectrum.init > ${WORKDIR}/spectrum-facebook
         doinitd ${WORKDIR}/spectrum-facebook || exit 1
    fi
}

