part of '../_screens.dart';

@RoutePage()
class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
    return BlocPresentationProvider(
      create: (context) => LoginCubit(),
      onEvent: (context, event) {

      },
      child: ExtendedScaffold(
        appBar: CustomAppBar(
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
                  onClick: () {
                    FocusScope.of(context).unfocus();
                    context.pushRoute(RouteOtpVerify());
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
      ),
    );
  }
}
