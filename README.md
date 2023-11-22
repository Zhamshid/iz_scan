# iz_scan

IZScan Flutter Plugin
IZScan is a Flutter plugin that streamlines the process of integrating credit/debit card scanning functionality into your mobile applications. This plugin simplifies the capture of card details, making it easy to implement secure and efficient card scanning features for various financial and payment-related applications.

## Getting Started
To begin using IZScan in your Flutter project, follow these steps:

Add the IZScan dependency to your pubspec.yaml file:

yaml
Copy code
dependencies:
  iz_scan: ^1.0.0
Make sure to check for the latest version on pub.dev.

Run the following command to install the package:

bash
Copy code
flutter pub get
Import the IZScan package in your Dart code:

dart
Copy code
import 'package:iz_scan/iz_scan.dart';
Start using IZScan to enhance your app with card scanning capabilities!

## Usage
dart
Copy code
// Example implementation
void startCardScan() async {
  CardDetails cardDetails = await IzScan.scanCard();

  // Use the extracted card details in your application
  print('Card Number: ${cardDetails.cardNumber}');
  print('Expiry Date: ${cardDetails.expiryDate}');
  print('Card Holder Name: ${cardDetails.cardHolderName}');
}


## Platform-specific Requirements
Android:

Minimum SDK Version: 21 (Android 5.0 Lollipop) or higher.

Ensure the following permissions are added to your AndroidManifest.xml file:

xml
Copy code
<uses-permission android:name="android.permission.CAMERA" />
iOS:

Minimum iOS Version: 13 or higher.

Add the following entry to your Info.plist file:

xml
Copy code
<key>NSCameraUsageDescription</key>
<string>We need access to your camera to scan credit/debit cards.</string>
Integration Tips
For Android, make sure that your minSdk in the app's build.gradle is set to 21 or higher:

gradle
Copy code
android {
    defaultConfig {
        minSdkVersion 21
        // other configurations...
    }
}
For iOS, ensure that your deployment target is set to 13.0 or higher in your Xcode project settings.

Keep your camera permission handling logic up-to-date with the latest Flutter and plugin versions.

Need Help?
Refer to the Flutter documentation for more information on Flutter development. If you encounter any issues specific to IZScan, please check the plugin's GitHub repository for updates or open an issue for assistance.

