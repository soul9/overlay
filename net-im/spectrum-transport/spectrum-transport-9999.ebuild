# Copyright 1999-2009 soul9.org
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git make-utils

DESCRIPTION="a new xmpp transport based on libpurple"
HOMEPAGE="http://spectrum.im"

EGIT_REPO_URI="http://spectrum.im"
EGIT_TREE="master"
EGIT_PROJECT="spectrum"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/poco-1.3.3
                    >=net-im/pidgin-2.6.0
                     sys-devel/gettext
                     >net-libs/gloox-1.0_beta7"
RDEPEND="${DEPEND}"