#!/bin/bash

. $HOME/.config/wayland-build-tools/wl_defines.sh

# TODO: Check if tree already exists first
# TODO: Bail if errors
# TODO: Log output


clone_or_update() {
	repo=$1
	dest=$(basename $repo)

	cd ${WLROOT}
	if [ $? != 0 ]; then
		echo "Error: Could not cd to ${WLROOT}.  Does it exist?"
        exit 1
	fi
	echo
	echo $dest
	if [ ! -d ${dest} ]; then
		git clone ${repo} ${dest}
		if [ $? != 0 ]; then
			echo "Error: Could not clone repository"
			exit 1
		fi
	fi
	cd ${dest}
	git checkout master
	if [ $? != 0 ]; then
		echo "Error: Problem checking out master"
		exit 1
	fi
	git pull
	if [ $? != 0 ]; then
		echo "Error: Could not pull from upstream"
		exit 1
	fi
	cd ${WLROOT}
}

clone_or_update git://anongit.freedesktop.org/wayland/wayland
clone_or_update git://anongit.freedesktop.org/git/mesa/drm
clone_or_update git://anongit.freedesktop.org/xcb/proto
clone_or_update git://anongit.freedesktop.org/xorg/util/macros
clone_or_update git://anongit.freedesktop.org/xcb/libxcb
clone_or_update git://anongit.freedesktop.org/xorg/proto/presentproto
clone_or_update git://anongit.freedesktop.org/xorg/proto/dri3proto
clone_or_update git://anongit.freedesktop.org/xorg/lib/libxshmfence
clone_or_update git://github.com/xkbcommon/libxkbcommon
clone_or_update git://anongit.freedesktop.org/mesa/mesa
clone_or_update git://anongit.freedesktop.org/pixman
clone_or_update git://anongit.freedesktop.org/cairo
clone_or_update git://git.sv.gnu.org/libunwind
clone_or_update git://anongit.freedesktop.org/libevdev
clone_or_update git://anongit.freedesktop.org/wayland/wayland-protocols
clone_or_update git://git.code.sf.net/p/linuxwacom/libwacom
clone_or_update git://anongit.freedesktop.org/wayland/libinput
clone_or_update git://anongit.freedesktop.org/wayland/weston

if [ ${INCLUDE_XWAYLAND} ]; then
	if [ ${WL_BITS} = "32" ]; then
		clone_or_update git://anongit.freedesktop.org/xorg/lib/libxtrans
	fi

	clone_or_update git://github.com/anholt/libepoxy
	clone_or_update git://anongit.freedesktop.org/xorg/proto/glproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/xproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/xcmiscproto
	clone_or_update git://anongit.freedesktop.org/xorg/lib/libxtrans
	clone_or_update git://anongit.freedesktop.org/xorg/proto/bigreqsproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/xextproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/fontsproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/videoproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/recordproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/resourceproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/xf86driproto
	clone_or_update git://anongit.freedesktop.org/xorg/proto/randrproto
	clone_or_update git://anongit.freedesktop.org/xorg/lib/libxkbfile
	clone_or_update git://anongit.freedesktop.org/xorg/lib/libXfont
	clone_or_update git://anongit.freedesktop.org/xorg/xserver
fi
