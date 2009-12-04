# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gajim/gajim-0.12.1.ebuild,v 1.2 2009/04/28 15:00:04 jer Exp $

EAPI="2"

inherit multilib python eutils autotools mercurial

DESCRIPTION="Jabber client written in PyGTK"
HOMEPAGE="http://www.gajim.org/"
EHG_REPO_URI="http://hg.gajim.org/gajim"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="avahi dbus gnome idle libnotify nls spell srv trayicon X xhtml jingle"

DEPEND="|| (
		>=dev-lang/python-2.5[sqlite]
		( <dev-lang/python-2.5 dev-python/pysqlite )
	)
	dev-python/libasyncns-python
	dev-python/pygtk
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

RDEPEND="gnome? ( dev-python/gnome-python-extras
		dev-python/gnome-python-desktop
	)
	dbus? ( dev-python/dbus-python dev-libs/dbus-glib )
	libnotify? ( x11-libs/libnotify )
	xhtml? ( dev-python/docutils )
	srv? ( net-dns/bind-tools )
	idle? ( x11-libs/libXScrnSaver )
	spell? ( app-text/gtkspell )
	avahi? ( net-dns/avahi[dbus,gtk,python] )
         jingle? ( net-libs/farsight2[python] )
	dev-python/pyopenssl
	dev-python/sexy-python
	dev-python/pycrypto
         net-libs/farsight2[python]
         dev-python/libgnomecanvas-python
         dev-python/libgnome-python"

pkg_setup() {
	if ! use dbus; then
		if use libnotify; then
			eerror "The dbus USE flag is required for libnotify support"
			die "USE=\"dbus\" needed for libnotify support"
		fi
		if use avahi; then
			eerror "The dbus USE flag is required for avahi support"
			die "USE=\"dbus\" needed for avahi support"
		fi
	fi
}

src_prepare() {
    #why do we have to do this?
    cd gajim
    ./autogen.sh
#	eautoreconf
}

src_configure() {
    cd gajim
	local myconf

	if ! use gnome; then
		myconf="${myconf} $(use_enable trayicon)"
		myconf="${myconf} $(use_enable idle)"
	fi

	econf $(use_enable nls) \
		$(use_enable spell gtkspell) \
		$(use_enable dbus remote) \
		$(use_with X x) \
		--docdir="/usr/share/doc/${PF}" \
		--libdir="$(python_get_sitedir)" \
		${myconf} || die "econf failed"
}

src_install() {
    cd gajim
	emake DESTDIR="${D}" install || die "emake install failed"

	rm "${D}/usr/share/doc/${PF}/README.html"
	dohtml README.html
}

pkg_postinst() {
	python_mod_optimize $(python_get_sitedir)/gajim/
}

pkg_postrm() {
	python_mod_cleanup $(python_get_sitedir)/gajim/
}
