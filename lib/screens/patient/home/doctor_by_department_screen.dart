import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/home_controller/patient_home_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_list_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/search_doctor_card.dart';

class DoctorByDepartmentScreen extends StatelessWidget {
  final int departmentId;
  final String departmentName;

  const DoctorByDepartmentScreen(
      {super.key, required this.departmentId, required this.departmentName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PatientHomeController>();

    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:
              const Icon(Icons.arrow_back_ios, color: Colors.black87, size: 20),
        ),
        title: Text(
          departmentName,
          style: TextStyleConst.boldTextStyle(Colors.black87, 18),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DoctorListModel>(
        future: controller.getDoctorsByDepartmentIdRich(departmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return  Center(
                child:
                    CircularProgressIndicator(color: ColorConst.primaryColor));
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData ||
              snapshot.data?.data == null ||
              snapshot.data!.data!.isEmpty) {
            return const Center(
                child: Text("No doctors found in this department."));
          }

          final doctors = snapshot.data!.data!;

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemCount: doctors.length,
            itemBuilder: (context, index) {
              final doctor = doctors[index];
              return SearchDoctorCard(
                doctor: doctor,
                onTap: () {
                  context.push('/doctor-details', extra: {
                    'doctor': doctor,
                    'doctorId': doctor.id ?? 0,
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
