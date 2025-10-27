import 'package:farda/application/authentication/repo/authentication_repo.dart';
import 'package:farda/components/_components.dart';
import 'package:farda/components/custom_snackbar.dart';
import 'package:farda/screens/login/login_provider.dart';
import 'package:farda/screens/otp_verify/screen_otp_verify.dart';
import 'package:farda/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
    final loginProvider = context.watch<LoginProvider>();
    return ExtendedScaffold(
      appBar: CustomAppBar(
        onBack: () {
          context.go("/");
        },
        titleType: AppBarTitleType.logo,
        logo: Image.asset(
          "assets/images/farda_large_grey.png",
          height: 0.03.sh,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: spacing.horizontalDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.verticalSpace,
              Text(
                "Enter your mobile number",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.baseBlack,
                  fontSize: 15.sp,
                ),
              ),
              6.verticalSpace,
              PhoneNumberInput(
                onPhoneNumberChanged: (phoneNumber) {
                  // Handle phone number changes
                },
                onCountryChanged: (country) {
                  // Handle country selection changes
                },
                hintText: 'Mobile number',
              ),
              20.verticalSpace,
              ButtonPrimary(
                text: "Continue",
                onClick: () async {
                  FocusScope.of(context).unfocus();

                  // context.pushRoute(RouteOtpVerify());
                  //TODO: true for bypass
                  bool response = true ?? await loginProvider.sendOtpApi();
                  if (response == true) {
                    // ignore: use_build_context_synchronously
                    // context.go("/otp-verify");
                    CustomSnackbar.show(
                      context,
                      message: "Your OTP has been sent to your phone.",
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ScreenOtpVerify()),
                    );
                  }
                },
              ),
              16.verticalSpace,
              DividerTextHorizontal(text: "or"),
              16.verticalSpace,
              ButtonSecondary(
                prefixIcon: SvgPicture.asset("assets/icons/apple.svg"),
                text: "Continue With Apple",
                onClick: () {},
              ),
              12.verticalSpace,
              ButtonSecondary(
                prefixIcon: SvgPicture.asset("assets/icons/facebook.svg"),
                text: "Continue With Facebook",
                onClick: () {},
              ),
              12.verticalSpace,
              ButtonSecondary(
                prefixIcon: SvgPicture.asset("assets/icons/google.svg"),
                text: "Continue With Google",
                onClick: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
