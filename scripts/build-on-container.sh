#!/bin/bash

set -eo pipefail

mkdir -p /opt

LIBJPEG_TURBO_VERSION=2.0.4
LIBPNG_VERSION=1.6.37
MAGICK_VERSION=6.9.10-91

rm -rf build
mkdir -p build

cd build
curl -s -O https://jaist.dl.sourceforge.net/project/libjpeg-turbo/$LIBJPEG_TURBO_VERSION/libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz
tar xf libjpeg-turbo-$LIBJPEG_TURBO_VERSION.tar.gz
cd libjpeg-turbo-$LIBJPEG_TURBO_VERSION
cmake -G"Unix Makefiles" -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_PREFIX=/opt \
  -DCMAKE_INSTALL_LIBDIR=/opt/lib \
  -DCMAKE_POSITION_INDEPENDENT_CODE=1 \
  -DENABLE_SHARED=1 -DENABLE_STATIC=1 \
  -DSO_MAJOR_VERSION=62 \
  -DSO_MINOR_VERSION=0 \
  -DJPEG_LIB_VERSION=62 \
  -DREQUIRE_SIMD=1 \
  -DWITH_12BIT=0 -DWITH_ARITH_DEC=1 \
  -DWITH_ARITH_ENC=1 -DWITH_JAVA=0 \
  -DWITH_JPEG7=0 -DWITH_JPEG8=0 \
  -DWITH_MEM_SRCDST=1 -DWITH_SIMD=1 \
  -DWITH_TURBOJPEG=1 .
make
make install
cd ..

curl -s -O https://jaist.dl.sourceforge.net/project/libpng/libpng16/$LIBPNG_VERSION/libpng-$LIBPNG_VERSION.tar.xz
tar xf libpng-$LIBPNG_VERSION.tar.xz
cd libpng-$LIBPNG_VERSION
./configure --prefix=/opt
make
make install
cd ..

curl -s -O https://download.imagemagick.org/ImageMagick/download/releases/ImageMagick-$MAGICK_VERSION.tar.xz
tar xf ImageMagick-$MAGICK_VERSION.tar.xz
cd ImageMagick-$MAGICK_VERSION
./configure \
  PKG_CONFIG_PATH=/opt/lib/pkgconfig \
  CPPFLAGS=-I/opt/include \
  LDFLAGS=-L/opt/lib \
  --prefix=/opt \
  --enable-delegate-build \
  --with-quantum-depth=16 \
  --without-magick-plus-plus \
  --without-dps \
  --without-fftw \
  --without-fpx \
  --without-djvu \
  --without-fontconfig \
  --without-freetype \
  --without-raqm \
  --without-heic \
  --without-jbig \
  --without-lcms \
  --without-openjp2 \
  --without-pango \
  --without-raw \
  --without-tiff \
  --without-webp \
  --without-xml \
  --disable-opencl \
  --disable-openmp \
  --disable-dependency-tracking \
  --with-png \
  --with-jpeg
make
make install
cd ..

rm -rf /opt/include
rm -rf /opt/share/doc
rm -rf /opt/share/man
