# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/nautilus/nautilus-2.26.3.ebuild,v 1.2 2009/05/30 23:41:18 ranger Exp $

EAPI="2"

inherit gnome2 eutils virtualx

DESCRIPTION="A firewall administration tool for the GNOME desktop"
HOMEPAGE="http://www.fs-security.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

# not adding gnome-base/gail because it is in gtk+
RDEPEND=">gnome-base/libgnome-2.0
         >gnome-base/libgnomeui-2.0"
DEPEND="${RDEPEND}"

SRC_URI="http://prdownloads.sourceforge.net/firestarter/${P}.tar.gz"
