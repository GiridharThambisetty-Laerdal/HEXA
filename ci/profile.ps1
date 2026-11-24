# CI version of the PowerShell profile (no error suppression)
$pkg = 'com.Laerdal.QCPRinstructor'

function Invoke-Adb {
    adb @args
    if ($LASTEXITCODE -ne 0) { throw "adb $($args -join ' ') failed" }
}

function wdump {
    adb shell uiautomator dump --format=dot /sdcard/window_dump.xml
    adb pull /sdcard/window_dump.xml "$PWD/window_dump.xml"
    adb shell rm /sdcard/window_dump.xml
}

function clearapp { adb shell pm clear $pkg }

function giveaccess {
    $perms = 'ACCESS_COARSE_LOCATION','ACCESS_FINE_LOCATION','CAMERA','GET_ACCOUNTS',
             'POST_NOTIFICATIONS','READ_PHONE_STATE','BLUETOOTH_SCAN','BLUETOOTH_CONNECT'
    foreach ($p in $perms) { Invoke-Adb shell pm grant $pkg "android.permission.$p" }
}

function trueaccess {
    Invoke-Adb shell settings put secure location_mode 3
    foreach ($p in 'BLUETOOTH_SCAN','BLUETOOTH_CONNECT','ACCESS_FINE_LOCATION') {
        Invoke-Adb shell pm grant $pkg "android.permission.$p"
    }
}

function user_enforced_input { adb shell input text "$($args -join '%s')" }
function hidekeyboard { adb shell input keyevent 4 }
function go_back      { adb shell input keyevent KEYCODE_BACK }

function enable-bt  { adb shell cmd bluetooth_manager enable  | Out-Null; (adb shell settings get global bluetooth_on).Trim() }
function disable-bt { adb shell cmd bluetooth_manager disable | Out-Null; (adb shell settings get global bluetooth_on).Trim() }

function start_appium {
    Start-Process -FilePath "cmd.exe" `
        -ArgumentList '/c','appium','--allow-insecure=uiautomator2:adb_shell','--address','127.0.0.1','--port','4723' `
        -RedirectStandardOutput appium.log -RedirectStandardError appium.err.log `
        -WindowStyle Hidden
    for ($i = 0; $i -lt 45; $i++) {
        try { Invoke-RestMethod http://127.0.0.1:4723/status | Out-Null; Write-Host "Appium is up"; return }
        catch { Start-Sleep 2 }
    }
    Get-Content appium.err.log -ErrorAction SilentlyContinue
    Get-Content appium.log -ErrorAction SilentlyContinue
    throw 'Appium did not start'
}