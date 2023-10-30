export LIBXUL_DIST=$out
export M4=m4
export AWK=awk
export LLVM_OBJDUMP=objdump
export CPPFLAGS="-D__STDC_FORMAT_MACROS $CPPFLAGS"

if [[ "$(uname)" == "Darwin" ]]; then
       # ERROR: --with-system-icu is not supported with bootstrapped sysroot. Drop the option, or use --without-sysroot or --disable-bootstrap
       export CONFIG_PY_ARGS=""
else
       export CONFIG_PY_ARGS="--with-system-icu"
fi

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
# We can't build in js/src/, so create a build dir
mkdir obj
cd obj/
python ../configure.py \
       --prefix=$PREFIX \
       --enable-project=js \
       --disable-ctypes \
       --disable-jit \
       --disable-jemalloc \
       --enable-optimize \
       --enable-hardening \
       --with-intl-api \
       --build-backends=RecursiveMake \
       --disable-debug \
       --enable-gczeal \
       --enable-strip \
       --disable-install-strip \
       $CONFIG_PY_ARGS
make # TOOD: restore -j$CPU_COUNT
