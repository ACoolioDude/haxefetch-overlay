# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="A fetch program written in Haxe"
HOMEPAGE="https://github.com/ACoolioDude/Haxefetch"
EGIT_REPO_URL="https://github.com/ACoolioDude/Haxefetch.git"
HXCPP_VERSION="4.3.2"

SRC_URI="https://lib.haxe.org/p/hxcpp/${HXCPP_VERSION}/download/ -> hxcpp-${HXCPP_VERSION}.zip"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

DEPEND="
    dev-lang/haxe-bin
    app-arch/unzip
"
RDEPEND="${DEPEND}"

src_unpack() {
    git-r3_src_unpack
    mkdir -p "${WORKDIR}/hxcpp-src"
    unzip -q "${DISTDIR}/hxcpp-${HXCPP_VERSION}.zip" -d "${WORKDIR}/hxcpp-src"
}

src_compile() {
    export HAXELIB_PATH="${WORKDIR}/haxelib"
    mkdir -p "${HAXELIB_PATH}"
    haxelib setup "${HAXELIB_PATH}"

    haxe build.hxml || die "Haxe compilation failed!"
}

src_install() {
    dobin bin/cpp/Haxefetch
}