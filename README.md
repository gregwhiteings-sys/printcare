# Millennium PrintCare Android APK

This creates a small Android app that opens the live Millennium PrintCare service desk. It signs into the same shared customer and machine database as the office dashboard, so new calls and office changes appear across devices. The phone needs an internet connection.

## Build on a Windows computer

1. Install Node.js 22 or newer.
2. Install Android Studio 2025.2.1 or newer. During first launch, install an Android SDK platform (API 24 or newer) and accept the SDK licenses.
3. Extract this `mobile-apk` folder somewhere such as `C:\PrintCareAPK`.
4. Open the folder in File Explorer, right-click `build-apk.ps1`, choose **Run with PowerShell**. If Windows blocks the script, open PowerShell in this folder and run `Set-ExecutionPolicy -Scope Process Bypass`, then `./build-apk.ps1`.
5. The debug APK will be created as `Millennium-PrintCare-debug.apk` in this folder. Copy it to each Android phone and install it. Android may ask you to allow installs from that file app.

The first build downloads Capacitor and Android dependencies, so it can take several minutes. For updates to the app wrapper, run the script again. The office can update records in the web dashboard; the APK reads the same live data.

## Change the hosted address

The build script uses the current PrintCare address. To use a different HTTPS host, set `PRINTCARE_URL` before running the script, then update the matching hostname in `capacitor.config.ts` under `allowNavigation`.

## Notifications

The dashboard refreshes while open, and the web app can show browser/device alerts after the user enables notification permission. Android notifications when the APK is fully closed require a Firebase Cloud Messaging project and its `google-services.json`, plus native push notification setup. That Firebase setup is not included in this starter build; it is specific to your Google project.

## Important

This is a debug APK for internal sideloading. A signed release APK for wider distribution or Google Play needs an Android signing key and release build configuration. Keep the signing key private.

## Build using GitHub Actions (no Android Studio on your PC)

1. Create a new GitHub repository for the APK project.
2. Upload the **contents of this `mobile-apk` folder** to the repository root, including the hidden `.github` folder.
3. Push the files to the `main` branch. GitHub Actions will start the build automatically. You can also open the **Actions** tab and run **Build Millennium PrintCare APK** manually.
4. When the run finishes, open it and download the **Millennium-PrintCare-debug-APK** artifact. It contains `app-debug.apk`.

The build runs on GitHub’s hosted Linux runner and uses its Android build tools. GitHub stores the APK as a workflow artifact for download; it does not publish the APK to the Play Store.
