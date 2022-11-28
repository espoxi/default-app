// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wifi.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Credentials _$CredentialsFromJson(Map<String, dynamic> json) => Credentials(
      ssid: json['ssid'] as String,
      psk: json['psk'] as String,
    );

Map<String, dynamic> _$CredentialsToJson(Credentials instance) =>
    <String, dynamic>{
      'ssid': instance.ssid,
      'psk': instance.psk,
    };
