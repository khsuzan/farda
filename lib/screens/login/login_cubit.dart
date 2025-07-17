part of '../_screens.dart';

class LoginCubit extends PresentationCubit<LoginState, LoginEvent> {
  LoginCubit() : super(LoginState.initial());

  final _client = GetIt.I.get<PublicApi>();

  String phoneInput = "";


  void login() async {
    final trimmed = phoneInput.trim();

    // 1. Empty check
    if (trimmed.isEmpty) {
      debugPrint("Phone number is empty");
      showErrorToast("Phone number is empty");
      return;
    }

    // 2. Add default country code if missing
    String normalizedPhone = trimmed;

    if (!trimmed.startsWith('+')) {
      // Example: default to Bangladesh code
      normalizedPhone = '+880$trimmed';
    }

    // Optional: Validate final phone format with regex (basic example)
    final phoneRegex = RegExp(r'^\+\d{10,15}$');
    if (!phoneRegex.hasMatch(normalizedPhone)) {
      debugPrint("Invalid phone format: $normalizedPhone");
      showErrorToast("Invalid phone format: $normalizedPhone");
      return;
    }

    try {
      // 3. Call API
      final body = LoginRequest(phone: normalizedPhone);
      await _client.login(body);
    } on DioException catch (dioError) {
      // Handle Dio-specific errors
      debugPrint("Dio error: ${dioError.message}");
      String message = "Something went wrong. Please try again.";

      if (dioError.type == DioExceptionType.connectionTimeout ||
          dioError.type == DioExceptionType.receiveTimeout) {
        message = "Connection timed out. Please check your internet.";
      } else if (dioError.type == DioExceptionType.badResponse) {
        message = "Server responded with error: ${dioError.response?.statusCode}";
        if (dioError.response?.data is Map && dioError.response?.data['message'] != null) {
          message = dioError.response?.data['message'];
        }
      } else if (dioError.type == DioExceptionType.unknown) {
        message = "Unexpected error occurred. Please try again.";
      }

      showErrorToast(message);
    } catch (e, stack) {
      // Handle all other errors
      debugPrint("Unexpected error: $e\n$stack");
      showErrorToast("Unexpected error occurred. Please try again.");
    }
  }
}
