# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A fetch program written in Haxe"
HOMEPAGE="https://github.com/ACoolioDude/Haxefetch"
SRC_URI="https://github.com/ACoolioDude/Haxefetch/releases/download/1.0.0-alpha/haxefetch -> ${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

BDEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${P}-bin" "${S}/haxefetch" || die
}

src_compile() {
	:
}

src_install() {
	# Install to /usr/bin/haxefetch with executable permissions
	exeinto /usr/bin
	doexe haxefetch
}

pkg_postins() {
   optfeature_header "Optional features as suggested by haxefetch --recommends:"
   optfeature "sys-apps/inxi for inxi: to show RAM type"
   optfeature "media-libs/mesa for Mesa"
   optfeature "x11-apps/mesa-progs for Mesa utils: to show OpenGL version"
   optfeature "media-libs/vulkan-loader for Vulkan"
   optfeature "dev-util/vulkan-headers for Vulkan headers"
   optfeature "dev-util/vulkan-tools for Vulkan tools: to show Vulkan version"
}

