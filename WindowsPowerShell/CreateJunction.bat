@SET WPSPATH=%HOMEPATH%\Documents\WindowsPowerShell

RMDIR %WPSPATH%
MKLINK /J %WPSPATH% %~dp0

@PAUSE
