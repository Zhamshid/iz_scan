import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '/models/card_info_model.dart';

/// MIT License

/// Copyright (c) [2023] [Zhamshid Irisbayev]

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

///
/// The `IZScan` class provides methods for configuring and initiating card scanning
/// using the iz_card_scan plugin. This class is designed to facilitate the integration
/// of card scanning functionality into Flutter applications.

/// Usage:
/// ```dart
/// // Configure CardScan with your API key
/// await IZScan.configureCardScan('your_api_key');

/// // Start the card scanning process
/// await IZScan.startCardScan();
///
/// // Listen to card scanning events using the cardScanStream
/// IZScan.cardScanStream.listen((cardInfo) {
///   if (cardInfo != null) {
///     // Handle the scanned card information
///     print('Scanned Card Info: ${cardInfo.number}, ${cardInfo.expiryDate}, ${cardInfo.cardholderName}');
///   }
/// });
/// ```

/// Methods:
/// - `configureCardScan(String apiKey)`: Configures the CardScan plugin with the provided API key.
/// - `startCardScan()`: Initiates the card scanning process. Scanned card information is broadcasted
/// through the `cardScanStream`.

/// Properties:
/// - `cardScanStream`: A stream that broadcasts card scanning events. Subscribe to this stream
/// to receive information about scanned cards.

/// Example:
/// ```dart
/// final apiKey = 'your_api_key';
///
/// // Configure CardScan with your API key
/// await IZScan.configureCardScan(apiKey);
///
/// // Start the card scanning process
/// await IZScan.startCardScan();
///
/// // Listen to card scanning events
/// IZScan.cardScanStream.listen((cardInfo) {
///   if (cardInfo != null) {
///     // Handle the scanned card information
///     print('Scanned Card Info: ${cardInfo.number}, ${cardInfo.expiryDate}, ${cardInfo.cardholderName}');
///   }
/// });
/// ```
class IZScan {
  /// Method channel for communication with the native code.
  static const MethodChannel _channel = MethodChannel('iz_scan');

  /// Stream controller for broadcasting card scan events.
  static final StreamController<CardInfoModel?> _cardScanController =
      StreamController<CardInfoModel?>.broadcast();

  /// NOTE:In proccess, not working at this version
  /// Configures the CardScan plugin with the provided API key.
  /// Returns `null` after successful configuration.
  static Future<CardInfoModel?> configureCardScan(String apiKey) async {
    try {
      await _channel.invokeMethod('configureCardScan', {'apiKey': apiKey});
    } catch (e) {
      if (kDebugMode) {
        print('Error configuring CardScan: $e');
      }
    }
    return null;
  }

  /// Initiates the card scanning process. Scanned card information is broadcasted
  /// through the `cardScanStream`.
  static Future<void> startCardScan() async {
    log("card_scan started");
    try {
      _channel.setMethodCallHandler((call) async {
        if (call.method == "cardScanned") {
          log("card_scan cardScanned");
          try {
            final encodedJson = json.encode(call.arguments);
            var cardInfo = CardInfoModel.fromJson(json.decode(encodedJson));
            _cardScanController.add(cardInfo);

            log("card_scan cardInfo => ${cardInfo.number} ${cardInfo.expiryDate} ${cardInfo.expiryMonth} ${cardInfo.cardholderName}");
          } catch (e) {
            log('Error decoding card info: $e');
          }
        }
      });

      final result = await _channel.invokeMethod('startCardScan');
      if (result != null) {
        final encodedJson = json.encode(result);

        var cardInfo = CardInfoModel.fromJson(json.decode(encodedJson));
        _cardScanController.add(cardInfo);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error starting CardScan: $e');
      }
      return;
    } finally {
      _channel.setMethodCallHandler(null);
    }
  }

  /// A stream that broadcasts card scanning events. Subscribe to this stream
  /// to receive information about scanned cards.
  static Stream<CardInfoModel?> get cardScanStream =>
      _cardScanController.stream;
}
