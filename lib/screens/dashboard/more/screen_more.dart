import 'package:farda/components/_components.dart';
import 'package:farda/screens/prescription_info/prescription_provider.dart';
import 'package:farda/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ScreenMore extends StatelessWidget {
  const ScreenMore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
    final prescriptionProvider = context.watch<PrescriptionProvider>();
    return Scaffold(
      appBar: CustomAppBar(titleType: AppBarTitleType.text, titleText: ""),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: spacing.horizontalDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_profileCard()],
              ),
              20.verticalSpace,
              Text(
                "Terry Roberts",
                style: theme.textTheme.titleLarge?.merge(
                  TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              4.verticalSpace,
              TextMedium(text: "Palo Alto, CA"),
              Divider(color: colors.slate.shade100, height: 40.h),
              Text(
                "Mood Calendar",
                style: theme.textTheme.titleMedium?.merge(
                  TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              TextMedium(
                text: "Collected from app openings and mood check-in’s",
                style: TextStyle(color: colors.slate.shade600),
              ),
              24.verticalSpace,
              WeekCalendar(
                onDateSelected: (date) {
                  // context.router.push(RouteEmoji());
                },
              ),
              Divider(color: colors.slate.shade100, height: 40.h),
              //  Progress Section
              PillProgressSection(
                remainingValue: "480",
                consumedValue: 740,
                consumedMax: 1000,
                targetValue: "1220",
              ),
              12.verticalSpace,
              // prescription view
              PrescriptionView(
                drName:
                    prescriptionProvider
                        .prescriptionModel
                        .pharmacyOrDoctorName ??
                    "Doctor Name",
                address:
                    prescriptionProvider.prescriptionModel.address ??
                    "Address not found",
                patientName: "Tom Cruse",
                rxNumber:
                    prescriptionProvider.prescriptionModel.rxNumber ?? "N/A",
                storeNumber:
                    prescriptionProvider.prescriptionModel.storeNumber ?? "N/A",
                title:
                    prescriptionProvider
                                .prescriptionModel
                                .medicinesNames
                                ?.isNotEmpty ==
                            true
                        ? prescriptionProvider
                                .prescriptionModel
                                .medicinesNames!
                                .first
                                .medicineName ??
                            "Medicine Name"
                        : "No Medicine",
                description:
                    prescriptionProvider
                                .prescriptionModel
                                .medicinesNames
                                ?.isNotEmpty ==
                            true
                        ? prescriptionProvider
                                .prescriptionModel
                                .medicinesNames!
                                .first
                                .instructions ??
                            "No Instructions"
                        : "No Instructions",
                quantity:
                    prescriptionProvider
                                .prescriptionModel
                                .medicinesNames
                                ?.isNotEmpty ==
                            true
                        ? prescriptionProvider
                                .prescriptionModel
                                .medicinesNames!
                                .first
                                .qty ??
                            "0"
                        : "0",
                notification:
                    prescriptionProvider
                                .prescriptionModel
                                .medicinesNames
                                ?.isNotEmpty ==
                            true
                        ? prescriptionProvider
                                .prescriptionModel
                                .medicinesNames!
                                .first
                                .refillsInfo ??
                            "No Info"
                        : "No Info",
                sideEffects:
                    prescriptionProvider
                                .prescriptionModel
                                .medicinesNames
                                ?.isNotEmpty ==
                            true
                        ? prescriptionProvider
                                .prescriptionModel
                                .medicinesNames!
                                .first
                                .sideEffects ??
                            "None"
                        : "None",
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileCard() {
    return SizedBox(
      width: 80.r,
      height: 80.r,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipOval(
            child: Image.asset("assets/images/profile.png", fit: BoxFit.cover),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/icons/add_image.svg",
                width: 22.r,
                height: 22.r,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
