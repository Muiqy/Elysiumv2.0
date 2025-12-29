@echo off
chcp 65001 > nul
:: 65001 - UTF-8
:: NOT RECOMMENDED

cd /d "%~dp0"
call service.bat status_zapret
call service.bat load_game_filter
call service.bat load_tls_hello
echo:

set "BIN=%~dp0bin\"
set "LISTS=%~dp0lists\"
set "HostListGeneral=%LISTS%list-general.txt"
set "HostListGoogle=%LISTS%list-google.txt"
set "HostListExcludeArg=--hostlist-exclude=%LISTS%list-exclude.txt"
set "IpSetArg=--ipset=%LISTS%ipset-all.txt"
set "IpSetExcludeArg=--ipset-exclude=%LISTS%ipset-exclude.txt"
call service.bat load_custom_lists
set "TlsHello=%BIN%%TlsHelloFile%"
cd /d %BIN%

start "zapret: %~n0" /min "%BIN%winws.exe" --wf-tcp=443,2053,2083,2087,2096,8443,%GameFilter% --wf-udp=443,19294-19344,50000-50100,%GameFilter% ^
--filter-udp=443 --hostlist="%HostListGeneral%" %HostListExcludeArg% %IpSetExcludeArg% --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=19294-19344,50000-50100 --filter-l7=discord,stun --dpi-desync=fake --dpi-desync-fake-discord="%BIN%quic_initial_www_google_com.bin" --dpi-desync-fake-stun="%BIN%quic_initial_www_google_com.bin" --dpi-desync-repeats=6 --new ^
--filter-l3=ipv4 --filter-tcp=443,2053,2083,2087,2096,8443,%GameFilter% %HostListExcludeArg% %IpSetExcludeArg% --dpi-desync=syndata,multidisorder --new ^
--filter-udp=443 %IpSetArg% %HostListExcludeArg% %IpSetExcludeArg% --dpi-desync=fake --dpi-desync-repeats=6 --dpi-desync-fake-quic="%BIN%quic_initial_www_google_com.bin" --new ^
--filter-udp=%GameFilter% %IpSetArg% %IpSetExcludeArg% --dpi-desync=fake --dpi-desync-autottl=2 --dpi-desync-repeats=14 --dpi-desync-any-protocol=1 --dpi-desync-fake-unknown-udp="%BIN%quic_initial_www_google_com.bin" --dpi-desync-cutoff=n3







