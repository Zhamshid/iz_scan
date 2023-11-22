# iz_scan

IZScan Flutter Plugin
IZScan is a Flutter plugin that streamlines the process of integrating credit/debit card scanning functionality into your mobile applications. This plugin simplifies the capture of card details, making it easy to implement secure and efficient card scanning features for various financial and payment-related applications.

## Platform Support

| Android | iOS | macOS | Web | Linux | Windows |
|---------|-----|-------|-----|-------|---------|
| ✔       | ✔   |  :x:  | :x: |  :x:  |  :x:    |

## Getting Started
To begin using IZScan in your Flutter project, follow these steps:

Add the IZScan dependency to your ```pubspec.yaml``` file:


```yaml
dependencies:
  iz_scan: ^0.0.1
```
Make sure to check for the latest version on pub.dev.

Run the following command to install the package:
```
flutter pub get
```
### *Don't forget run for ios*
```pod install``` under ```app/ios``` folder

Import the ```IZScan``` package in your Dart code:

```dart 
import 'package:iz_scan/iz_scan.dart';
```

Start using IZScan to enhance your app with card scanning capabilities!

## Usage
```dart
final ValueNotifier<CardInfoModel?> _cardInfo = ValueNotifier(null);
late StreamSubscription<CardInfoModel?> _streamSubscription;

 @override
  void initState() {
    super.initState();
    
    _streamSubscription = IZScan.cardScanStream.listen(
      (cardStreamInfo) {
        if (cardStreamInfo != null) {
          _cardInfo.value = cardStreamInfo;
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print('Error during card scan: $error');
        }
      },
    );
  }

  @override
  void dispose() {
    // Cancel StreamSubscription
    _streamSubscription.cancel();
    super.dispose();
  }

// To call scanner
GestureDetector(onTap: () => await IZScan.startCardScan(),)
```


## Platform-specific Requirements
### Android:

Minimum SDK Version:minSdkVersion 21 or higher.

Ensure the following permissions are added to your AndroidManifest.xml file:


```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.FLASHLIGHT"/>
<uses-permission android:name="android.permission.INTERNET" />
<uses-feature android:name="android.hardware.camera" android:required="false" />
<uses-feature android:name="android.hardware.camera.autofocus" android:required="false" />
```

### iOS:

Minimum iOS Version: 13 or higher.

Add the following entry to your ```Info.plist``` file:

```xml
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to scan credit/debit cards.</string>
```
Integration Tips
For Android, make sure that your minSdk in the app's build.gradle ```android/build.gradle``` is set to 21 or higher:

```gradle
android {
    defaultConfig {
        minSdkVersion 21
        // other configurations...
    }
}
```
and implement this dependencies in the app's build.gradle ```android/build.gradle```

```gradle
dependencies {
    implementation 'com.getbouncer:cardscan-ui:2.1.0004'
    implementation 'com.getbouncer:tensorflow-lite:2.1.0004'
    implementation "com.getbouncer:scan-payment-full:2.1.0004"
}
```


For iOS, ensure that your deployment target is set to 13.0 or higher in your Xcode project settings.

Keep your camera permission handling logic up-to-date with the latest Flutter and plugin versions.

Need Help?
Refer to the Flutter documentation for more information on Flutter development. If you encounter any issues specific to IZScan, please check the plugin's GitHub repository for updates or open an issue for assistance.

# Credits
* Android: [https://github.com/getbouncer/cardscan-android](https://github.com/getbouncer/cardscan-android)
* iOS: [https://github.com/getbouncer/cardscan-ios](https://github.com/getbouncer/cardscan-ios)

