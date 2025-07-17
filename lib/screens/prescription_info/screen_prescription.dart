part of '../_screens.dart';

@RoutePage()
class ScreenPrescription extends StatelessWidget {
  const ScreenPrescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
    return ExtendedScaffold(
      appBar: CustomAppBar(
        titleType: AppBarTitleType.text,
        titleText: "Prescription Info",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: spacing.horizontalDefault,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              28.verticalSpace,
              TextMedium(
                text:
                    "Enter the prescription number and store number from your label.",
              ),
              22.verticalSpace,
              TextField(
                decoration: InputDecoration(
                  hintText: "7-digit prescription number",
                ),
              ),
              12.verticalSpace,
              TextField(
                decoration: InputDecoration(hintText: "4-digit store number"),
              ),
              12.verticalSpace,
              TextField(
                decoration: InputDecoration(hintText: "Pill count quantity"),
              ),
              12.verticalSpace,
              TextField(
                decoration: InputDecoration(
                  hintText: "Date of Birth",
                  suffixIcon: Icon(
                    Icons.calendar_month,
                    color: colors.slate[500],
                  ),
                ),
              ),
              12.verticalSpace,
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
              36.verticalSpace,
              ButtonPrimary(text: "Continue", onClick: () {
                context.pushRoute(RouteHome());
              }),
              12.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}
