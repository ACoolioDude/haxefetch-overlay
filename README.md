# Official Gentoo Linux portage overlay for Haxefetch

## How to install this?
1. Install repository module (`emerge --ask --verbose eselect-repository`)
2. Enable repo (`eselect repository add haxefetch-overlay git https://github.com/ACoolioDude/haxefetch-overlay.git`)
3. Sync repo (`emerge --sync haxefetch-overlay` || `emaint sync --repo haxefetch-overlay`)
4. Unmask `haxefetch` (`echo "app-misc/haxefetch ~amd64" | tee -a /etc/portage/package.accept-keywords/haxefetch`)
4. Emerge Haxefetch (`emerge --ask --verbose app-misc/haxefetch` or `emerge --ask --verbose app-misc/haxefetch-bin`)