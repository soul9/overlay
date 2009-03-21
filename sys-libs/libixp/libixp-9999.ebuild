# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/v4l-dvb-hg/v4l-dvb-hg-0.1-r2.ebuild,v 1.15 2008/05/21 13:30:44 zzam Exp $

: ${EHG_REPO_URI:=${V4L_DVB_HG_REPO_URI:-http://linuxtv.org/hg/v4l-dvb}}

inherit eutils toolchain-funcs

DESCRIPTION="live development version of libixp"
SRC_URI=""
HOMEPAGE="http://"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

S="${WORKDIR}/${EHG_REPO_URI##*/}/libixp"

src_unpack() {
	# download and copy files
	mercurial_src_unpack

	cd "${S}"

	# apply local patches
	if test -n "${LIBIXP_LOCAL_PATCHES}";
	then
		ewarn "Applying local patches:"
		for LOCALPATCH in ${DVB_LOCAL_PATCHES};
		do
			if test -f "${LOCALPATCH}";
			then
				if grep -q linux/drivers "${LOCALPATCH}"; then
					cd "${S}"/..
				else
					cd "${S}"
				fi
				epatch "${LOCALPATCH}"
			fi
		done
	else
		einfo "No additional local patches to use"
	fi
	
    sed -i \
           -e "/^PREFIX/s|=.*|= ${D}/usr|" \
           -e "/^ETC/s|=.*|= ${D}/etc|" \
           -e "/^CFLAGS/s|=|+=|" \
           -e "/^LDFLAGS/s|=|+=|" \
           config.mk || die "sed failed"

}

src_compile() {
        emake -j1 || die "emake failed"
}

src_install() {
        emake -j1 DESTDIR="${D}" install || die "emake install failed"
}
