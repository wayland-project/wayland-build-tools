#!/bin/bash

. $HOME/.config/wayland-build-tools/wl_defines.sh

if hash apt-get 2>/dev/null; then
    source /etc/lsb-release
    INSTALL="sudo apt-get install -y"
    OS="deb"
elif hash rpm 2>/dev/null; then
    INSTALL="sudo yum install -qy"
    OS="rh"
else
    echo "Distrib not compatible"
    exit
fi

# generic build dependencies
$INSTALL autoconf automake bison debhelper dpkg-dev flex libtool
$INSTALL pkg-config quilt python-libxml2

# libinput needs meson
if [ "$DISTRIB_CODENAME" = "xenial" ]; then
	# Xenial (16.04) has a too-old meson
	# So need to install from security.ubuntu.com
	$INSTALL ninja-build=1.7.1-1~ubuntu16.04.1
	$INSTALL meson=0.40.1-1~ubuntu16.04.1
elif [ "$OS" = "rh" ]; then
	$INSTALL meson
	$INSTALL ninja-build
	$INSTALL gcc-c++
else
    $INSTALL meson
	$INSTALL ninja
fi

# wayland/weston specific stuff
$INSTALL xmlto doxygen graphviz python-mako

if [ "$OS" = "deb" ]; then
    $INSTALL linux-libc-dev libexpat1-dev libmtdev-dev libpam0g-dev
    $INSTALL libpciaccess-dev libudev-dev libgudev-1.0-dev llvm-dev
    $INSTALL libpng-dev libglib2.0-dev libgcrypt20-dev libedit-dev
    $INSTALL libunwind8-dev libxml2-dev libxfont-dev x11proto-scrnsaver-dev
else
    $INSTALL libxml2-devel expat-devel llvm-devel libedit-devel
    $INSTALL libXfont2-devel libpng-devel mtdev-devel libpciaccess-devel
    $INSTALL kernel-devel kernel-headers pam-devel systemd-devel
    $INSTALL libgudev-devel glib2-devel libgcrypt-devel libunwind-devel
    $INSTALL libXScrnSaver-devel
fi

# xwayland specific stuff
if [ ${INCLUDE_XWAYLAND} ]; then
	if [ "$OS" = "deb" ]; then
        $INSTALL x11proto-randr-dev x11proto-composite-dev x11proto-xinerama-dev
        $INSTALL x11proto-dri2-dev x11proto-gl-dev xutils-dev libxcursor-dev
        $INSTALL libx11-dev libx11-xcb-dev libxdamage-dev libxext-dev
        $INSTALL libxxf86vm-dev libxfixes-dev libxcb-composite0-dev
        #$INSTALL libdrm-dev
        #$INSTALL x11proto-dri3-dev
    else
        $INSTALL libXrandr-devel libXcomposite-devel libXinerama-devel libXext-devel
        $INSTALL xorg-x11-server-utils xorg-x11-proto-devel libXdamage-devel libxcb-devel
        $INSTALL libXcursor-devel libXxf86vm-devel libXfixes-devel
        #$INSTALL libdrm-devel
    fi
fi
