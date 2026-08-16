# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature

DESCRIPTION="A fetch program written in Haxe"
HOMEPAGE="https://github.com/ACoolioDude/Haxefetch"

SRC_URI="https://github.com/ACoolioDude/Haxefetch/releases/download/1.0.0-alpha/haxefetch-1.0.0-a.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

S="${WORKDIR}"

src_install() {
	exeinto /usr/bin
	doexe haxefetch
}

pkg_postinst() {
   optfeature_header "Optional features as suggested by haxefetch --recommends:"
   optfeature "inxi: for inxi: to show RAM type" sys-apps/inxi
   optfeature "mesa: for Mesa" media-libs/mesa
   optfeature "mesa-progs: for Mesa utils: to show OpenGL version" x11-apps/mesa-progs
   optfeature "vulkan-loader: for Vulkan" media-libs/vulkan-loader
   optfeature "vulkan-headers: for Vulkan headers" dev-util/vulkan-headers
   optfeature "vulkan-tools: for Vulkan tools: to show Vulkan version" dev-util/vulkan-tools
}