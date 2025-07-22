
import 'package:farda/components/_components.dart';
import 'package:farda/routes/routes.dart';
import 'package:farda/screens/prescription_info/screen_prescription.dart';
import 'package:farda/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
                  // context.pushRoute(RouteSubscription());
                  // context.go(CustomRoutePaths.prescription);
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> ScreenPrescription()));
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
