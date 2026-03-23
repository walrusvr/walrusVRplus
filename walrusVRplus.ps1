# Set background color
$Host.UI.RawUI.BackgroundColor = "Black"

# Set text color
$Host.UI.RawUI.ForegroundColor = "Green"

# Add current directory to PATH
$env:PATH += ";$PWD"

# Base URL for Ordinals content
$baseOrdinalUrl = "https://ordinals.com/content/"

# Define permissions and features lists
$prohibited = @(
    "ACCEPT_HANDOVER","ACCESS_BACKGROUND_LOCATION","ACCESS_CHECKIN_PROPERTIES",
    "ACCESS_COARSE_LOCATION","ACCESS_FINE_LOCATION","ACCESS_LOCATION_EXTRA_COMMANDS",
    "ACCESS_NOTIFICATION_POLICY","ACCOUNT_MANAGER","ACTIVITY_RECOGNITION",
    "ADD_VOICEMAIL","ANSWER_PHONE_CALLS","BIND_ACCESSIBILITY_SERVICE",
    "BIND_APPWIDGET","BIND_AUTOFILL_SERVICE","BIND_CALL_REDIRECTION_SERVICE",
    "BIND_CARRIER_MESSAGING_CLIENT_SERVICE","BIND_CARRIER_MESSAGING_SERVICE",
    "BIND_CARRIER_SERVICES","BIND_CHOOSER_TARGET_SERVICE","BIND_CONDITION_PROVIDER_SERVICE",
    "BIND_CONTROLS","BIND_DEVICE_ADMIN","BIND_DREAM_SERVICE","BIND_INCALL_SERVICE",
    "BIND_INPUT_METHOD","BIND_MIDI_DEVICE_SERVICE","BIND_NFC_SERVICE",
    "BIND_NOTIFICATION_LISTENER_SERVICE","BIND_PRINT_SERVICE","BIND_QUICK_ACCESS_WALLET_SERVICE",
    "BIND_QUICK_SETTINGS_TILE","BIND_REMOTEVIEWS","BIND_SCREENING_SERVICE",
    "BIND_TELECOM_CONNECTION_SERVICE","BIND_TEXT_SERVICE","BIND_TV_INPUT",
    "BIND_VISUAL_VOICEMAIL_SERVICE","BIND_VOICE_INTERACTION","BIND_VR_LISTENER_SERVICE",
    "BIND_WALLPAPER","BLUETOOTH_PRIVILEGED","BODY_SENSORS","BROADCAST_PACKAGE_REMOVED",
    "BROADCAST_SMS","BROADCAST_WAP_PUSH","CALL_PHONE","CALL_PRIVILEGED",
    "CAMERA","CAPTURE_AUDIO_OUTPUT","CHANGE_COMPONENT_ENABLED_STATE",
    "CHANGE_CONFIGURATION","CLEAR_APP_CACHE","CONTROL_LOCATION_UPDATES",
    "DELETE_CACHE_FILES","DELETE_PACKAGES","DIAGNOSTIC","DUMP","FACTORY_TEST",
    "GET_ACCOUNTS","GET_ACCOUNTS_PRIVILEGED","INSTALL_LOCATION_PROVIDER",
    "INSTALL_PACKAGES","INSTANT_APP_FOREGROUND_SERVICE","LOADER_USAGE_STATS",
    "LOCATION_HARDWARE","MANAGE_DOCUMENTS","MANAGE_MEDIA","MANAGE_ONGOING_CALLS",
    "MASTER_CLEAR","MEDIA_CONTENT_CONTROL","MODIFY_PHONE_STATE","MOUNT_FORMAT_FILESYSTEMS",
    "MOUNT_UNMOUNT_FILESYSTEMS","PACKAGE_USAGE_STATS","PROCESS_OUTGOING_CALLS",
    "READ_CALENDAR","READ_CALL_LOG","READ_CONTACTS","READ_INPUT_STATE",
    "READ_LOGS","READ_PHONE_NUMBERS","READ_PHONE_STATE","READ_PRECISE_PHONE_STATE",
    "READ_SMS","READ_VOICEMAIL","REBOOT","RECEIVE_MMS","RECEIVE_SMS","RECEIVE_WAP_PUSH",
    "REQUEST_DELETE_PACKAGES","REQUEST_INSTALL_PACKAGES","SEND_RESPOND_VIA_MESSAGE",
    "SEND_SMS","SET_ALWAYS_FINISH","SET_ANIMATION_SCALE","SET_DEBUG_APP",
    "SET_PROCESS_LIMIT","SET_TIME","SET_TIME_ZONE","SIGNAL_PERSISTENT_PROCESSES",
    "SMS_FINANCIAL_TRANSACTIONS","START_FOREGROUND_SERVICES_FROM_BACKGROUND",
    "START_VIEW_PERMISSION_USAGE","STATUS_BAR","SYSTEM_ALERT_WINDOW","UNINSTALL_SHORTCUT",
    "UPDATE_DEVICE_STATS","USE_ICC_AUTH_WITH_DEVICE_IDENTIFIER","USE_SIP","WRITE_APN_SETTINGS",
    "WRITE_CALENDAR","WRITE_CALL_LOG","WRITE_CONTACTS","WRITE_GSERVICES",
    "WRITE_SECURE_SETTINGS","WRITE_SETTINGS","WRITE_VOICEMAIL" )

$restricted = @(
    "ACCESS_MEDIA_LOCATION","READ_EXTERNAL_STORAGE","BATTERY_STATS","BLUETOOTH_CONNECT",
    "BLUETOOTH_SCAN","BLUETOOTH_ADMIN","CHANGE_WIFI_STATE","FOREGROUND_SERVICE",
    "KILL_BACKGROUND_PROCESSES","MANAGE_EXTERNAL_STORAGE","MODIFY_AUDIO_SETTINGS",
    "QUERY_ALL_PACKAGES","RECORD_AUDIO","RECEIVE_BOOT_COMPLETED","SCHEDULE_EXACT_ALARM",
    "SET_ALARM","WAKE_LOCK","WRITE_EXTERNAL_STORAGE" )

$nonVR = @(
"android.hardware.telephony",
"android.hardware.camera.flash",
"android.hardware.nfc",
"android.hardware.location.gps",
"android.hardware.screen.portrait",
"android.hardware.screen.landscape",
"android.hardware.fingerprint",
"com.google.android.gms",
"android.hardware.telephony.gsm",
"android.hardware.touchscreen",
"android.hardware.sensor.barometer",
"android.hardware.sensor.compass",
"android.hardware.sensor.stepcounter",
"android.hardware.sensor.stepdetector",
"android.hardware.usb.host",
"android.hardware.usb.accessory",
"android.hardware.iris",
"android.hardware.face",
"android.hardware.location.network",
"android.hardware.wifi.direct",
"android.software.midi",
"android.software.print",
"android.software.leanback",
"android.hardware.type.automotive",
"android.hardware.camera.front",
"android.hardware.camera.any",
"android.hardware.camera.autofocus",
"android.hardware.consumerir",
"android.hardware.sensor.proximity",
"android.hardware.type.television",
"android.software.live_tv",
"android.hardware.type.watch",
"android.hardware.type.pc",
"android.hardware.keyboard",
"android.hardware.hardware.keystore",
"android.hardware.sensor.heart_rate",
"android.hardware.sensor.heartrate.ecg",
"android.hardware.sensor.heartrate.ppg",
"android.hardware.bluetooth_le",
"android.hardware.ethernet",
"android.software.secure_lock_screen",
"android.software.device_admin" )

# Define commands and their descriptions
$adbCommands = @(



@{ "Description" = "List all connected devices"; "Command" = "adb devices" }

    
    
@{ "Description" = "Get device IP address"; "Command" = "adb shell ip route | Select-String -Pattern 'src ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})' | ForEach-Object { `$_.Matches.Groups[1].Value }" }


    
@{ "Description" = "Connect headset to wireless"; "Command" = "adb tcpip 5555; Start-Sleep -s 3; `$ips = @(adb shell ip route | Select-String -Pattern 'src ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})' | ForEach-Object { `$_.Matches.Groups[1].Value }); Write-Output `$ips; if (`$ips.Count -gt 0) { adb connect ('{0}:5555' -f `$ips[0].Trim()) } else { Write-Output 'Could not determine device IP address.' }" }



@{ "Description" = "Disconnect headset from wireless"; "Command" = "adb tcpip 5555; Start-Sleep -s 3; `$ips = @(adb shell ip route | Select-String -Pattern 'src ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})' | ForEach-Object { `$_.Matches.Groups[1].Value }); Write-Output `$ips; if (`$ips.Count -gt 0) { adb disconnect ('{0}:5555' -f `$ips[0].Trim()) } else { Write-Output 'Could not determine device IP address.' }" }


 
@{ "Description" = "Install base.apk"; "Command" = "adb install base.apk" }


    
@{ "Description" = "List all third party packages"; "Command" = "adb shell cmd package list packages -3" }
    

    
@{ "Description" = "Get app version number"; "Command" = "`$packageName = Read-Host 'Enter package name'; (adb shell dumpsys package `$packageName | findstr versionCode) -replace '.*versionCode=([0-9]+).*', '`$1'" }


    
@{ "Description" = "Find package path"; "Command" = "`$packageName = Read-Host 'Enter package name'; adb shell pm path `$packageName" }
   
    

@{ "Description" = "base.apk file size check"; "Command" = "`$packageName = Read-Host 'Enter package name'; `$packagePath = (adb shell pm path `$packageName).Trim().Replace('package:', ''); `$output = adb shell du -m `$packagePath; `$output | ForEach-Object { `$_ -replace '`t', ' ' } | ForEach-Object { `$(`$_ -split ' ')[0] + ' MB ' + `$(`$_ -split ' ')[1] }" }


    
@{ "Description" = "Pull base.apk"; "Command" = "`$packageName = Read-Host 'Enter package name'; `$packagePath = (adb shell pm path `$packageName).Trim().Replace('package:', ''); adb pull `$packagePath" }


    
@{ "Description" = "Uninstall program"; "Command" = "`$packageName = Read-Host 'Enter package name'; adb uninstall `$packageName" }

    

@{ "Description" = "List OBB folders"; "Command" = "adb shell ls /storage/emulated/0/Android/obb/" }
    
    

@{ "Description" = "List OBB file sizes"; "Command" = "`$obbFolder = Read-Host 'Enter OBB folder name'; adb shell du -m /storage/emulated/0/Android/obb/`$obbFolder/* | ForEach-Object { `$_ -replace '`t', ' ' } | ForEach-Object { `$(`$_ -split ' ')[0] + ' MB ' + `$(`$_ -split ' ')[1] }" }
    
    

@{ "Description" = "Pull OBB folder"; "Command" = "`$obbFolder = Read-Host 'Enter OBB folder name'; adb pull /storage/emulated/0/Android/obb/`$obbFolder" }
    
    

@{ "Description" = "Push OBB folder"; "Command" = "`$obbFolder = Read-Host 'Enter OBB folder name'; adb shell mkdir -p /storage/emulated/0/Android/obb/`$obbFolder; adb push `$obbFolder/. /storage/emulated/0/Android/obb/`$obbFolder/" }

    
    
@{ "Description" = "Take screenshot"; "Command" = "adb shell screencap -p /sdcard/screenshot.png; adb pull /sdcard/screenshot.png" }

    
    
@{ "Description" = "Start screen recording"; "Command" = "Start-Job -ScriptBlock { adb shell screenrecord /sdcard/video.mp4 }" }

    
    
@{ "Description" = "Stop screen recording & pull video"; "Command" = "adb shell pkill -2 screenrecord; sleep 3; adb pull /sdcard/video.mp4" }

    
    
@{ "Description" = "Clear log"; "Command" = "adb logcat -c" }

    
    
@{ "Description" = "Pull log"; "Command" = "adb shell setprop log.tag.Unity DEBUG; adb logcat -d > log.txt" }

    
    
@{ "Description" = "Pull Android Manifest"; "Command" = "aapt2 dump xmltree base.apk --file AndroidManifest.xml > AndroidManifest.txt" }


   
@{ "Description" = "Get package name"; "Command" = "`$output = (aapt2 dump badging base.apk | Select-String 'package: name=').Line.Split('''')[1]; if (`$output) { `$output } else { 'not applicable' }" }



@{ "Description" = "Get install location"; "Command" = "`$output = (aapt2 dump badging base.apk | Select-String 'install-location'); if (`$output) { `$output.Line } else { 'not applicable' }" }



@{ "Description" = "Check android.hardware.vr.headtracking"; "Command" = "`$output = (aapt2 dump badging base.apk | Select-String 'android.hardware.vr.headtracking'); if (`$output) { `$output.Line } else { 'not applicable' }" }



@{ "Description" = "Check Min and Target SDK versions"; "Command" = "`$output = aapt2 dump badging base.apk | Where-Object { `$_ -match 'sdkVersion:' -or `$_ -match 'targetSdkVersion:' }; if (`$output) { `$output -join ""`n"" } else { 'not applicable' }" }



@{ "Description" = "64-bit binary check"; "Command" = "`$output = (aapt2 dump badging base.apk | Select-String 'native-code'); if (`$output) { `$output.Line } else { 'not applicable' }" }



@{ "Description" = "Check debuggable status"; "Command" = "`$output = (aapt2 dump badging base.apk | Select-String 'android:debuggable', 'application-debuggable'); if (`$output) { `$output.Line } else { 'not applicable' }" }



@{ "Description" = "Verify APK signature"; "Command" = "`$env:JAVA_HOME = 'C:\Program Files\Java\jdk-25.0.2'; `$env:Path += ';C:\Program Files\Java\jdk-25.0.2\bin'; `$env:JDK_JAVA_OPTIONS = '--enable-native-access=ALL-UNNAMED'; apksigner verify --verbose base.apk" }



@{ "Description" = "List all permissions used (categorized)"
        "Command" = { $output = aapt2 dump permissions base.apk | Where-Object { $_ -match 'uses-permission: name=' } | ForEach-Object { $_.Split("'")[1] }
            if ($output) {
                $prohibitedMatches = $output | Where-Object { $_ -match ($prohibited -join '|') }
                $restrictedMatches = $output | Where-Object { $_ -match ($restricted -join '|') }
                $otherMatches = $output | Where-Object { $_ -notmatch ($prohibited + $restricted -join '|') }

Write-Host "Prohibited: $(($prohibitedMatches | Sort-Object -Unique) -join "`n")"
                Write-Host "Restricted: $(($restrictedMatches | Sort-Object -Unique) -join "`n")"
                Write-Host "Other: $(($otherMatches | Sort-Object -Unique) -join "`n")"
            } else {
                Write-Host "No permissions found." } } }



@{ "Description" = "List all features used (categorized)"
        "Command" = { $output = aapt2 dump badging base.apk | Where-Object { $_ -match 'uses-feature: name=' } | ForEach-Object { $_.Split("'")[1] }
            if ($output) {
                $nonVRMatches = $output | Where-Object { $_ -match ($nonVR -join '|') }
                $otherMatches = $output | Where-Object { $_ -notmatch ($nonVR -join '|') }

Write-Host "Non-VR features: $(($nonVRMatches | Sort-Object -Unique) -join "`n")"
                Write-Host "Other: $(($otherMatches | Sort-Object -Unique) -join "`n")"
            } else {
                Write-Host "No features found." } } }



@{ "Description" = "Install OVR Metrics Tool"; "Command" = "adb install OVRMetricsTool_v1.6.5.apk" }

  

@{ "Description" = "Open OVR"; "Command" = "adb shell am start omms://app" }

   
 
@{ "Description" = "Start recording OVR metrics to CSV file"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.ENABLE_CSV" }



@{ "Description" = "Enable OVR overlay"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.ENABLE_OVERLAY" }



@{ "Description" = "Disable OVR overlay"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.DISABLE_OVERLAY" }



@{ "Description" = "Enable OVR Render Scale graph"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.ENABLE_GRAPH --es stat render_scale" }

    

@{ "Description" = "Disable OVR Render Scale graph"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.DISABLE_GRAPH --es stat render_scale" }



@{ "Description" = "Enable OVR Asynchronous Spacewarp graph"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.ENABLE_GRAPH --es stat spacewarped_frames_per_second" }



@{ "Description" = "Disable OVR Asynchronous Spacewarp graph"; "Command" = "adb shell am broadcast -n com.oculus.ovrmonitormetricsservice/.SettingsBroadcastReceiver -a com.oculus.ovrmonitormetricsservice.DISABLE_GRAPH --es stat spacewarped_frames_per_second" }



@{ "Description" = "Pull OVR performance logs"; "Command" = "adb pull sdcard/Android/data/com.oculus.ovrmonitormetricsservice/files/CapturedMetrics" } 


    
@{ "Description" = "Pull Performance overview";
    "Command" = "`$packageName = Read-Host 'Enter package name'; `$output = adb shell `"dumpsys cpuinfo | grep `$packageName; dumpsys meminfo `$packageName; dumpsys gfxinfo `$packageName framestats; dumpsys netstats | grep `$packageName; dumpsys batterystats | grep `$packageName; dumpsys SurfaceFlinger | grep `$packageName; dumpsys activity `$packageName`" | Set-Content performance_metrics.txt" }



@{ "Description" = "Find the Oculus VR Shell version"; "Command" = "`$output = (adb shell dumpsys package com.oculus.vrshell | Select-String 'versionCode'); if (`$output) { `$output.Line } else { 'not applicable' }" }


    
@{ "Description" = "Get device serial number"; "Command" = "adb shell getprop ro.serialno" }


    
@{ "Description" = "Reboot device"; "Command" = "adb reboot" }



@{ "Description" = "Enable WiFi on device"; "Command" = "adb shell svc wifi enable" }



@{ "Description" = "Disable WiFi on device"; "Command" = "adb shell svc wifi disable" }



@{ "Description" = "Get headset temperature"; "Command" = "`$t = (adb shell dumpsys battery | findstr temperature | Select-Object -First 1) -replace '[^\d]', ''; if ([string]::IsNullOrWhiteSpace(`$t)) { Write-Output 'Temperature not found' } else { ([math]::Floor([int]`$t / 10)).ToString() + '.' + ([int]`$t % 10) + ' C' }" }



@{ "Description" = "Low battery state simulation"; "Command" = "adb shell dumpsys battery set ac 0; adb shell dumpsys battery set usb 0; adb shell dumpsys battery set wireless 0; adb shell dumpsys battery set level 1; adb shell dumpsys battery unplug" }



@{ "Description" = "Turn off low battery state simulation"; "Command" = "adb shell dumpsys battery reset; adb shell settings put global low_power 0" }



@{ "Description" = "Fetch NFT (Ethereum)";
        Params = @("txHash", "outputFileName")
        "Command" = {
            param ($txHash, $outputFileName)
            Write-Host "Requesting data from LlamaRPC..." -ForegroundColor Cyan
            $uri = "https://eth.llamarpc.com"
            $body = @{ jsonrpc = "2.0"; method = "eth_getTransactionByHash"; params = @($txHash); id = 1 } | ConvertTo-Json
            
            try {
                $response = Invoke-RestMethod -Uri $uri -Method Post -Body $body -ContentType "application/json"
                $input = $response.result.input
                
                if ($null -ne $input -and $input -ne "0x") {
                    
                    $cleanHex = $input -replace '0x','' -replace '[^0-9A-Fa-f]',''
                    
                    $bytes = [byte[]]::new($cleanHex.Length / 2)
                    for ($i = 0; $i -lt $bytes.Length; $i++) {
                        $bytes[$i] = [Convert]::ToByte($cleanHex.Substring($i * 2, 2), 16)
                    }

                    [System.IO.File]::WriteAllBytes($outputFileName, $bytes)
                    Write-Host "Success! Image saved as: $outputFileName" -ForegroundColor Green
                } else {
                    Write-Host "No data found in this transaction." -ForegroundColor Yellow
                }
            } catch {
                Write-Host "Failed to connect to the blockchain." -ForegroundColor Red
            } }
        };



@{ "Description" = "Fetch NFT (Bitcoin)";
        Params = @("inscriptionId", "outputFileName")
        "Command" = {
            param ($inscriptionId, $outputFileName)
            $fullContentUrl = "$baseOrdinalUrl$inscriptionId"
            $Path = $PSScriptRoot
            $outputPath = Join-Path $Path $outputFileName
            Write-Host "Attempting to download Ordinal content" -ForegroundColor Green
            try {
                Invoke-WebRequest -Uri $fullContentUrl `
                                  -OutFile $outputPath `
                                  -TimeoutSec 120 `
                                  -MaximumRedirection 10 `
                                  -Headers @{"User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"} `
                                  -ErrorAction Stop
                Write-Host "Ordinal content successfully downloaded to: $outputPath" -ForegroundColor Green
            } catch {
                Write-Error "Failed to download Ordinal content."
                Write-Error "Error Details: $($_.Exception.Message)"
                Write-Error "Possible reasons: The inscription ID is incorrect, the server is blocking downloads, or there's a network issue."
            } }
        };



@{ "Description" = "Custom command mode"; "Command" = "while (`$true) { `$command = Read-Host 'Enter custom command (or press Enter to exit)'; if (`$command -eq '') { Write-Host 'Exiting custom command mode.'; break }; `$output = cmd /c `$command 2>&1; `$output }" }



)


# Show menu
function Show-Menu {
    Clear-Host
    Write-Host "walrusvr +"
    Write-Host "-------------------"
    $half = [math]::Floor($adbCommands.Count / 2)
    for ($i = 0; $i -lt $half; $i++) {
        Write-Host "$($i + 1). $($adbCommands[$i].Description)" -NoNewline
        Write-Host (" " * (40 - $adbCommands[$i].Description.Length)) -NoNewline
        if ($i + $half -lt $adbCommands.Count) {
            Write-Host "$($i + $half + 1). $($adbCommands[$i + $half].Description)"
        } else {
            Write-Host ""
        }
    }
    if ($adbCommands.Count % 2 -eq 1) {
        Write-Host "$($adbCommands.Count). $($adbCommands[-1].Description)"
    }
    $choice = Read-Host "Enter your choice"
    return $choice
}


function Run-ADBCommand {
    param ($index)
    $command = $adbCommands[$index].Command
    if ($command -is [scriptblock]) {
        if ($adbCommands[$index].Params) {
            $params = @{}
            foreach ($paramName in $adbCommands[$index].Params) {
                $paramValue = Read-Host "Enter $paramName"
                $params[$paramName] = $paramValue
            }
            & $command @params
        } else {
            & $command
        }
    } else {
        if ($adbCommands[$index].Params) {
            $params = @()
            foreach ($paramName in $adbCommands[$index].Params) {
                $paramValue = Read-Host "Enter $paramName"
                $params += $paramValue
            }
            Invoke-Expression "$command $($params -join ' ')"
        } else {
            Invoke-Expression $command
        }
    }
    Write-Host "Command executed."
    Read-Host "Press Enter to continue..."
}

# Main loop
while ($true) {
    $choice = Show-Menu
    if ($choice -eq ($adbCommands.Count + 1).ToString()) {
        exit
    } elseif ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $adbCommands.Count) {
        Run-ADBCommand -index ([int]$choice - 1)
    } else {
        Write-Host "Invalid choice. Please try again."
        Start-Sleep -s 2
    }
}