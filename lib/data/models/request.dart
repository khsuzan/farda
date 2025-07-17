part of '../_data.dart';

// --- login request form
@JsonSerializable()
class LoginRequest {
  const LoginRequest({required this.phone});

  final String phone;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class OtpVerifyRequest {
  const OtpVerifyRequest({required this.phone, required this.otp});

  final String phone;
  final String otp;

  factory OtpVerifyRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpVerifyRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerifyRequestToJson(this);
}
