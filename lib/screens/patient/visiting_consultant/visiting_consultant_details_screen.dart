import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/visiting_consultant/visiting_consultant_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/visiting_consultant/create_visiting_request_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class VisitingConsultantDetailsScreen extends StatelessWidget {
  final VisitingConsultantData consultant;

  const VisitingConsultantDetailsScreen({
    super.key,
    required this.consultant,
  });

  Widget _buildPlaceholder() {
    return Container(
      width: 100,
      height: 100,
      color: ColorConst.primaryColor.withOpacity(0.08),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Image.asset(
          ImageUtils.doctorIcon,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = StringUtils.fixImageUrl(consultant.avatar);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: "Specialist Profile",
        leadIcon: const Icon(Icons.arrow_back_rounded, color: ColorConst.blackColor),
        leadOnTap: () => Navigator.of(context).maybePop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Profile Card
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: ColorConst.primaryColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: avatarUrl.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: avatarUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => _buildPlaceholder(),
                              errorWidget: (context, url, error) => _buildPlaceholder(),
                            )
                          : _buildPlaceholder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    consultant.name ?? "Specialist Consultant",
                    style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    consultant.specialty ?? consultant.designation ?? "Visiting Consultant",
                    style: TextStyleConst.mediumTextStyle(ColorConst.primaryColor, 15),
                    textAlign: TextAlign.center,
                  ),
                  if (consultant.qualification != null && consultant.qualification!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      consultant.qualification!,
                      style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 13),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Statistics Row (Experience, Days, Fee)
            Row(
              children: [
                _buildInfoTile(
                  icon: Icons.work_history_outlined,
                  title: "Experience",
                  value: consultant.experience ?? "10+ Yrs",
                ),
                const SizedBox(width: 12),
                _buildInfoTile(
                  icon: Icons.calendar_month_outlined,
                  title: "Schedule",
                  value: consultant.visitingDays ?? "On Demand",
                ),
                const SizedBox(width: 12),
                _buildInfoTile(
                  icon: Icons.payments_outlined,
                  title: "Consultation",
                  value: consultant.consultationFee != null && consultant.consultationFee!.isNotEmpty
                      ? (consultant.consultationFee!.startsWith('₹') ? consultant.consultationFee! : "₹${consultant.consultationFee}")
                      : "Hospital Rates",
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Visit Availability Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: ColorConst.bgGreyColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorConst.borderGreyColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Service Availability",
                    style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildAvailabilityBadge(
                        label: "Outpatient (OPD)",
                        isAvailable: consultant.opdAvailable != false,
                        icon: Icons.local_hospital_outlined,
                      ),
                      const SizedBox(width: 12),
                      _buildAvailabilityBadge(
                        label: "Inpatient (IPD)",
                        isAvailable: consultant.ipdAvailable != false,
                        icon: Icons.hotel_outlined,
                      ),
                    ],
                  ),
                  if (consultant.visitingHours != null && consultant.visitingHours!.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 16, color: ColorConst.hintGreyColor),
                        const SizedBox(width: 6),
                        Text(
                          "Visiting Hours: ${consultant.visitingHours}",
                          style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 13),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Department & Department description
            Text(
              "Department",
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.business_outlined, color: ColorConst.primaryColor, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    consultant.department ?? "Specialized Surgery & Medical Care",
                    style: TextStyleConst.boldTextStyle(ColorConst.primaryColor, 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Bio / Description
            Text(
              "About Specialist",
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
            ),
            const SizedBox(height: 8),
            Text(
              (consultant.bio != null && consultant.bio!.isNotEmpty)
                  ? consultant.bio!
                  : "${consultant.name ?? 'This consultant'} is a senior visiting specialist affiliated with Dr. S. Aseer Plastic Surgery and Accident Care Hospital, available for expert clinical assessments, second opinions, OPD evaluations, and bedside inpatient rounds.",
              style: TextStyleConst.regularTextStyle(
                ColorConst.blackColor.withOpacity(0.75),
                14,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SizedBox(
            height: 52,
            child: ElevatedButton.icon(
              onPressed: () {
                Get.to(() => CreateVisitingRequestScreen(initialConsultant: consultant));
              },
              icon: const Icon(Icons.calendar_month, color: Colors.white),
              label: Text(
                "Request Consultation",
                style: TextStyleConst.boldTextStyle(Colors.white, 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: ColorConst.bgGreyColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorConst.borderGreyColor),
        ),
        child: Column(
          children: [
            Icon(icon, color: ColorConst.primaryColor, size: 22),
            const SizedBox(height: 6),
            Text(
              title,
              style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 11),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 12),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvailabilityBadge({
    required String label,
    required bool isAvailable,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isAvailable ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isAvailable ? Colors.green.shade300 : Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isAvailable ? Colors.green.shade700 : Colors.grey.shade500,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyleConst.boldTextStyle(
                  isAvailable ? Colors.green.shade800 : Colors.grey.shade600,
                  11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
