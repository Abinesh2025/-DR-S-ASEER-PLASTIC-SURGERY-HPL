import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/search_doctor_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/search_doctor_card.dart';

import '../../../utils/string_utils.dart';

class AllDoctorsScreen extends StatelessWidget {
  const AllDoctorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: AppBar(
        title: Text(
          "All Doctors",
          style: TextStyleConst.boldTextStyle(Colors.black87, 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87),
            onPressed: () => Get.to(() => const SearchDoctorScreen()),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: GetBuilder<PatientHomeController>(
        builder: (controller) {
          if (controller.isAllDoctorsLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.allDoctors.isEmpty) {
            return Center(
              child: Text(
                StringUtils.noDoctorsAvailable,
                style: TextStyleConst.mediumTextStyle(Colors.grey, 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: controller.allDoctors.length,
            itemBuilder: (context, index) {
              final doctor = controller.allDoctors[index];
              return SearchDoctorCard(
                doctor: doctor,
                onTap: () {
                  context.push('/doctor-details', extra: {
                    'doctor': doctor,
                    'doctorId': doctor.id!,
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
