part of '../_data.dart';

// --- login response
@JsonSerializable()
class LoginResponse {
  const LoginResponse({required this.message});

  final String message;

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class OtpVerifyResponse {
  final String access;
  final String refresh;
  final int id;

  @JsonKey(name: "new_user")
  final bool newUser;

  OtpVerifyResponse({
    required this.access,
    required this.refresh,
    required this.id,
    required this.newUser,
  });

  factory OtpVerifyResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyResponseToJson(this);
}