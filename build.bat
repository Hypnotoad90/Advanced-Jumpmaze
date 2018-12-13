@ECHO OFF

CALL "%CD%\utilities\variables.bat" /NOVERSION
CALL "%CD%\utilities\mkvers.bat" /NOVERSION

DEL /F /Q "%OUTDIR%\advancedJM-*.pk3"

PUSHD pk3
DEL /F /Q "%CD%\err_*.txt"
IF NOT EXIST "%CD%\scripts\core" MKLINK /J "%CD%\scripts\core" "%START%\dependencies\jumpmaze-zan\jm_core\pk3\scripts"
IF NOT EXIST "%CD%\acs" MKDIR "%CD%\acs"
acc "scripts/advjm.acs" "acs/advjm.o"
IF EXIST "%CD%\scripts\acs.err" MOVE /Y "%CD%\scripts\acs.err" "err_advjm.txt"

%SEVENZAEXE% a -tzip "%OUTDIR%\advancedJM-dev.pk3" * -r -xr!*.dbs -xr!*.backup1 -xr!*.backup2 -xr!*.backup3 -xr!*.bak -xr!err_*.txt

POPD
