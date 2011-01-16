EAPI="2"

inherit git eutils qt4

DESCRIPTION="Heimdall is a cross-platform open-source tool suite used to flash firmware (aka ROMs) onto Samsung Galaxy S devices."
HOMEPAGE="http://www.glassechidna.com.au/products/heimdall/"

EGIT_REPO_URI="git://github.com/Benjamin-Dobell/Heimdall.git"
EGIT_TREE="master"
EGIT_PROJECT="Heimdall"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE="frontend"

RDEPEND="
    frontend? ( >=x11-libs/qt-gui-4.6 )
    >dev-libs/libusb-1.0
    dev-util/pkgconfig
"

DEPEND="$RDEPEND"

src_unpack() {
    git_src_unpack
}

src_configure() {
    cd heimdall
    econf --prefix=/usr/ --libdir=/usr/$(get_libdir) || die "econf failed"
    cd ..
    if use frontend; then
        cd heimdall-frontend
        OUTPUTDIR="${D}" eqmake4 heimdall-frontend.pro
        cd ..
    fi
}

src_compile() {
    cd heimdall
    emake DESTDIR="${D}"|| die "compile failed"
    cd ..
    if use frontend; then
        cd heimdall-frontend
        emake OUTPUTDIR="${D}"|| die "compile failed"
        cd ..
    fi

}

src_install() {
    cd heimdall
    sed '/sudo service udev reload/d' Makefile > Makefile.new ||die "Couldn't patch Makefile"
    mv Makefile.new Makefile
    emake DESTDIR="${D}" install || die "install failed"
    cd ..
    if use frontend; then
        cd heimdall-frontend
        emake OUTPUTDIR="${D}" install|| die "compile failed"
        cd ..
    fi
}

pkg_postinst() {
    /etc/init.d/udev restart
}
