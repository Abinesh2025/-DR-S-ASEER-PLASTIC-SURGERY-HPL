import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class CaseDetailScreen extends StatelessWidget {
  const CaseDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    // Status color logic (can be adjusted based on enum if available)
    final String status = argument["status"] ?? "";
    final Color statusColor =
        status.toLowerCase() == "active" || status.toLowerCase() == "completed"
            ? ColorConst.greenColor
            : Colors.orange;

    return SafeArea(
      child: Scaffold(
        backgroundColor:
            Colors.grey.shade50, // very light background for cards to pop
        appBar: CommonAppBar(
          title: StringUtils.casesDetails,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 1. Hero Profile Section
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade100)),
                ),
                child: Column(
                  children: [
                    // Avatar Ring
                    Container(
                      height: 100,
                      width: 100,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                            color: ColorConst.primaryColor.withOpacity(0.2),
                            width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: ColorConst.primaryColor.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: argument["doctor_image"] == null ||
                                argument["doctor_image"].toString().isEmpty
                            ? Image.asset(ImageUtils.doctorIcon,
                                fit: BoxFit.cover)
                            : FadeInImage(
                                placeholder:
                                    const AssetImage(ImageUtils.doctorIcon),
                                image:
                                    NetworkImage("${argument["doctor_image"]}"),
                                imageErrorBuilder:
                                    (context, error, stackTrace) {
                                  return Image.asset(ImageUtils.doctorIcon,
                                      fit: BoxFit.cover);
                                },
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    // Doctor Name
                    Text(
                      argument["doctor_name"] ?? "Doctor",
                      style: TextStyleConst.boldTextStyle(
                          ColorConst.blackColor, width * 0.055),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: height * 0.005),
                    // Case ID Tag
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: ColorConst.primaryColor.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Case ID: ${argument["case_id"]}",
                        style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor, width * 0.035),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    // Status Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: statusColor.withOpacity(0.15),
                        border: Border.all(color: statusColor.withOpacity(0.5)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 8,
                            width: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: statusColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            status.toUpperCase(),
                            style: TextStyleConst.boldTextStyle(
                                statusColor, width * 0.035),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // 2. Quick Stats Grid
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: _buildStatItem(
                                  Icons.payments_outlined,
                                  StringUtils.fee,
                                  "${argument["currency"]} ${argument["fee"]}",
                                  width)),
                          Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey.shade200),
                          Expanded(
                              child: _buildStatItem(
                                  Icons.calendar_today_outlined,
                                  "Date",
                                  argument["case_date"] ?? "-",
                                  width)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colors.grey.shade200, height: 1),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                              child: _buildStatItem(Icons.access_time_rounded,
                                  "Time", argument["case_time"] ?? "-", width)),
                          Container(
                              height: 40,
                              width: 1,
                              color: Colors.grey.shade200),
                          Expanded(
                              child: _buildStatItem(
                                  Icons.history_rounded,
                                  StringUtils.createOn,
                                  argument["created_on"] ?? "-",
                                  width)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.02),

              // 3. Information Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.notes_rounded,
                              color: ColorConst.primaryColor, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            StringUtils.description,
                            style: TextStyleConst.boldTextStyle(
                                ColorConst.blackColor, width * 0.045),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        argument["description"]?.toString().isNotEmpty == true
                            ? argument["description"].toString()
                            : "No description provided for this case.",
                        style: TextStyleConst.mediumTextStyle(
                            Colors.grey.shade600, width * 0.04),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(
      IconData icon, String label, String value, double width) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey.shade400, size: 22),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyleConst.mediumTextStyle(
              Colors.grey.shade500, width * 0.035),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyleConst.boldTextStyle(
              ColorConst.blackColor, width * 0.042),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
