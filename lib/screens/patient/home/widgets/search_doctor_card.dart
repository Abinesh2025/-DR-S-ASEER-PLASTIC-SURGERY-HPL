import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/get_doctor_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class SearchDoctorCard extends StatelessWidget {
  final dynamic doctor;
  final VoidCallback onTap;

  const SearchDoctorCard(
      {super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Helper to extract data safely
    String? getName() {
      if (doctor is GetDoctorData) return (doctor as GetDoctorData).title;
      if (doctor.runtimeType.toString() == 'DoctorListData') return doctor.name;
      // Fallback/Dynamic
      try {
        return doctor.title;
      } catch (e) {
        try {
          return doctor.name;
        } catch (e) {
          return null;
        }
      }
    }

    String? getDepartment() {
      if (doctor is GetDoctorData)
        return (doctor as GetDoctorData).doctor_department;
      if (doctor.runtimeType.toString() == 'DoctorListData')
        return doctor.department;
      try {
        return doctor.doctor_department;
      } catch (e) {
        try {
          return doctor.department;
        } catch (e) {
          return null;
        }
      }
    }

    String? getImageUrl() {
      if (doctor is GetDoctorData) {
        final d = doctor as GetDoctorData;
        // Prioritize full URLs from user or doctor_image_url
        if (d.user?.image_url != null && d.user!.image_url!.trim().isNotEmpty)
          return d.user!.image_url;
        if (d.doctor_image_url != null && d.doctor_image_url!.trim().isNotEmpty)
          return d.doctor_image_url;
        // Fallback to doctor_image, might be relative or filename
        if (d.doctor_image != null && d.doctor_image!.trim().isNotEmpty)
          return d.doctor_image;
      }
      if (doctor.runtimeType.toString() == 'DoctorListData') {
        return doctor.imageUrl;
      }
      // Reflection/Dynamic fallback
      try {
        return doctor.imageUrl;
      } catch (e) {
        try {
          return doctor.doctor_image_url;
        } catch (e) {
          return null;
        }
      }
    }

    String? getSpecialist() {
      if (doctor is GetDoctorData)
        return null; // Lite model doesn't have specialist
      if (doctor.runtimeType.toString() == 'DoctorListData')
        return doctor.specialist;
      try {
        return doctor.specialist;
      } catch (e) {
        return null;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  height: width * 0.16,
                  width: width * 0.16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: ClipOval(
                    child: () {
                      String? imageUrl = getImageUrl();
                      if (imageUrl != null) {
                        // Handle relative URLs
                        if (!imageUrl.startsWith('http')) {
                          // Standardize path
                          if (imageUrl.startsWith('/')) {
                            imageUrl = imageUrl.substring(1);
                          }

                          // Check if it already has storage/ or public/
                          if (!imageUrl.startsWith('storage/') &&
                              !imageUrl.startsWith('public/')) {
                            imageUrl = "storage/$imageUrl";
                          }

                          imageUrl = "${StringUtils.domainUrl}/$imageUrl";
                        }

                        return FadeInImage(
                          placeholder: const AssetImage(ImageUtils.doctorIcon),
                          image: NetworkImage(imageUrl),
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              ImageUtils.doctorIcon,
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Icon(
                          Icons.person,
                          size: width * 0.1,
                          color: ColorConst.primaryColor.withOpacity(0.5),
                        );
                      }
                    }(),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 15),

            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          getName() ?? "Unknown Doctor",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConst.boldTextStyle(
                            Colors.black87,
                            width * 0.042,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          getSpecialist() != null
                              ? "${getSpecialist()} • ${getDepartment() ?? "General"}"
                              : getDepartment() ?? "General",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConst.mediumTextStyle(
                            Colors.grey,
                            width * 0.032,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Arrow
            Icon(Icons.arrow_forward_ios,
                color: Colors.grey.shade400, size: 16),
          ],
        ),
      ),
    );
  }
}
