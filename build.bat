@ECHO OFF

DEL /F /Q build\advancedJM-dev.pk3"

7za32 a -tzip "build/advancedJM-dev.pk3" pk3/* -r -xr!*.dbs -xr!*.backup1 -xr!*.backup2 -xr!*.backup3 -xr!*.bak -xr!.gitignore
