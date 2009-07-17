inherit toolchain-funcs eutils java-pkg-2 java-ant-2

DESCRIPTION="Decentralised distributed filesystem"
HOMEPAGE="http://xtreemfs.org"
SLOT="0"
SRC_URI="http://xtreemfs.googlecode.com/files/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
RDEPEND=">=virtual/jdk-1.6.0"
DEPEND="${RDEPEND}"


src_compile() {
    export LANG=en_US.utf8
    export LC_ALL=en_US.utf8
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

    java-pkg_dojar src/servers/dist/XtreemFS.jar src/servers/lib/BabuDB-0.1.0-RC.jar
}

pkg_preinst() {
    dodir /var/log/xtreemfs/
    enewuser xtreemfs -1 /var/lib/xtreemfs
    fowners root:xtreemfs /var/log/xtreemfs
    fperms 772 /var/log/xtreemfs
}

pkg_postrm() {
    userdel xtreemfs
}
