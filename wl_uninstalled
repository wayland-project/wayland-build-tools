#!/bin/bash -i
#
# Copyright (C) 2016 Samsung Electronics. All rights reserved.
#
#   Author: Reynaldo H. Verdejo Pinochet <reynaldo@osg.samsung.com>
#           Derek Foreman <derekf@osg.samsung.com>
#
# Based on GStreamer's gst-uninstalled (http://gstreamer.freedesktop.org/)
#
# This script provides a shell environment to build and use an uninstalled
# wayland/weston setup, consisting mostly of checked out and built (no
# "make install" required) Wayland repositories.
#
# Here is the list of required repositories:
#
# wayland           git://anongit.freedesktop.org/wayland/wayland
# wayland-protocols git://anongit.freedesktop.org/wayland/wayland-protocols
# libinput          git://anongit.freedesktop.org/wayland/libinput
# weston            git://anongit.freedesktop.org/wayland/weston
#

if [ "$1"yes != "yes" ]; then
  cat << EOF

This script uses no arguments. Aborting execution.

The following parameter was not understood:

"$@"

Quick instructions:

1.- Clone the required repositories:

    wayland           git://anongit.freedesktop.org/wayland/wayland
    wayland-protocols git://anongit.freedesktop.org/wayland/wayland-protocols
    libinput          git://anongit.freedesktop.org/wayland/libinput
    weston            git://anongit.freedesktop.org/wayland/weston

2.- Set the WLD variable here to point to the directory you
    put your Wayland repositories at. Rest should remain untouched.
    Instead of setting this variable here, you can also export it
    before the script is executed and leave the latter untouched.

3.- Execute the script. If everything goes OK, you should start
    seeing a "[WAYLAND UNINSTALLED]" line being printed before each
    shell prompt to remind you that you are on a wayland uninstalled
    environment.

4.- Configure and build the above projects in the order they are listed
    in this document.

5.- Run something wayland-ish, like weston, and it will use the same
    Wayland uninstalled environment used to build.

6.- To exit the Wayland uninstalled shell just use the 'exit' command.

EOF
  exit -1
fi

if [ -z "$WLD" ]; then
	WLD=$HOME/devel/wayland/git
	echo Wayland uninstalled root not set \(WLD\). Using script default \
	\'$WLD\'
fi

# Set up PATHs

LD_LIBRARY_PATH="\
$WLD/wayland/.libs\
:$WLD/libinput/src/.libs\
:$WLD/weston/.libs/\
${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

WESTON_BUILD_DIR="\
$WLD/weston/\
${WESTON_BUILD_DIR:+:$WESTON_BUILD_DIR}"

PKG_CONFIG_PATH="\
$WLD/wayland/src/\
:$WLD/wayland/cursor/\
:$WLD/wayland-protocols/\
:$WLD/libinput/src/\
:$WLD/lib/pkgconfig/\
:$WLD/share/pkgconfig/\
:$WESTON_BUILD_DIR/compositor/\
:$WESTON_BUILD_DIR/libweston/\
:$WESTON_BUILD_DIR/libweston-desktop/\
${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"

PATH="\
$WLD/wayland/\
:$WLD/weston/\
:$PATH"

# Export new environment

export WLD
export LD_LIBRARY_PATH
export PKG_CONFIG_PATH
export WESTON_BUILD_DIR
export PATH

cat << EOF

The following environment has been exported:

WLD=$WLD
LD_LIBRARY_PATH=$LD_LIBRARY_PATH
PKG_CONFIG_PATH=$PKG_CONFIG_PATH
WESTON_BUILD_DIR=$WESTON_BUILD_DIR
PATH=$PATH

----------------------

EOF

cd $WLD
shell=$SHELL

# Do not load local startup files
if test "x$SHELL" = "x/bin/bash"
then
  shell="$SHELL --noprofile"
fi

# Launch shell. Remember the user this is a Wayland uninstalled
# before each prompt.

PROMPT_COMMAND="echo [WAYLAND UNINSTALLED]" $shell


