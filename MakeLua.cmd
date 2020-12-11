@echo off
:: ========================
:: file build.cmd
:: ========================
setlocal
:: you may change the following variable's value
:: to suit the downloaded version

set work_dir=%~dp0
:: Removes trailing backslash
:: to enhance readability in the following steps
set work_dir=%work_dir:~0,-1%
set src_dir=%work_dir%\src
set output_dir=%work_dir%\.lua_output

mingw32-make PLAT=mingw

echo.
echo **** COMPILATION TERMINATED ****
echo.
echo **** BUILDING BINARY DISTRIBUTION ****
echo.

:: create a clean "binary" installation
mkdir %output_dir%
mkdir %output_dir%\doc
mkdir %output_dir%\bin
mkdir %output_dir%\include

copy %work_dir%\doc\*.* %output_dir%\doc\*.*
copy %src_dir%\*.exe %output_dir%\bin\*.*
copy %src_dir%\*.dll %output_dir%\bin\*.*
copy %src_dir%\luaconf.h %output_dir%\include\*.*
copy %src_dir%\lua.h %output_dir%\include\*.*
copy %src_dir%\lualib.h %output_dir%\include\*.*
copy %src_dir%\lauxlib.h %output_dir%\include\*.*
copy %src_dir%\lua.hpp %output_dir%\include\*.*

echo.
echo **** BINARY DISTRIBUTION BUILT ****
echo.

:: Remove all intermediate output files
for /r %src_dir% %%i in (*.o) do del /q %%i
for /r %src_dir% %%i in (*.a) do del /q %%i
for /r %src_dir% %%i in (*.exe) do del /q %%i
for /r %src_dir% %%i in (*.dll) do del /q %%i

echo.
echo **** INTERMEDIATE OUTPUT FILES CLEARED ****
echo.

%output_dir%\bin\lua.exe -e"print [[Hello!]];print[[Simple Lua test successful!!!]]"

echo.

pause