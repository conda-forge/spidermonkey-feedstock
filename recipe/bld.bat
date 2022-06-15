echo on

dir

@REM cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

.\MozillaBuildSetup-4.0.1.exe /S
if errorlevel 1 exit 1

@rem We can't build in js/src/, so create a build dir
mkdir obj
copy %RECIPE_DIR%\.mozconfig obj\.mozconfig

cd obj
echo "ac_add_options --prefix=%PREFIX%" >> .mozconfig
echo "mk_add_options MOZ_OBJDIR=%cd%" >> .mozconfig

set MOZILLABUILD=C:\mozilla-build
..\mach.ps1 build
if errorlevel 1 exit 1
