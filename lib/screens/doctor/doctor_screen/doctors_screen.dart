// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_screen_controller/doctor_controller.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/doctor_screen/doctor_details_screen.dart';
//
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
//
// class DoctorScreen extends StatelessWidget {
//   DoctorScreen({Key? key}) : super(key: key);
//   final DoctorScreenController doctorController = Get.put(DoctorScreenController());
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Container(
//         color: ColorConst.whiteColor,
//         child: Obx(() {
//           return doctorController.isGetDoctor.value != true
//               ? const Center(child: CircularProgressIndicator())
//               : RefreshIndicator(
//                   onRefresh: () async {
//                     doctorController.isGetDoctor.value = false;
//                     doctorController.getDoctors();
//                   },
//                   child: AnimationLimiter(
//                     child: ListView.builder(
//                       physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
//                       itemCount: doctorController.doctorsModel!.data!.length,
//                       itemBuilder: (context, index) {
//                         return AnimationConfiguration.staggeredList(
//                           position: index,
//                           duration: const Duration(milliseconds: 1000),
//                           child: SlideAnimation(
//                             verticalOffset: 50.0,
//                             child: FadeInAnimation(
//                               child: ListTile(
//                                 contentPadding: EdgeInsets.only(top: index == 0 ? 5 : 0, left: 15, right: 15),
//                                 onTap: () {
//                                   Get.to(
//                                     () => DoctorDetailsScreen(),
//                                     transition: Transition.rightToLeft,
//                                     arguments: doctorController.doctorsModel!.data![index].id,
//                                   );
//                                 },
//                                 leading: SizedBox(
//                                   height: 60,
//                                   width: 60,
//                                   child: ClipOval(
//                                     child: doctorController.doctorsModel!.data![index].doctor_image == null ||
//                                             doctorController.doctorsModel!.data![index].doctor_image!.isEmpty
//                                         ? Image.asset(
//                                             ImageUtils.doctorIcon,
//                                             fit: BoxFit.cover,
//                                           )
//                                         : FadeInImage(
//                                             placeholder: const AssetImage(ImageUtils.doctorIcon),
//                                             image: NetworkImage(
//                                               doctorController.doctorsModel!.data![index].doctor_image!,
//                                             ),
//                                             imageErrorBuilder: (context, error, stackTrace) {
//                                               return Image.asset(
//                                                 ImageUtils.doctorIcon,
//                                                 fit: BoxFit.cover,
//                                               );
//                                             },
//                                             fit: BoxFit.cover,
//                                           ),
//                                   ),
//                                 ),
//                                 title: Text(
//                                   doctorController.doctorsModel!.data![index].doctor_name!,
//                                   style: TextStyleConst.mediumTextStyle(
//                                     ColorConst.blackColor,
//                                     width * 0.045,
//                                   ),
//                                 ),
//                                 subtitle: Text(
//                                   doctorController.doctorsModel!.data![index].doctor_department!,
//                                   style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, width * 0.036),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//         }));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/doctor_screen_controller/doctor_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/doctor/doctor_screen/doctor_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class DoctorScreen extends StatelessWidget {
  DoctorScreen({Key? key}) : super(key: key);
  final DoctorScreenController doctorController = Get.put(DoctorScreenController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      // Soft background to make the white cards pop beautifully
      color: const Color(0xffF5F7FA),
      child: Obx(() {
        if (doctorController.isGetDoctor.value != true) {
          return  Center(
            child: CircularProgressIndicator(color: ColorConst.primaryColor),
          );
        }

        // Handle empty state elegantly
        if (doctorController.doctorsModel?.data == null || doctorController.doctorsModel!.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.medical_services_outlined, size: 80, color: ColorConst.hintGreyColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text(
                  "No Doctors Found",
                  style: TextStyleConst.boldTextStyle(ColorConst.hintGreyColor, 18),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            doctorController.isGetDoctor.value = false;
            doctorController.getDoctors();
          },
          color: ColorConst.primaryColor,
          backgroundColor: Colors.white,
          child: AnimationLimiter(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Added padding around the list
              itemCount: doctorController.doctorsModel!.data!.length,
              itemBuilder: (context, index) {
                var doctor = doctorController.doctorsModel!.data![index];

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600), // Slightly faster, smoother animation
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                                () => DoctorDetailsScreen(),
                            transition: Transition.rightToLeft,
                            arguments: doctor.id,
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.04),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // --- Premium Image Container ---
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: ColorConst.primaryColor.withOpacity(0.2),
                                      width: 2
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorConst.primaryColor.withOpacity(0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: doctor.doctor_image == null || doctor.doctor_image!.isEmpty
                                      ? Image.asset(
                                    ImageUtils.doctorIcon,
                                    fit: BoxFit.cover,
                                  )
                                      : FadeInImage(
                                    placeholder: const AssetImage(ImageUtils.doctorIcon),
                                    image: NetworkImage(doctor.doctor_image!),
                                    fit: BoxFit.cover,
                                    imageErrorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        ImageUtils.doctorIcon,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),

                              // --- Doctor Details ---
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      doctor.doctor_name ?? "Unknown Doctor",
                                      style: TextStyleConst.boldTextStyle(
                                        ColorConst.blackColor,
                                        17,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 6),

                                    // Department as a styled Badge/Chip
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: ColorConst.primaryColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        doctor.doctor_department ?? "General",
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.primaryColor,
                                          12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // --- Action Icon ---
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorConst.bgGreyColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16,
                                  color: ColorConst.hintGreyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}