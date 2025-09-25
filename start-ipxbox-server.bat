@echo off
setlocal enabledelayedexpansion

:: Config
set "HOST=8.8.8.8"
set "PORT=53"
set "CMD=ipxbox.exe --port=10000"

echo [*] Detecting primary IPv4...

:: Method 1: PowerShell Get-NetIPConfiguration (default-gateway interface)
for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command ^
  "$c=Get-Command Get-NetIPConfiguration -ErrorAction SilentlyContinue; if($c){$x=Get-NetIPConfiguration ^| ?{ $_.IPv4DefaultGateway } ^| Select-Object -First 1; if($x){'$($x.InterfaceAlias)|$($x.IPv4Address.IPAddress)|$($x.IPv4DefaultGateway.NextHop)'}}"` ) do (
  for /f "tokens=1-3 delims=|" %%I in ("%%A") do (set IFACE=%%I& set IP=%%J& set GW=%%K)
)
if defined IP echo [+] Via Get-NetIPConfiguration: !IP! (if: !IFACE!, gw: !GW!)

:: Method 2: Socket
if not defined IP (
  for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command ^
    "$s=New-Object Net.Sockets.Socket('InterNetwork','Dgram','Udp');$s.Connect('%HOST%',%PORT%);$e=$s.LocalEndPoint.ToString();$s.Close();$e"` ) do (
      for /f "tokens=1 delims=:" %%I in ("%%A") do set IP=%%I
  )
  if defined IP (set IFACE=socket& set GW=?& echo [+] Via socket: !IP!)
)

:: Method 3: ipconfig
if not defined IP (
  for /f "usebackq tokens=* delims=" %%L in (`ipconfig 2^>nul`) do (
    set "L=%%L"
    for /f "tokens=* delims= " %%x in ("!L!") do set "L=%%x"
    if "!L:~-1!"==":" (set "IFACE=!L:~0,-1!") else (
      echo !L!|findstr /i "IPv4 Address IPv4-Adresse Adresse IPv4" >nul && (
        for /f "tokens=2 delims=:" %%a in ("!L!") do (set "IP=%%a"& set "IP=!IP: =!")
      )
    )
  )
  if defined IP (set GW=?& echo [+] Via ipconfig: !IP! (if: !IFACE!))
)

if not defined IP (echo [!] Could not determine IP.& set "IP=<not found>") else echo [OK] Primary IP: !IP!

:: Non-blocking modal popup
start "" powershell -NoProfile -Command "try{Add-Type -AssemblyName PresentationFramework;[System.Windows.MessageBox]::Show('Main IP Address: %IP%','Primary IP')|Out-Null}catch{[System.Diagnostics.Process]::Start('mshta','javascript:alert(^''Main IP Address: %IP%^'');close()')}" 

:: Start server right away
echo [*] Starting: %CMD%
%CMD%
if errorlevel 1 (echo [!] Server failed or exited with error.) else (echo [*] Server exited.)

endlocal
