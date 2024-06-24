export LIBXUL_DIST=$out
export M4=m4
export AWK=awk
export LLVM_OBJDUMP=objdump
export PKG_CONFIG=${BUILD_PREFIX}/bin/pkg-config
export CPPFLAGS="-D__STDC_FORMAT_MACROS $CPPFLAGS"

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
# We can't build in js/src/, so create a build dir
mkdir obj
cd obj/
python ../configure.py \
       --prefix=$PREFIX \
       --build-backends=RecursiveMake \
       --disable-bootstrap \
       --disable-debug \
       --disable-debug-symbols \
       --disable-install-strip \
       --disable-jemalloc \
       --disable-jit \
       --enable-gczeal \
       --enable-hardening \
       --enable-optimize="${CFLAGS} -O2" \
       --enable-project=js \
       --enable-release \
       --enable-rust-simd \
       --enable-shared-js \
       --enable-strip \
       --with-intl-api \
       --without-system-icu \
       --with-system-zlib
make # TOOD: restore -j$CPU_COUNT
