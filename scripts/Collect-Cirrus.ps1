$ErrorActionPreference = 'Stop'
$out = Join-Path $PWD ('cirrus-windows-' + (Get-Date -Format yyyyMMdd-HHmmss) + '.txt')
$devices = Get-PnpDevice -PresentOnly | Where-Object {
    $_.InstanceId -match 'CSC3551|VEN_CSC&DEV_3551|VEN_8086&DEV_7A79|VEN_10EC&DEV_0294' -or
    $_.FriendlyName -match 'Cirrus|Smart Amp'
}
& {
    Get-CimInstance Win32_BIOS | Select-Object SMBIOSBIOSVersion | Format-List | Out-String
    Get-CimInstance Win32_OperatingSystem | Select-Object Caption,Version,BuildNumber | Format-List | Out-String
    foreach ($device in $devices) {
        "=== $($device.FriendlyName) ==="
        $device | Select-Object Status,Class,InstanceId | Format-List | Out-String
        Get-PnpDeviceProperty -InstanceId $device.InstanceId -ErrorAction Continue |
            Where-Object { $_.KeyName -match 'HardwareIds|CompatibleIds|LocationPaths|Parent|Service|DriverInfPath|DriverVersion|ProblemCode|BusReportedDeviceDesc|DriverProvider' } |
            ForEach-Object { '{0}: {1}' -f $_.KeyName, ($_.Data -join '; ') }
        pnputil /enum-devices /instanceid "$($device.InstanceId)" /relations /drivers /resources
        $inf = (Get-PnpDeviceProperty -InstanceId $device.InstanceId -KeyName DEVPKEY_Device_DriverInfPath -ErrorAction SilentlyContinue).Data
        if ($inf -and $inf -match '^oem\d+\.inf$') {
            "=== $inf selected fields ==="
            Select-String -Path (Join-Path "$env:windir\INF" $inf) -Pattern '3551|1CCF|CS35|DriverVer|Firmware|ServiceBinary|Config|Tuning'
        }
    }
} | Out-File -FilePath $out -Encoding utf8 -Width 240
Write-Host "Saved: $out"
