# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/wmii/wmii-3.6-r2.ebuild,v 1.1 2008/04/24 08:07:50 omp Exp $

: ${EHG_REPO_URI:=${wmii_HG_REPO_URI:-http://code.suckless.org/hg/wmii}}

inherit multilib toolchain-funcs mercurial

DESCRIPTION="A dynamic window manager for X11, live ebuild"
HOMEPAGE="http://www.suckless.org/wiki/wmii"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

DEPEND=">=sys-libs/libixp-9999
	x11-libs/libX11"
RDEPEND="${DEPEND}
	x11-apps/xmessage
	x11-apps/xsetroot
	=x11-misc/dmenu-9999
	app-text/txt2tags"

S="${WORKDIR}/wmii"

src_unpack() {
	mercurial_src_unpack

	cd "${S}"

	sed -i -e "s/dmenu -b/dmenu/" \
		rc/{rc.wmii.rc,sh.wmii,wmiirc.sh} || die "sed failed"

	sed -i \
		-e "/^PREFIX/s|=.*|= /usr|" \
		-e "/^  ETC/s|=.*|= /etc|" \
		-e "/^  LIBDIR/s|=.*|= /usr/$(get_libdir)|" \
		config.mk || die "sed failed"
#		-e "/^LIBIXP/s|=.*|= /usr/lib/libixp.a|" \

}

src_compile() {
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"

	# Rid paths of temporary install directory. (bug #199551)
	for f in usr/bin/wihack usr/bin/wmiistartrc usr/share/man/man1/wmii.1; do
        sed -i -e "s,${D},,g" ${D}/$f
    done
    ls ${D}

	dodoc NOTES README TODO

	echo -e "#!/bin/sh\n/usr/bin/wmii" > "${T}/${PN}"
	exeinto /etc/X11/Sessions
	doexe "${T}/${PN}"
}
