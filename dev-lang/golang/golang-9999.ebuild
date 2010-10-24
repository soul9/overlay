EAPI=2
inherit elisp-common bash-completion mercurial

DESCRIPTION="A concurrent garbage collected and typesafe language"
HOMEPAGE="http://www.golang.org/"
EHG_REPO_URI="https://go.googlecode.com/hg/"

SLOT="0"
KEYWORDS="~amd64 ~x86"
#TODO:
#do LICENSE
#IUSE="test"
#TODO: where does kate install it's syntax highlighting xml files?
#IUSE="kde"
IUSE="bash-completion vim-syntax emacs zsh-completion"

DEPEND="sys-devel/bison
		sys-apps/gawk
		sys-apps/ed"
#kde? ( kde-base/kate )
RDEPEND="vim-syntax? ( app-editors/vim )
		emacs? ( virtual/emacs )
		bash-completion? ( app-shells/bash-completion )
		zsh-completion? ( app-shells/zsh-completion )"

GOROOT_FINAL=/usr/golang
S="${WORKDIR}/hg"

src_compile() {
	export GOROOT="$(pwd)"
	if use x86; then
		export GOARCH=386
	elif use amd64; then
		export GOARCH=amd64
	fi
	export GOBIN=$GOROOT/bin
	if use emacs; then
		elisp-compile misc/emacs/*.el
	fi
	rm -rf .hg*
	cd src
	bash all.bash
}

src_install() {
	export GOROOT="$(pwd)"
	if use x86; then
		export GOARCH=386
	elif use amd64; then
		export GOARCH=amd64
	fi
	export GOBIN=$GOROOT/bin

	dodir "${GOROOT_FINAL}"
	find -type f ! -executable -print0 | xargs -0 -I {} install -Dm644 {} "${D}/${GOROOT_FINAL}/{}"
	find -type f -executable -print0 | xargs -0 -I {} install -Dm755 {} "${D}/${GOROOT_FINAL}/{}"
	find "$D/${GOROOT_FINAL}/" -type d -print0 | xargs -0 chmod g+s

	if use bash-completion; then
		dobashcompletion "misc/bash/go"
	fi
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		doins "misc/zsh/go"
	fi
	if use vim-syntax; then
		insinto /usr/share/vim/vimfiles/syntax
		doins "misc/vim/ftdetect"
		doins "misc/vim/syntax"
	fi
	if use emacs; then
		elisp-install ${PN} misc/emacs/*.el misc/emacs/*.elc
	fi
#TODO:
#	if use kde; then
#		insinto idontknow
#		doins "misc/kate/go.xml"
#	fi
	NCPU="$(grep '^processor' /proc/cpuinfo |wc -l)"
	MYDOSED="s,GENTOOARCH,${GOARCH},g; s,GENTOO_GOROOT,${GOROOT_FINAL},g; s,NCPU,${NCPU},g"
	sed "${MYDOSED}" "${FILESDIR}/golang-env" > "${T}/99golang" || die "Couldn't make the environment file"

	doenvd "${T}/99golang" || die "Couldn't install the environment file"
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
	fi
}
pkg_postrm() {
	if use emacs; then
		elisp-site-regen
	fi
}
