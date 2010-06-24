# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#inherit autotools

DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI="mirror://sourceforge/fprint/${P}-pre2.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-libs/libusb
	media-gfx/imagemagick"

src_compile () {
  cd ${WORKDIR}/libfprint-0.1.0-pre2
  pwd
  econf
  emake
}

src_install () {
  cd ${WORKDIR}/libfprint-0.1.0-pre2
  emake DESTDIR="${D}" install
}

