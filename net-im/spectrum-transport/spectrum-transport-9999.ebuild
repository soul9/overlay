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

DEPEND=">=dev-libs/poco-1.3.3
                    >=net-im/pidgin-2.6.0
                     sys-devel/gettext
                     >=net-libs/gloox-1.0
                     extras? (
                         dev-python/twisted
                         dev-python/twisted-words
                     )"
RDEPEND="${DEPEND}"

src_unpack () {
    git_src_unpack
    cd "${S}"
}

src_install () {
    cmake-utils_src_install
    cp tools/spectrumctl/spectrumctl.py ${D}/usr/bin/spectrumctl && chmod ug+x ${D}/usr/bin/spectrumctl && chgrp jabber ${D}/usr/bin/spectrumctl
    if use extras; then
        cp tools/stats/stats.py ${D}/usr/bin/spectrumstats && chmod ug+x ${D}/usr/bin/spectrumstats && chgrp jabber ${D}/usr/bin/spectrumstats
    fi
}
