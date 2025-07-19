
import 'package:farda/components/_components.dart';
import 'package:farda/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ScreenMore extends StatelessWidget {
  const ScreenMore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
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
                drName: "Pharmacy or Doctor Name",
                address: "Address Here",
                patientName: "Mr. Darren Hopkin",
                rxNumber: "7654321",
                storeNumber: "8910",
                title: "Amoxicillin Capsule 500 mg",
                description:
                    "Take 500mg three times (3x) a day for five (5) days.",
                quantity: "15",
                notification: "Refills Remaining upon request",
                sideEffects:
                    "May cause nausea, vomiting, and diarrhea. Contact your healthcare provider right away if you experience any serious side effects",
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
