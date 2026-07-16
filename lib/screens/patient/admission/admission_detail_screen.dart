import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class AdmissionDetailScreen extends StatelessWidget {
  final String? admissionId;
  final String? doctor;
  final String? admissionDate;
  final String? admissionTime;
  final String? dischargeDate;
  final String? dischargeTime;
  final String? bed;
  final String? guardianName;
  final String? guardianRelation;
  final String? guardianContact;
  final String? guardianAddress;
  final String? createOn;
  final String? packageName;
  final String? insuranceName;
  final String? agentName;
  final String? policyNo;
  final String? doctorImage;
  const AdmissionDetailScreen({
    Key? key,
    required this.doctorImage,
    required this.admissionDate,
    required this.dischargeTime,
    required this.admissionTime,
    required this.doctor,
    required this.createOn,
    required this.insuranceName,
    required this.packageName,
    required this.admissionId,
    required this.guardianContact,
    required this.guardianRelation,
    required this.agentName,
    required this.bed,
    required this.dischargeDate,
    required this.guardianAddress,
    required this.guardianName,
    required this.policyNo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConst.whiteColor,
        appBar: CommonAppBar(
          title: StringUtils.admissionDetails,
          leadOnTap: () {
            Get.back();
          },
          leadIcon: const Icon(
            Icons.arrow_back_rounded,
            color: ColorConst.blackColor,
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero Profile Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                    top: 30, bottom: 24, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Column(
                  children: [
                    // Large Avatar
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: ColorConst.primaryColor.withOpacity(0.15),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConst.primaryColor.withOpacity(0.15),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: doctorImage == null || doctorImage!.isEmpty
                            ? Image.asset(
                                ImageUtils.doctorIcon,
                                fit: BoxFit.cover,
                              )
                            : FadeInImage(
                                placeholder:
                                    const AssetImage(ImageUtils.doctorIcon),
                                image: NetworkImage(doctorImage!),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(
                                    ImageUtils.doctorIcon,
                                    fit: BoxFit.cover,
                                  );
                                },
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      doctor ?? "Doctor Name",
                      style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor, width * 0.06),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Admission ID Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorConst.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: ColorConst.primaryColor.withOpacity(0.1)),
                      ),
                      child: Text(
                        "Admission ID: $admissionId",
                        style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor, width * 0.035),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Created On: ${createOn ?? ""}",
                      style: TextStyleConst.mediumTextStyle(
                          Colors.grey.shade500, width * 0.032),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Timeline Card
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _buildTimelineItem(
                                    icon: Icons.login_rounded,
                                    color: Colors.blue,
                                    label: "Admission",
                                    date: admissionDate ?? "",
                                    time: admissionTime ?? "",
                                    width: width,
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: 40,
                                  color: Colors.grey.shade200,
                                ),
                                Expanded(
                                  child: _buildTimelineItem(
                                    icon: Icons.logout_rounded,
                                    color: Colors.orange,
                                    label: "Discharge",
                                    date: dischargeDate ?? "",
                                    time: dischargeTime ?? "",
                                    width: width,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Colors.grey.shade100, height: 1),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.bed_rounded,
                                    color: Colors.grey.shade400, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  "Bed No: ",
                                  style: TextStyleConst.mediumTextStyle(
                                      Colors.grey.shade600, width * 0.038),
                                ),
                                Text(
                                  bed ?? "N/A",
                                  style: TextStyleConst.boldTextStyle(
                                      ColorConst.blackColor, width * 0.04),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Guardian Card
                    _buildInfoCard(
                      title: "Guardian Information",
                      icon: Icons.family_restroom_rounded,
                      width: width,
                      children: [
                        _buildDataRow("Name", guardianName ?? "N/A", width),
                        _buildDataRow(
                            "Relation", guardianRelation ?? "N/A", width),
                        _buildDataRow(
                            "Contact", guardianContact ?? "N/A", width,
                            isHighlight: true),
                        _buildDataRow(
                            "Address", guardianAddress ?? "N/A", width),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Insurance Card
                    _buildInfoCard(
                      title: "Insurance Details",
                      icon: Icons.shield_rounded,
                      width: width,
                      children: [
                        _buildDataRow(
                            "Insurance Name", insuranceName ?? "N/A", width),
                        _buildDataRow("Package", packageName ?? "N/A", width),
                        _buildDataRow("Agent", agentName ?? "N/A", width),
                        _buildDataRow("Policy No.", policyNo ?? "N/A", width,
                            isHighlight: true),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
      {required IconData icon,
      required Color color,
      required String label,
      required String date,
      required String time,
      required double width}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 6),
            Text(label,
                style: TextStyleConst.mediumTextStyle(
                    Colors.grey.shade500, width * 0.032)),
          ],
        ),
        const SizedBox(height: 8),
        Text(date,
            style: TextStyleConst.boldTextStyle(
                ColorConst.blackColor, width * 0.038)),
        const SizedBox(height: 2),
        Text(time,
            style: TextStyleConst.mediumTextStyle(
                Colors.grey.shade600, width * 0.032)),
      ],
    );
  }

  Widget _buildInfoCard(
      {required String title,
      required IconData icon,
      required double width,
      required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConst.primaryColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, size: 20, color: ColorConst.primaryColor),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyleConst.boldTextStyle(
                      ColorConst.blackColor, width * 0.045),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade100, height: 1),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value, double width,
      {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyleConst.mediumTextStyle(
                  Colors.grey.shade500, width * 0.035),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: isHighlight
                  ? TextStyleConst.boldTextStyle(
                      ColorConst.primaryColor, width * 0.038)
                  : TextStyleConst.mediumTextStyle(
                      ColorConst.blackColor, width * 0.038),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
