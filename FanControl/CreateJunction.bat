@SET TARGETPATH=%programfiles(x86)%\FanControl\Configurations

RMDIR /S "%TARGETPATH%"

@IF EXIST "%TARGETPATH%" (
    @CHOICE /C YN /M "Failed to remove %TARGETPATH%, retry as Administrator?"
    @IF ERRORLEVEL 2 (
        @EXIT /B 1
    ) ELSE (
        @SUDO %~f0
    )
)

MKLINK /J "%TARGETPATH%" "%~dp0"

@IF NOT EXIST "%TARGETPATH%" (
    @CHOICE /C YN /M "Failed to create a link to %TARGETPATH%, retry as Administrator?"
    @IF ERRORLEVEL 2 (
        @EXIT /B 1
    ) ELSE (
        @SUDO %~f0
    )
)

@PAUSE
