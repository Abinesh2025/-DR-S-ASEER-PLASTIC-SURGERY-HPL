// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_detail_text.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
// import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/bed_details_controller.dart';
//
// class BedDetails extends StatelessWidget {
//   BedDetails({
//     Key? key,
//   }) : super(key: key);
//
//   final  BedDetailsController bedDetailsController = Get.put(BedDetailsController());
//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     var id = ModalRoute.of(context)!.settings.arguments as int;
//     bedDetailsController.getBedDetails(id.toString());
//     return SafeArea(
//       child: Scaffold(
//         appBar: CommonAppBar(
//           title: "Bed Details",
//           leadOnTap: () {
//             Get.back();
//           },
//           leadIcon: const Icon(
//             Icons.arrow_back_rounded,
//             color: ColorConst.blackColor,
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(20),
//           child: Obx(() {
//             return bedDetailsController.isBedDetailsApiCalled.value == false
//                 ? const Center(child: CircularProgressIndicator())
//                 : bedDetailsController.bedDetailsModel?.data == null
//                     ? const Center(child: Text("No Data Found!"))
//                     : Column(
//                         children: [
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Bed :",
//                             descriptionText: bedDetailsController.bedDetailsModel?.data?.bed ?? "",
//                           ),
//                           SizedBox(height: height * 0.015),
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Bed Type :",
//                             descriptionText: bedDetailsController.bedDetailsModel?.data?.bed_type ?? "",
//                           ),
//                           SizedBox(height: height * 0.015),
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Bed ID :",
//                             descriptionText: bedDetailsController.bedDetailsModel?.data?.bed_id ?? "",
//                           ),
//                           SizedBox(height: height * 0.015),
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Charge :",
//                             descriptionText: "\$ ${bedDetailsController.bedDetailsModel?.data?.charge ?? ""}",
//                           ),
//                           SizedBox(height: height * 0.015),
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Available :",
//                             descriptionText: bedDetailsController.bedDetailsModel?.data?.is_available == 0 ? "No" : "Yes",
//                           ),
//                           SizedBox(height: height * 0.015),
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Created on :",
//                             descriptionText: bedDetailsController.bedDetailsModel?.data?.created_on ?? "",
//                           ),
//                           SizedBox(height: height * 0.015),
//                           CommonDetailText(
//                             width: width,
//                             titleText: "Description :",
//                             descriptionText: bedDetailsController.bedDetailsModel?.data?.description ?? "N/A",
//                           ),
//                           SizedBox(height: height * 0.015),
//                         ],
//                       );
//           }),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/doctor/bed_assign_controller/bed_details_controller.dart';

class BedDetails extends StatefulWidget {
  const BedDetails({Key? key}) : super(key: key);

  @override
  State<BedDetails> createState() => _BedDetailsState();
}

class _BedDetailsState extends State<BedDetails> {
  final BedDetailsController bedDetailsController = Get.put(BedDetailsController());

  @override
  void initState() {
    super.initState();
    // It's safer to call the API in initState rather than the build method
    // to prevent it from recalling the API every time the UI rebuilds.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var id = ModalRoute.of(context)!.settings.arguments as int;
      bedDetailsController.getBedDetails(id.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA), // Soft background for contrast
      appBar: CommonAppBar(
        title: "Bed Details",
        leadOnTap: () => Get.back(),
        leadIcon: const Icon(
          Icons.arrow_back_rounded,
          color: ColorConst.blackColor,
        ),
      ),
      body: Obx(() {
        if (!bedDetailsController.isBedDetailsApiCalled.value) {
          return  Center(
            child: CircularProgressIndicator(color: ColorConst.primaryColor),
          );
        }

        final data = bedDetailsController.bedDetailsModel?.data;

        if (data == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.hotel_outlined, size: 80, color: ColorConst.hintGreyColor.withOpacity(0.3)),
                const SizedBox(height: 16),
                Text(
                  "No Data Found!",
                  style: TextStyleConst.boldTextStyle(ColorConst.hintGreyColor, 18),
                ),
              ],
            ),
          );
        }

        bool isAvailable = data.is_available == 1; // Assuming 1 is true/available

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TOP HEADER CARD ---
              Container(
                padding: const EdgeInsets.all(20),
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
                  children: [
                    // Bed Icon Container
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: ColorConst.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child:  Icon(
                        Icons.bed,
                        color: ColorConst.primaryColor,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.bed ?? "Unknown Bed",
                            style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 22),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            data.bed_type ?? "N/A",
                            style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- QUICK STATS ROW (Available & Charge) ---
              Row(
                children: [
                  Expanded(
                    child: _buildQuickStatCard(
                      title: "Status",
                      value: isAvailable ? "Available" : "Occupied",
                      icon: isAvailable ? Icons.check_circle_outline : Icons.cancel_outlined,
                      color: isAvailable ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildQuickStatCard(
                      title: "Charge",
                      value: "\$${data.charge ?? "0.00"}",
                      icon: Icons.payments_outlined,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // --- DETAILS SECTION ---
              Text(
                "Additional Information",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildListTile(
                      icon: Icons.tag,
                      title: "Bed ID",
                      value: data.bed_id ?? "N/A",
                    ),
                    const Divider(height: 1, color: ColorConst.borderGreyColor, indent: 50),
                    _buildListTile(
                      icon: Icons.calendar_month_outlined,
                      title: "Created On",
                      value: data.created_on ?? "N/A",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // --- DESCRIPTION SECTION ---
              Text(
                "Description",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  (data.description == null || data.description!.isEmpty)
                      ? "No description provided for this bed."
                      : data.description!,
                  style: TextStyleConst.regularTextStyle(ColorConst.hintGreyColor, 15)
                      .copyWith(height: 1.5), // Added line height for readability
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  // --- Helper Widget: Quick Stat Card ---
  Widget _buildQuickStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 13),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyleConst.boldTextStyle(color, 16),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  // --- Helper Widget: Detail List Tile ---
  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorConst.bgGreyColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: ColorConst.hintGreyColor, size: 18),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 13),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}