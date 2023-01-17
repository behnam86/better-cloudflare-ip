chcp 936 > nul
@echo off
cd "%~dp0"
setlocal enabledelayedexpansion
cls
goto notice
: notice
echo If the download of the following files fails, you can manually visit the URL to download and save them to the same directory

echo https://www.baipiao.eu.org/cloudflare/colo save as colo.txt
echo https://www.baipiao.eu.org/cloudflare/url Save as url.txt
echo https://www.baipiao.eu.org/cloudflare/ips-v4 save as ips-v4.txt
echo https://www.baipiao.eu.org/cloudflare/ips-v6 save as ips-v6.txt
goto datacheck

:datacheck
if not exist "colo.txt" echo Download data center information from server colo.txt&curl --retry 2 -s https://www.baipiao.eu.org/cloudflare/colo -o colo.txt&goto datacheck
if not exist "url.txt" echo Download speed test file address from server url.txt&curl --retry 2 -s https://www.baipiao.eu.org/cloudflare/url -o url.txt&goto datacheck
if not exist "ips-v4.txt" echo Download IPV4 data from server ips-v4.txt&curl --retry 2 -s https://www.baipiao.eu.org/cloudflare/ips-v4 -o ips-v4. txt&goto datacheck
if not exist "ips-v6.txt" echo Download IPV6 data from server ips-v6.txt&curl --retry 2 -s https://www.baipiao.eu.org/cloudflare/ips-v6 -o ips-v6. txt&goto datacheck
set /a n=0
for /f "tokens=1 delims=/" %%i in (url.txt) do (
if !n! EQU 0 set domain=%%i&set /a n+=1
)
set /a n=0
for /f "delims=" %%i in (url.txt) do (
if !n! EQU 0 set url=%%i&set /a n+=1
)
set file=!url:%domain%/=!
cls
goto main

:main
title CF preferred IP
set /a menu=0
echo 1. IPV4 preferred (TLS) & echo 2. IPV4 preferred & echo 3. IPV6 preferred (TLS) & echo 4. IPV6 preferred & echo 5. Single IP speed test (TLS) & echo 6. Single IP speed test & echo 7. Clear cache & echo 8. Update Data &echo 0. Exit &echo.
set /p menu=Please select the menu (default %menu%):
if %menu%==0 exit
if %menu%==1 title IPV4 preferred (TLS)&set ips=ipv4&set filename=ips-v4.txt&set tls=1&goto bettercloudflareip
if %menu%==2 title IPV4 preferred&set ips=ipv4&set filename=ips-v4.txt&set tls=0&goto bettercloudflareip
if %menu%==3 title IPV6 preferred (TLS)&set ips=ipv6&set filename=ips-v6.txt&set tls=1&goto bettercloudflareip
if %menu%==4 title IPV6 preferred&set ips=ipv6&set filename=ips-v6.txt&set tls=0&goto bettercloudflareip
if %menu%==5 title single IP speed test (TLS)&call :singlehttps&goto main
if %menu%==6 title single IP speed test&call :singlehttp&goto main
if %menu%==7 del rtt.txt data.txt CR.txt CRLF.txt cut.txt speed.txt > nul 2>&1&RD /S /Q rtt > nul 2>&1&cls&echo cache has been cleared&goto main
if %menu%==8 del colo.txt url.txt ips-v4.txt ips-v6.txt > nul 2>&1&cls&goto notice
cls
goto main

:singlehttps
set /a port=443
set /p ip=Please enter the IP that needs to be tested:
set /p port=Please enter the port that needs to be tested (default %port%):
echo testing speed !ip! port !port!
for /f "delims=" %%i in ('curl --resolve !domain!:!port!:!ip! "https://!domain!:!port!/!file!" -o nul -- connect-timeout 5 --max-time 15 -w %%{speed_download}') do (
set /a speed_download=%%i/1024
cls&echo !ip! average speed !speed_download! kB/s
)
goto :eof

:singlehttp
set /a port=80
set /p ip=Please enter the IP that needs to be tested:
set /p port=Please enter the port that needs to be tested (default %port%):
echo testing speed !ip! port !port!
for /f "delims=" %%i in ('echo !ip! ^| find /c /v ":"') do (
set /a ipmode=%%i
)
if !ipmode! EQU 0 (
for /f "delims=" %%i in ('curl -x [!ip!]:!port! "http://!domain!:!port!/!file!" -o nul --connect-timeout 5 --max-time 15 -w %%{speed_download}') do (
set /a speed_download=%%i/1024
cls&echo !ip! average speed !speed_download! kB/s
)
) else (
for /f "delims=" %%i in ('curl -x !ip!:!port! "http://!domain!:!port!/!file!" -o nul --connect-timeout 5 - -max-time 15 -w %%{speed_download}') do (
set /a speed_download=%%i/1024
cls&echo !ip! average speed !speed_download! kB/s
)
)
goto :eof

:bettercloudflareip
set /a tasknum=10
set /a bandwidth=1
set /p bandwidth=Please set the desired bandwidth size (default minimum %bandwidth%, unit Mbps):
set /p tasknum=Please set the number of RTT test processes (default %tasknum%, maximum 50):
if %bandwidth% EQU 0 (set /a bandwidth=1)
if %tasknum% EQU 0 (set /a tasknum=10&echo The number of processes cannot be 0, it is automatically set to the default value)
if %tasknum% GTR 50 (set /a tasknum=50&echo exceeds the maximum process limit, automatically set to the maximum value)
set /a speed=bandwidth*128
set /a startH=%time:~0,2%
if %time:~3,1% EQU 0 (set /a startM=%time:~4,1%) else (set /a startM=%time:~3,2%)
if %time:~6,1% EQU 0 (set /a startS=%time:~7,1%) else (set /a startS=%time:~6,2%)
call:start
exit

:start
del rtt.txt data.txt CR.txt CRLF.txt cut.txt speed.txt > nul 2>&1
RD /S /Q rtt > nul 2>&1
if not exist "RTT.bat" echo The current program is incomplete&echo Please download the Release version again: https://github.com/badafans/better-cloudflare-ip/releases&pause > nul&exit
if not exist "CR2CRLF.exe" echo The current program is incomplete&echo Please download the Release version again: https://github.com/badafans/better-cloudflare-ip/releases&pause > nul&exit
set /a n=0
if !ips! EQU ipv4 (echo is generating !ips!&goto getv4) else (echo is generating !ips!&goto getv6)

:getv4
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_.=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv4
if not defined %%i.%%j.%%k.!cidr! set %%i.%%j.%%k.!cidr!=anycastip&set /a n+=1
if !n! EQU 100 goto rtt
)
goto getv4

:getv6
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_:=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv6
if not defined %%i:%%j:%%k:!cidr! set %%i:%%j:%%k:!cidr!=anycastip&set /a n+=1
if !n! EQU 100 goto rtt
)
goto getv6

:randomcidrv4
set /a cidr=%random%%%256
goto :eof

:randomcidrv6
set str=0123456789abcdef
set /a r=%random%%%16
set cidr=!str:~%r%,1!
set /a r=%random%%%16
set ci
