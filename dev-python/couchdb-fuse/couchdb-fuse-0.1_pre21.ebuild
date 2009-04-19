# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit distutils

MY_PN="CouchDB-FUSE"
MY_PV="${PV/_pre/dev-r}"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="CouchDB FUSE module"
HOMEPAGE="http://code.google.com/p/couchdb-fuse/"
SRC_URI="http://pypi.python.org/packages/source/C/CouchDB-FUSE/${MY_P}.tar.gz"
LICENSE="BSD-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
DEPEND="dev-python/fuse-python
        dev-python/couchdb"