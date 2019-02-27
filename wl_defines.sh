export INCLUDE_XWAYLAND=1
export WLROOT=$HOME/Wayland
export WLD=$WLROOT/install   # change this to another location if you prefer

if [ "$(uname -i)" = "i386" ]; then
	export WL_BITS=32
else
	export WL_BITS=64
fi

XWAYLAND=${WLROOT}/install/bin/Xwayland
export DISTCHECK_CONFIGURE_FLAGS="--with-xserver-path=$XWAYLAND"

export LD_LIBRARY_PATH=$WLD/lib
export PKG_CONFIG_PATH=$WLD/lib/pkgconfig/:$WLD/share/pkgconfig/:$WLD/lib/x86_64-linux-gnu/pkgconfig
export PATH=$WLD/bin:$PATH
export ACLOCAL_PATH="$WLD/share/aclocal"
export ACLOCAL="aclocal -I $ACLOCAL_PATH"

