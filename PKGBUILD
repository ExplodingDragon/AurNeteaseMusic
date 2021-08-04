# Maintainer: Peter Cai <peter at typeblog dot net>
# Maintainer: Dragon <peter at typeblog dot net>

pkgname=netease-cloud-music
_pkgver=1.2.1
_vlcver=3.0.16
# optional fixup version including hyphen
_vlcfixupver=
pkgver=${_pkgver}_libvlc_${_vlcver}
_pkgdate=20190428
pkgrel=1
pkgdesc="Netease Cloud Music, converted from .deb package"
arch=("x86_64")
url="https://music.163.com/"
license=('custom' )
depends=('flac' 'mpg123' 'libpulse' 'alsa-lib' 'libsamplerate' 'libsoxr')
options=('!emptydirs')
source=(
  "https://download.videolan.org/vlc/${_vlcver}/vlc-${_vlcver}${_vlcfixupver}.tar.xz"
	"https://d1.music.126.net/dmusic/netease-cloud-music_${_pkgver}_amd64_ubuntu_${_pkgdate}.deb"
	"https://music.163.com/html/web2/service.html"
  "netease-cloud-music.bash"
  "ncm.patch"
)
md5sums=( 'efc5f7331c033bf81536531c6eba5aa5'
         '1f47c7dc3d9ce46da8099e539ee8a74d'
         'ee09cacb054f6a346bf935737df3f33d'
         'SKIP'
         'SKIP')

DLAGENTS=("https::/usr/bin/curl -A 'Mozilla' -fLC - --retry 3 --retry-delay 3 -o %o %u")

prepare() {
  cd vlc-${_vlcver}
  sed -e 's:truetype/ttf-dejavu:TTF:g' -i modules/visualization/projectm.cpp
  sed -e 's|-Werror-implicit-function-declaration||g' -i configure
  sed 's|whoami|echo builduser|g' -i configure
  sed 's|hostname -f|echo arch|g' -i configure
  local src
  for src in "${source[@]}"; do
    src="${src%%::*}"
    src="${src##*/}"
    [[ $src = *.patch ]] || continue
    echo "Applying patch $src..."
    patch -Np1 < "../$src"
  done
}


build() {
  cd vlc-${_vlcver}
  export CXXFLAGS+=" -std=c++11"
  ./configure \
    --prefix=/opt/netease/netease-cloud-music/hooks \
    --sysconfdir=/opt/netease/netease-cloud-music/hooks/etc \
    --disable-rpath \
    --enable-mpg123 \
    --enable-flac \
    --disable-pulse \
    --enable-alsa \
    --enable-samplerate \
    --enable-soxr \
    --enable-gnutls \
    --disable-update-check \
    --disable-vlc \
    --disable-lua \
    --disable-avcodec \
    --disable-avformat \
    --disable-gst-decode \
    --disable-swscale \
    --disable-a52 \
    --without-x \
    --disable-xcb \
    --disable-vdpau \
    --disable-wayland \
    --disable-sdl-image \
    --disable-srt \
    --disable-qt \
    --disable-caca

  make
}

package() {
  # make netease
  cd ${srcdir}
  tar -xvf data.tar.xz -C ${pkgdir}
  install -D -m644 service.html ${pkgdir}/usr/share/licenses/$pkgname/license.html
  # make vlc lib
  cd ${srcdir}/vlc-${_vlcver}
  make DESTDIR="${pkgdir}" install
  rm ${pkgdir}/opt/netease/netease-cloud-music/netease-cloud-music.bash
  cp ${srcdir}/netease-cloud-music.bash ${pkgdir}/opt/netease/netease-cloud-music/netease-cloud-music.bash
  chmod 755 ${pkgdir}/opt/netease/netease-cloud-music/netease-cloud-music.bash
}
