inherit toolchain-funcs eutils

DESCRIPTION="Decentralised distributed filesystem"
HOMEPAGE="http://xtreemfs.org"
SLOT="0"
SRC_URI="http://xtreemfs.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
RDEPEND="virtual/jdk
         dev-java/ant"
DEPEND="${RDEPEND}"


src_compile() {
    emake || die "Emake failed!"
}

src_install() {
#    There is no "install" rule in the Makefile :-/
#    emake DESTDIR="${D}" all || die "Install failed!"
    into "${W}"/usr/
    dobin "${S}"/bin/*
    doinitd "${FILESDIR}"/init/xtreemfs-dir
    doinitd "${FILESDIR}"/init/xtreemfs-mrc
    doinitd "${FILESDIR}"/init/xtreemfs-osd
    doman "${S}"/man/man1/*
    dodir /var/log/xtreemfs/
    enewuser xtreemfs -1 /var/lib/xtreemfs
    fowners root:xtreemfs /var/log/xtreemfs
    fperms 772 /var/log/xtreemfs
}

pkg_postrm() {
    userdel xtreemfs
}