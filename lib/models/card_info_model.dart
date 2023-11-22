import 'package:json_annotation/json_annotation.dart';

part 'card_info_model.g.dart';

/// [CardInfoModel] is a Dart class automatically generated using json_annotation. It represents card information
/// obtained from a scanning process, typically used in applications that involve credit card scanning or processing.

/// Properties:
/// - [number]: A string representing the card number.
/// - [expiryDate]: A string representing the card's expiry date.
/// - [expiryMonth]: An integer representing the card's expiry month.
/// - [cardholderName]: A string representing the name of the cardholder.

/// Example Usage:
/// ```dart
/// // Creating an instance of CardInfoModel
/// CardInfoModel cardInfo = CardInfoModel(
///   number: "1234 5678 9012 3456",
///   expiryDate: "2023 or 23",
///   expiryMonth: 12,
///   cardholderName: "John Doe",
/// );
/// ```

/// Note: This class is typically used for serializing and deserializing JSON data related to card information,
/// and it serves as a model for representing card details in the Dart programming language.
@JsonSerializable()
class CardInfoModel {
  /// Card number.
  final String? number;

  /// Expiry year of the card.
  final String? expiryDate;

  /// Expiry month of the card.
  final String? expiryMonth;

  /// Name of the cardholder.
  final String? cardholderName;

  /// Constructor for creating a [CardInfoModel] instance.
  CardInfoModel({
    this.number,
    this.expiryDate,
    this.expiryMonth,
    this.cardholderName,
  });

  /// Factory method for creating a [CardInfoModel] instance from a JSON map.
  factory CardInfoModel.fromJson(Map<String, dynamic> json) =>
      _$CardInfoModelFromJson(json);

  /// Method for converting a [CardInfoModel] instance to a JSON map.
  Map<String, dynamic> toJson() => _$CardInfoModelToJson(this);

  @override
  String toString() {
    return 'CardInfoModel{number: $number, expiryDate: $expiryDate, expiryMonth: $expiryMonth, cardholderName: $cardholderName}';
  }
}
