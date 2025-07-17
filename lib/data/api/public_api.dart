part of '../_data.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class PublicApi {
  factory PublicApi({Dio? dio, String? baseUrl}) =>
      _PublicApi(dio ?? PublicApi._getDio(), baseUrl: baseUrl);

  @POST("/send-otp/")
  Future<LoginResponse> login(@Body() LoginRequest body);

  @POST("/verify-otp/")
  Future<OtpVerifyResponse> verifyOtp(@Body() OtpVerifyRequest body);

  static Dio _getDio() {
    return Dio()..interceptors.add(LogInterceptor());
  }
}
