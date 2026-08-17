# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature
inherit git-r3

DESCRIPTION="A fetch program written in Haxe"
HOMEPAGE="https://github.com/ACoolioDude/Haxefetch"
EGIT_REPO_URI="https://github.com/ACoolioDude/Haxefetch.git"
HXCPP_VERSION="4.3.2"

SRC_URI="https://lib.haxe.org/p/hxcpp/${HXCPP_VERSION}/download/ -> hxcpp-${HXCPP_VERSION}.zip"

LICENSE="MIT"
SLOT=0
KEYWORDS="~amd64"

BDEPEND="
    dev-lang/haxe-bin
    app-arch/unzip
"

src_unpack() {
    git-r3_fetch
    git-r3_checkout

    einfo "Extracting Hxcpp.."
    mkdir -p "${WORKDIR}/hxcpp-src" || die
    unzip -q "${DISTDIR}/hxcpp-${HXCPP_VERSION}.zip" -d "${WORKDIR}/hxcpp-src" || die
}

src_compile() {
    export HAXELIB_PATH="${WORKDIR}/haxelib"
    mkdir -p "${HAXELIB_PATH}"
    haxelib setup "${HAXELIB_PATH}"

    local hxcpp_path=$(find "${WORKDIR}/hxcpp-src" -name "haxelib.json" -exec dirname {} \;)
    if [[ -z "${hxcpp_path}" ]]; then
        die "Hxcpp directory was not found in ${WORKDIR}. Aborting!"
    fi

    haxelib dev hxcpp "${hxcpp_path}"

    einfo "Compiling Haxefetch.."
    haxe build.hxml -D git_hash=$(git rev-parse --short HEAD) || die "Haxefetch compilation failed. Aborting!"
}

src_install() {
    local bin_path=$(find bin/ -type f -executable ! -name "*.so" ! -name "*.dylib" 2>/dev/null | head -n 1)
    if [[ -n "${bin_path}" ]]; then
        einfo "Installing compiled binary from ${bin_path} to /usr/bin"
        newbin "${bin_path}" haxefetch
    else
        die "Could not find binary. Aborting!"
    fi
}

pkg_postinst() {
   optfeature_header "Optional features as suggested by haxefetch --recommends:"
   optfeature "inxi: for inxi: to show RAM type" sys-apps/inxi
   optfeature "mesa: for Mesa" media-libs/mesa
   optfeature "mesa-progs: to show OpenGL version" x11-apps/mesa-progs
   optfeature "vulkan-loader: for Vulkan" media-libs/vulkan-loader
   optfeature "vulkan-headers: for Vulkan headers" dev-util/vulkan-headers
   optfeature "vulkan-tools: for Vulkan tools: to show Vulkan version" dev-util/vulkan-tools
}
