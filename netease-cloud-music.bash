#!/bin/sh
HERE=/opt/netease/netease-cloud-music
export QT_SCREEN_SCALE_FACTORS=1.25
export XDG_CURRENT_DESKTOP=Unity
export LD_LIBRARY_PATH=/opt/netease/netease-cloud-music/hooks/lib
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"${HERE}"/libs
export QT_PLUGIN_PATH="${HERE}"/plugins
export QT_QPA_PLATFORM_PLUGIN_PATH="${HERE}"/plugins/platforms
exec  "${HERE}"/netease-cloud-music $@
