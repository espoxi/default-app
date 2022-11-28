import 'package:espoxiapp/common/persistence.dart';
import 'package:json_annotation/json_annotation.dart';
part 'wifi.g.dart';

@JsonSerializable()
class Credentials implements Storable {
  final String ssid;
  final String? psk;

  const Credentials({required this.ssid, this.psk});

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$CredentialsToJson(this);
}
