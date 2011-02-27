# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the WTFPL
# $Header: $

inherit eutils multilib toolchain-funcs mercurial

DESCRIPTION="X11 draw library"
HOMEPAGE="http://tools.suckless.org/"
EHG_REPO_URI="http://hg.suckless.org/libdraw.old/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
    sed 's,PREFIX = /usr/local,PREFIX = /usr,' config.mk > config.mk.new && \
        mv config.mk.new config.mk
    emake -j1 || die "emake failed"
}

src_install() {
    emake DESTDIR="${D}" install || die "emake install failed"
}
