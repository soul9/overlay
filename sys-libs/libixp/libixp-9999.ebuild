# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-dvb-hg/v4l-dvb-hg-0.1-r2.ebuild,v 1.15 2008/05/21 13:30:44 zzam Exp $

: ${EHG_REPO_URI:=${LIBIXP_HG_REPO_URI:-http://code.suckless.org/hg/libixp}}

inherit toolchain-funcs mercurial

DESCRIPTION="live development version of libixp"
SRC_URI=""
HOMEPAGE="http://libs.suckless.org/libixp"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"
IUSE=""

S="${WORKDIR}/libixp"

src_compile() {
        emake -j1 || die "emake failed"
}

src_install() {
        PREFIX=/usr emake -j1 DESTDIR="${D}" install || die "emake install failed"
}
