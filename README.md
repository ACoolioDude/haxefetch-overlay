# Official Gentoo Linux portage overlay for Haxefetch

## How to install this?

1. Install repository module (`emerge --ask --verbose eselect-repository`)
2. Enable repos (`eselect repository add haxefetch-overlay git https://github.com/ACoolioDude/haxefetch-overlay.git && eselect repository enable riru`)
3. Sync repos (`emerge --sync haxefetch-overlay && emerge --sync riru` || `emaint sync --repo haxefetch-overlay && emaint sync --repo riru`)
4. Unmask dependencies and `Haxefetch` (`echo "dev-lang/haxe-bin amd64\ndev-lang/neko ~amd64\napp-misc/haxefetch ~amd64" | tee -a /etc/portage/package.accept-keywords/haxefetch`)
4. Emerge Haxefetch (`emerge --ask --verbose app-misc/haxefetch` (for people who want to avoid compiling, i made binary ebuild and it can be emerged with `emerge --ask --verbose app-misc/haxefetch-bin`))