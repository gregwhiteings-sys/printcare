$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot

if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
  throw 'Install Node.js 22 or newer, then reopen PowerShell.'
}
if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
  throw 'npm was not found. Reinstall Node.js and reopen PowerShell.'
}

if (-not $env:PRINTCARE_URL) {
  $env:PRINTCARE_URL = 'https://millennium-printcare-service-desk.astute-loom-2153.chatgpt.site'
}

npm install
if ($LASTEXITCODE -ne 0) { throw 'npm install failed.' }
if (-not (Test-Path 'android')) {
  npx cap add android
  if ($LASTEXITCODE -ne 0) { throw 'Could not create the Android project.' }
}
npx cap sync android
if ($LASTEXITCODE -ne 0) { throw 'Capacitor sync failed.' }

Push-Location android
try {
  .\gradlew.bat assembleDebug
  if ($LASTEXITCODE -ne 0) { throw 'Android build failed. Open the android folder in Android Studio and resolve the SDK prompt.' }
} finally {
  Pop-Location
}

$apk = Join-Path $PSScriptRoot 'android\app\build\outputs\apk\debug\app-debug.apk'
$copy = Join-Path $PSScriptRoot 'Millennium-PrintCare-debug.apk'
Copy-Item $apk $copy -Force
Write-Host "APK created: $copy" -ForegroundColor Green
