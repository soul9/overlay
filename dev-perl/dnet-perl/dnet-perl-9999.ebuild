# Copyright 1999-2009 soul9.org
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git perl-module

DESCRIPTION="Perl bindings for the elliptics DHT network."
HOMEPAGE="http://www.ioremap.net/projects/elliptics"

EGIT_REPO_URI="http://www.ioremap.net/git/dnet_perl.git"
EGIT_TREE="master"
EGIT_PROJECT="dnet_perl"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_unpack() {
    git_src_unpack
}
