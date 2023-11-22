// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardInfoModel _$CardInfoModelFromJson(Map<String, dynamic> json) =>
    CardInfoModel(
      number: json['number'] as String?,
      expiryDate: json['expiryDate'] as String?,
      expiryMonth: json['expiryMonth'] as String?,
      cardholderName: json['cardholderName'] as String?,
    );

Map<String, dynamic> _$CardInfoModelToJson(CardInfoModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'expiryDate': instance.expiryDate,
      'expiryMonth': instance.expiryMonth,
      'cardholderName': instance.cardholderName,
    };
