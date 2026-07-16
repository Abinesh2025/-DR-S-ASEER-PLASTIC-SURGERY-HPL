import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_list_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class HorizontalDoctorCard extends StatelessWidget {
  final DoctorListData doctor;
  final VoidCallback onTap;

  const HorizontalDoctorCard(
      {super.key, required this.doctor, required this.onTap});

  @override
  Widget build(BuildContext context) {
    String? imageUrl = doctor.imageUrl;
    if (imageUrl != null &&
        imageUrl.trim().isNotEmpty &&
        !imageUrl.startsWith('http')) {
      imageUrl = '${StringUtils.imagePath}$imageUrl';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Image (Circle)
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                color: ColorConst.lightGreyColor,
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: (imageUrl != null && imageUrl.trim().isNotEmpty)
                    ? FadeInImage(
                        placeholder: const AssetImage(ImageUtils.doctorIcon),
                        image: NetworkImage(imageUrl),
                        imageErrorBuilder: (context, error, stackTrace) =>
                            Image.asset(ImageUtils.doctorIcon,
                                fit: BoxFit.cover),
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        CupertinoIcons.person_fill,
                        size: 36,
                        color: ColorConst.primaryColor.withOpacity(0.5),
                      ),
              ),
            ),
            const SizedBox(width: 15),

            // Middle Column (Name, Speciality, Rating)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor.name ?? "Unknown Doctor",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConst.boldTextStyle(Colors.black87, 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor.specialist ?? doctor.department ?? 'Specialist',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.blackColor.withOpacity(0.5),
                      13,
                    ),
                  ),
                ],
              ),
            ),

            // Right Column (Fees, Book Now btn)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Fees  ',
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.blackColor.withOpacity(0.5),
                      12,
                    ),
                    children: [
                      TextSpan(
                        text: '₹${doctor.appointmentCharge ?? '50.99'}',
                        style: TextStyleConst.boldTextStyle(
                          ColorConst.primaryColor,
                          14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: onTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConst.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: const Size(0, 32), // Compact height
                  ),
                  child: Text(
                    "Book Now",
                    style: TextStyleConst.mediumTextStyle(
                      ColorConst.whiteColor,
                      13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
