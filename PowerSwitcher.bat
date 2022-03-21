@echo off
:: quickly switch between two power schemes

set plan_a="High performance"
set plan_b="Balanced"

for /f "skip=3 tokens=*" %%i in ('powercfg -l') do (
    echo %%i|find "*">nul
    if not errorlevel 1 (
        for /f "tokens=4" %%p in ('echo %%i') do (
            set active_guid=%%p
        )
    )
    echo %%i|find %plan_a%>nul
    if not errorlevel 1 (
        for /f "tokens=4" %%p in ('echo %%i') do (
            set a_guid=%%p
        )
    )
    echo %%i|find %plan_b%>nul
    if not errorlevel 1 (
        for /f "tokens=4" %%p in ('echo %%i') do (
            set b_guid=%%p
        )
    )
)
echo.
if %active_guid%==%a_guid% (
    powercfg /s %b_guid% && echo Set to %plan_b%
    
) 
if %active_guid%==%b_guid% (
    powercfg /s %a_guid% && echo Set to %plan_a%
    
)
pause