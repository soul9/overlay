# Copyright 1999-2009 soul9.org
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git autotools

DESCRIPTION="A new DHT from the author of the PHELMFS in-kernel linux distributed filesystem with plans to integrate elliptics into POHELMFS"
HOMEPAGE="http://www.ioremap.net/projects/elliptics"

EGIT_REPO_URI="http://www.ioremap.net/git/elliptics.git"
EGIT_TREE="master"
EGIT_PROJECT="elliptics"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="bdb tokyocabinet fcgi perl libatomic"

RDEPEND="bdb? ( sys-libs/db )
                    tokyocabinet? ( dev-db/tokyocabinet )
                    fcgi? ( dev-libs/fcgi)
                    perl? ( dev-perl/dnet-perl )
                    libatomic? ( dev-libs/libatomic )"
#libatomic from ioremap projects
#perl bindings for cgi
#cgi

DEPEND=""

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
    dodoc example/EXAMPLE example/00-INDEX doc/design_notes.txt doc/io_storage_backend.txt
}