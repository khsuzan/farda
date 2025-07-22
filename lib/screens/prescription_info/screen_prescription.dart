import 'dart:io';

import 'package:farda/app_const/app_text.dart';
import 'package:farda/components/_components.dart';
import 'package:farda/components/custom_snackbar.dart';
import 'package:farda/routes/routes.dart';
import 'package:farda/screens/dashboard/dashboard_shell.dart';
import 'package:farda/screens/prescription_info/prescription_provider.dart';
import 'package:farda/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ScreenPrescription extends StatelessWidget {
  const ScreenPrescription({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.extension<FardaColors>()!;
    final spacing = theme.extension<Spacing>()!;
    final prescriptionProvider = context.watch<PrescriptionProvider>();
    return ExtendedScaffold(
      appBar: CustomAppBar(
        titleType: AppBarTitleType.text,
        titleText: "Prescription Info",
        iconPath: Icons.photo_camera_outlined,
        isEndIcon: true,
        onIconPress: () async {
          final picker = ImagePicker();

          showModalBottomSheet(
            backgroundColor: colors.baseBlack,
            context: context,
            builder:
                (ctx) => Wrap(
                  children: [
                    ListTile(
                      leading: Icon(Icons.photo_library, color: Colors.white),
                      title: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                        await prescriptionProvider.pickImages(
                          
                        );
                         Navigator.pop(context);
                        // Optionally call the API after picking:
                        await prescriptionProvider.getExtractPrescriptionApi(prescriptionProvider.images);
                        // Handle image
                       
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt, color: Colors.white),
                      title: Text(
                        'Camera',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () async {
                      //  await prescriptionProvider.pickImages(
                      //     source: ImageSource.camera,
                      //   );
                         Navigator.pop(context);
                        // Optionally call the API after picking:
                        // await prescriptionProvider.getExtractPrescriptionApi();
                        // Handle image
                     
                      },
                    ),
                  ],
                ),
          );
        },
      ),
    body: SafeArea(
  child: Stack(
    children: [
      SingleChildScrollView(
        padding: spacing.horizontalDefault,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            28.verticalSpace,
            TextMedium(
              text: "Enter the prescription number and store number from your label.",
            ),
            22.verticalSpace,
            TextField(
              controller: prescriptionProvider.prescriptionNumberController,
              decoration: InputDecoration(hintText: "7-digit prescription number"),
            ),
            12.verticalSpace,
            TextField(
              controller: prescriptionProvider.storeNumberController,
              decoration: InputDecoration(hintText: "4-digit store number"),
            ),
            12.verticalSpace,
            TextField(
              controller: prescriptionProvider.pillQtyController,
              decoration: InputDecoration(hintText: "Pill count quantity"),
            ),
            12.verticalSpace,
            TextField(
              decoration: InputDecoration(
                hintText: "Date of Birth",
                suffixIcon: Icon(Icons.calendar_month, color: colors.slate[500]),
              ),
            ),
            12.verticalSpace,
      PrescriptionView(
  drName: prescriptionProvider.prescriptionModel.pharmacyOrDoctorName ?? "Doctor Name",
  address: prescriptionProvider.prescriptionModel.address ?? "Address not found",
  patientName: "Tom Cruse",
  rxNumber: prescriptionProvider.prescriptionModel.rxNumber ?? "N/A",
  storeNumber: prescriptionProvider.prescriptionModel.storeNumber ?? "N/A",
  title: prescriptionProvider.prescriptionModel.medicinesNames?.isNotEmpty == true
      ? prescriptionProvider.prescriptionModel.medicinesNames!.first.medicineName ?? "Medicine Name"
      : "No Medicine",
  description: prescriptionProvider.prescriptionModel.medicinesNames?.isNotEmpty == true
      ? prescriptionProvider.prescriptionModel.medicinesNames!.first.instructions ?? "No Instructions"
      : "No Instructions",
  quantity: prescriptionProvider.prescriptionModel.medicinesNames?.isNotEmpty == true
      ? prescriptionProvider.prescriptionModel.medicinesNames!.first.qty ?? "0"
      : "0",
  notification: prescriptionProvider.prescriptionModel.medicinesNames?.isNotEmpty == true
      ? prescriptionProvider.prescriptionModel.medicinesNames!.first.refillsInfo ?? "No Info"
      : "No Info",
  sideEffects: prescriptionProvider.prescriptionModel.medicinesNames?.isNotEmpty == true
      ? prescriptionProvider.prescriptionModel.medicinesNames!.first.sideEffects ?? "None"
      : "None",
),
            36.verticalSpace,
            ButtonPrimary(
              text: "Continue",
              onClick: () async{
               final data = await prescriptionProvider.submitPrescriptionApi();
               print(data);
               if(data == true ){
                CustomSnackbar.show(context, message: submitPrescription);
                // context.go(CustomRoutePaths.dashboard);
                Navigator.push(context, MaterialPageRoute(builder: (_)=> ScreenDashboardShell()));
               }else{
                CustomSnackbar.show(context, message: failedPrescriptionSubmit);
               }
                
              },
            ),
            12.verticalSpace,
          ],
        ),
      ),
      // Loading Overlay
      if (prescriptionProvider.isLoading)
        Container(
          color: Colors.black.withOpacity(0.5),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        ),
    ],
  ),
),

    );
  }
}
