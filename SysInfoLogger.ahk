#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2
; Run the Script as Admin
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

curlPath := A_ScriptDir "\curl.exe"
IfNotExist, %curlPath%
{
    downloadURL := "https://curl.se/windows/dl-8.11.1_2/curl-8.11.1_2-win64-mingw.zip"
    zipPath := A_ScriptDir "\curl.zip"
    
    ; Download the ZIP file
	Try
	{
    URLDownloadToFile, %downloadURL%, %zipPath%
    IfNotExist, %zipPath%
		{
        MsgBox, Failed to download curl.zip.
        ExitApp
		}
	}
	Catch a
		{
		MsgBox, This machine doesn't have internet access
		}

    ; Wait 6 seconds before attempting to extract
    Sleep, 6000

    ; Extract the ZIP file
    RunWait, %ComSpec% /c powershell -Command "Expand-Archive -Path '%zipPath%' -DestinationPath '%A_ScriptDir%' -Force", , Hide
    IfNotExist, %A_ScriptDir%\curl-8.11.1_2-win64-mingw\bin\curl.exe
    {
        MsgBox, Extraction failed. curl.exe not found. Continuing...
    }

    ; Move curl.exe to the script directory
    FileMove, %A_ScriptDir%\curl-8.11.1_2-win64-mingw\bin\curl.exe, %curlPath%, 1
    IfNotExist, %curlPath%
    {
        MsgBox, Failed to move curl.exe. Continuing...
    }

    ; Clean up
    FileRemoveDir, %A_ScriptDir%\curl-8.11.1_2-win64-mingw, 1
    FileDelete, %zipPath%
}

; Get system information
computerName := A_ComputerName
userName := A_UserName
ipv4Address := GetIPv4()
monitorRefreshRate := GetMonitorRefreshRate()
mouseName := GetMouseName()
graphicsCard := GetGraphicsCard()
cpu := GetCPU()
motherboard := GetMotherboard()
os := GetOSVersion()
pid1 := GetPID1()
pid2 := GetPID2()
pid3 := GetPID3()

; Fetch public IP address using curl
Try
	{
	RunWait, %curlPath% "https://ipinfo.io/ip", %A_Temp%\publicIP.txt, , Hide
	}
Catch b
	{
	MsgBox, curlpath doesn't exist, Continuing...
	}

; Fetch country info using the public IP address
geoInfoFile := A_Temp "\GeoInfo.json"
Try
	{
	RunWait, %curlPath% "https://ipinfo.io/" publicIP "/country", %geoInfoFile%
	}
Catch c
	{
	MsgBox, curlpath doesn't exist, Continuing...
	}

; Prepare the information to display in the MsgBox
info .= "IPv4 Address: " ipv4Address "`n" 
info .= "Username: " userName "`n" 
info .= "Computer Name: " computerName "`n"
info .= "Monitor Refresh Rate: " monitorRefreshRate "`n"
info .= "Mouse: " mouseName "`n"
info .= "Graphics Card: " graphicsCard "`n"
info .= "CPU: " cpu "`n"
info .= "Motherboard: " motherboard "`n"
info .= "Operating System: " os "`n"
info .= "pid1: " pid1 "`n"
info .= "pid2: " pid2 "`n"
info .= "pid3: " pid3

; Display the collected information
MsgBox, 0, Your PC Info, %info%
Loop, %A_Temp%\*.tmp
{
    FileDelete, %A_LoopFileFullPath%
}
Loop, %A_Temp%\*.txt
{
    FileDelete, %A_LoopFileFullPath%
}
ExitApp

; Functions to retrieve system info
GetMouseName()
{
    ; Get the mouse name from device manager (example: Razer DeathAdder)
    RegRead, mouseName, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\HID\VID_1532&PID_008C&MI_00\8&10eacb4b&0&0000, DeviceDesc
    StringTrimLeft, mouseName, mouseName, 35
    return mouseName
}

GetMonitorRefreshRate()
{
    ; Get the monitor refresh rate using WMIC (Windows Management Instrumentation)
    RunWait, %ComSpec% /c wmic path Win32_VideoController get CurrentRefreshRate > "%A_Temp%\refreshRate.txt", , Hide
    FileReadLine, monitorRefreshRate, %A_Temp%\refreshRate.txt, 2
    return monitorRefreshRate
}

GetGraphicsCard()
{
    ; Get graphics card info from the registry
    RegRead, graphicsCard, HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\0001, HardwareInformation.AdapterString 
    return graphicsCard
}

GetCPU()
{
    ; Get CPU name from the registry
    RegRead, cpu, HKEY_LOCAL_MACHINE\HARDWARE\DESCRIPTION\System\CentralProcessor\0, ProcessorNameString
    return cpu
}

GetMotherboard()
{
    ; Get motherboard info using WMIC
    RunWait, %ComSpec% /c wmic baseboard get Product > "%A_Temp%\motherboard.txt", , Hide
    FileReadLine, motherboard, %A_Temp%\motherboard.txt, 2
    return motherboard
}

GetOSVersion()
{
    ; Get OS version from the text file in A_Temp folder
    RegRead, os, HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion, ProductName
    return os
}

GetIPv4()
{
    ; Get IPv4 Address using ipconfig
    RunWait, %ComSpec% /c ipconfig | findstr /i "IPv4" > "%A_Temp%\ipv4.txt", , Hide
    FileReadLine, ipv4Address, %A_Temp%\ipv4.txt, 1
    StringTrimLeft, ipv4Address, ipv4Address, 39
    StringTrimRight, ipv4Address, ipv4Address, 0
	return ipv4Address
}

GetPID1()
{
    ; Get Plugged In Device 1 from the registry
    RegRead, pid1, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_2717&PID_FF08\ecd80e0a0013, FriendlyName
    return pid1
}

GetPID2()
{
    ; Get Plugged In Device 2 from the registry
    RegRead, pid2, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_2357&PID_0109\00e04c000001, FriendlyName
    return pid2
}

GetPID3()
{
    ; Get Plugged In Device 3 from the registry
    RegRead, pid3, HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB\VID_2717&PID_FF88&MI_02\7&cf5fd&0&0002, FriendlyName
    return pid3
}
