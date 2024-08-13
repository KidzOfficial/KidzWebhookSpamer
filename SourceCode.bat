@echo off

color 9

setlocal

:MENU
cls
::: ======================================================================================================================
::: $$\   $$\ $$\       $$\                 $$\      $$\           $$\        $$$$$$\                                    |
::: $$ | $$  |\__|      $$ |                $$ | $\  $$ |          $$ |      $$  __$$\                                   |
::: $$ |$$  / $$\  $$$$$$$ |$$$$$$$$\       $$ |$$$\ $$ | $$$$$$\  $$$$$$$\  $$ /  \__| $$$$$$\   $$$$$$\  $$$$$$\$$$$\  |
::: $$$$$  /  $$ |$$  __$$ |\____$$  |      $$ $$ $$\$$ |$$  __$$\ $$  __$$\ \$$$$$$\  $$  __$$\  \____$$\ $$  _$$  _$$\ |
::: $$  $$<   $$ |$$ /  $$ |  $$$$ _/       $$$$  _$$$$ |$$$$$$$$ |$$ |  $$ | \____$$\ $$ /  $$ | $$$$$$$ |$$ / $$ / $$ || 
::: $$ |\$$\  $$ |$$ |  $$ | $$  _/         $$$  / \$$$ |$$   ____|$$ |  $$ |$$\   $$ |$$ |  $$ |$$  __$$ |$$ | $$ | $$ ||
::: $$ | \$$\ $$ |\$$$$$$$ |$$$$$$$$\       $$  /   \$$ |\$$$$$$$\ $$$$$$$  |\$$$$$$  |$$$$$$$  |\$$$$$$$ |$$ | $$ | $$ ||
::: \__|  \__|\__| \_______|\________|      \__/     \__| \_______|\_______/  \______/ $$  ____/  \_______|\__| \__| \__||
:::                                                                                    $$ |                              |
:::                                                                                    $$ |                              |
:::                                                                                    \__|                              |                
for /f "delims=: tokens=*" %%A in ('findstr /b ::: "%~f0"') do @echo(%%A
::: ======================================================================================================================
::: 1. Start                                                                                                             |
::: 2. View help                                                                                                         |
::: 3. Exit                                                                                                              |
::: ======================================================================================================================
set /p choice=Select an option (1, 2, or 3): 

if "%choice%"=="1" goto START_LOOP
if "%choice%"=="2" goto VIEW_HELP
if "%choice%"=="3" goto EXIT

:: Invalid choice
echo Invalid option. Please try again.
pause
goto MENU

:START_LOOP
cls
:: Prompt for the webhook URL
set /p WEBHOOK_URL=Enter the webhook URL: 

:: Prompt for the message
set /p MESSAGE=Enter the message to send: 

:: Prompt for the delay time
set /p DELAY=Enter the delay between messages in seconds: 

:: Convert message to JSON format
set "JSON_PAYLOAD={\"content\":\"%MESSAGE%\"}"

:: Notify user
echo Press Enter To Start The Loop . Close this command window to stop the loop.
pause

:LOOP
:: Send the message using curl
curl -X POST %WEBHOOK_URL% -H "Content-Type: application/json" -d "%JSON_PAYLOAD%"

:: Wait for the specified delay
timeout /t %DELAY% /nobreak >nul

:: Loop back to send the message again
goto LOOP

:VIEW_HELP
cls
echo ===============================
echo               Help
echo ===============================
echo This script continuously sends the same message to a specified webhook URL.
echo.
echo 1. Select "Start" to input the webhook URL, the message, and the delay time.
echo    The message will be sent repeatedly at the specified interval until you
echo    close the command window or stop the script manually.
echo.
echo 2. Select "View help" to see this help screen.
echo.
echo 3. Select "Exit" to close the script.
echo.
pause
goto MENU

:EXIT
endlocal
exit
