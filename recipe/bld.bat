dir

cargo-bundle-licenses --format yaml --output THIRDPARTY.yml

@rem We can't build in js/src/, so create a build dir
mkdir obj
copy .mozconfig obj/.mozconfig

cd obj/
python ../mach.py build
if errorlevel 1 exit 1
