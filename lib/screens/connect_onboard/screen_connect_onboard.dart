part of '../_screens.dart';

@RoutePage()
class ScreenConnectOnboard extends StatelessWidget {
  const ScreenConnectOnboard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
    return ExtendedScaffold(
      appBar: CustomAppBar(
        titleType: AppBarTitleType.text,
        titleText: "Connect Your farda.\nMedical Vial",
      ),
      body: SafeArea(
        child: Padding(
          padding: spacing.horizontalDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              24.verticalSpace,
              TextMedium(
                text:
                    "Connect your farda. Medicine Vial. Connect your vial to the charger. Please make sure that both Bluetooth and Wifi is enabled on your device.",
              ),
              Expanded(
                child: Center(
                  child: Image.asset("assets/images/vial_bottle.png"),
                ),
              ),
              16.verticalSpace,
              ButtonPrimary(
                text: "Setup Vial",
                onClick: () {
                  context.pushRoute(RouteSubscription());
                },
              ),
              8.verticalSpace,
              TextMedium(
                text: "No farda. medicine vial yet?",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              16.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
