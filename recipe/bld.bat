set LIBXUL_DIST=$out
set M4=m4
set AWK=awk
set LLVM_OBJDUMP=objdump
set CPPFLAGS="-D__STDC_FORMAT_MACROS $CPPFLAGS"

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml
# We can't build in js/src/, so create a build dir
mkdir obj
cd obj/
python ../configure.py ^
       --prefix=$PREFIX ^
       --enable-project=js ^
       --disable-ctypes ^
       --disable-jit ^
       --disable-jemalloc ^
       --enable-optimize ^
       --enable-hardening ^
       --with-intl-api ^
       --build-backends=RecursiveMake ^
       --with-system-icu ^
       --disable-debug ^
       --enable-gczeal ^
       --enable-strip ^
       --disable-install-strip
if errorlevel 1 exit 1

make -j$CPU_COUNT
if errorlevel 1 exit 1
