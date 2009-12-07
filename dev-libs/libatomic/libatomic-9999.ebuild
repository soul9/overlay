# Copyright 1999-2009 soul9.org
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git autotools

DESCRIPTION="Libatomic provides arch-independant API for the low-level atomic implementation."
HOMEPAGE="http://www.ioremap.net/projects/libatomic"

EGIT_REPO_URI="http://www.ioremap.net/git/libatomic.git"
EGIT_TREE="master"
EGIT_PROJECT="libatomic"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_unpack() {
    git_src_unpack
}

src_prepare() {
    eautoreconf || die "eautoreconf failed"
}

src_configure() {
    econf --prefix=/usr/ --libdir=/usr/$(get_libdir) || die "econf failed"
}

src_compile() {
    emake DESTDIR="${D}"|| die "compile failed"
}

src_install() {
    emake DESTDIR="${D}" install || die "install failed"
}