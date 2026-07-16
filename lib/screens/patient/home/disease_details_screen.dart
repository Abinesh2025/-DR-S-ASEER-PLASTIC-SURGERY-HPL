import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/disease_details_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:flutter/services.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/doctor_details_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/image_utils.dart';

class DiseaseDetailsScreen extends StatefulWidget {
  final int diseaseId;
  final String diseaseName;

  const DiseaseDetailsScreen({
    Key? key,
    required this.diseaseId,
    required this.diseaseName,
  }) : super(key: key);

  @override
  State<DiseaseDetailsScreen> createState() => _DiseaseDetailsScreenState();
}

class _DiseaseDetailsScreenState extends State<DiseaseDetailsScreen> {
  bool isLoading = true;
  DiseaseDetailsModel? diseaseDetails;

  @override
  void initState() {
    super.initState();
    _fetchDiseaseDetails();
  }

  void _fetchDiseaseDetails() {
    StringUtils.client
        .getDiseaseDetails(
            PreferenceUtils.getStringValue("token"), widget.diseaseId)
        .then((value) {

      if (mounted) {
        setState(() {
          diseaseDetails = value;
          isLoading = false;
        });
      }
    }).catchError((error) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      debugPrint("Error fetching disease details: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC), // Very soft neat background
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Fixes white status bar
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => Get.back(),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(Icons.arrow_back_ios_new,
                    size: 16, color: Colors.black87),
              ),
            ),
          ),
        ),
      ),
      body: isLoading
          ? _buildShimmer()
          : diseaseDetails?.data == null
              ? const Center(child: Text("Details not found"))
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 60,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: ColorConst.primaryColor.withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.medical_information_outlined,
                                size: 36,
                                color: ColorConst.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              widget.diseaseName,
                              style: TextStyleConst.boldTextStyle(
                                Colors.black87,
                                26,
                              ).copyWith(height: 1.2),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                "Health Information",
                                style: TextStyleConst.mediumTextStyle(
                                    Colors.blue.shade700, 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Overview Section
                      if (diseaseDetails!.data!.description != null) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: _buildSectionLabel("Overview"),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade100),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.02),
                                blurRadius: 15,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            diseaseDetails!.data!.description!,
                            style: TextStyleConst.mediumTextStyle(
                              Colors.blueGrey.shade700,
                              15,
                            ).copyWith(height: 1.6),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],

                      // Symptoms Section
                      if (diseaseDetails!.data!.symptoms != null &&
                          diseaseDetails!.data!.symptoms!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: _buildSectionLabel("Symptoms & Treatments"),
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: diseaseDetails!.data!.symptoms!
                                .map(
                                    (symptom) => _buildNeatSymptomCard(symptom))
                                .toList(),
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],

                      // Doctors Section
                      if (diseaseDetails!.data!.doctors != null &&
                          diseaseDetails!.data!.doctors!.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: _buildSectionLabel("Suggested Specialists"),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 100,
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: diseaseDetails!.data!.doctors!.length,
                            itemBuilder: (context, index) {
                              final doctor =
                                  diseaseDetails!.data!.doctors![index];
                              return _buildMiniDoctorCard(doctor);
                            },
                          ),
                        ),
                        const SizedBox(height: 32),
                      ],
                    ],
                  ),
                ),
    );
  }

  Widget _buildMiniDoctorCard(DiseaseDoctorData doctor) {
    // Extract properly mapped image url
    String? imageUrl = doctor.imageUrl;
    if (imageUrl != null &&
        imageUrl.trim().isNotEmpty &&
        !imageUrl.startsWith('http')) {
      imageUrl = '${StringUtils.imagePath}$imageUrl';
    }

    return GestureDetector(
      onTap: () {
        if (doctor.id != null) {
          Get.to(
            () => DoctorDetailsScreen(
              doctorId: doctor.id!,
              doctor: doctor.toDoctorListData(),
            ),
            transition: Transition.rightToLeft,
          );
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65, // Comfortable width
        margin: const EdgeInsets.only(right: 12, bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Mini profile image
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: ClipOval(
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
                        Icons.person,
                        color: ColorConst.primaryColor.withOpacity(0.5),
                        size: 30,
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor.name ?? "Unknown Doctor",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConst.boldTextStyle(Colors.black87, 14),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    doctor.specialist ?? "Specialist",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyleConst.mediumTextStyle(
                        Colors.blueGrey.shade400, 12),
                  ),
                ],
              ),
            ),
            // Tiny arrow
            Icon(Icons.chevron_right, color: Colors.grey.shade300, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: TextStyleConst.boldTextStyle(
        Colors.black87,
        18,
      ),
    );
  }

  Widget _buildNeatSymptomCard(SymptomData symptom) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          iconColor: ColorConst.primaryColor,
          collapsedIconColor: Colors.grey.shade400,
          title: Text(
            symptom.name ?? "Symptom",
            style: TextStyleConst.boldTextStyle(
              Colors.black87,
              16,
            ),
          ),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.red.shade50.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.healing_outlined,
              color: Colors.red.shade300,
              size: 20,
            ),
          ),
          children: [
            if (symptom.treatments != null &&
                symptom.treatments!.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Treatments",
                      style: TextStyleConst.boldTextStyle(
                        Colors.blueGrey.shade800,
                        14,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...symptom.treatments!.map((treatment) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.check,
                                size: 12,
                                color: Colors.green.shade600,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                treatment.name ?? "",
                                style: TextStyleConst.mediumTextStyle(
                                  Colors.blueGrey.shade600,
                                  14,
                                ).copyWith(height: 1.4),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ] else
              Text(
                "No specific treatments listed.",
                style: TextStyleConst.mediumTextStyle(Colors.grey.shade500, 14),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Container(
      color: const Color(0xFFF7F9FC),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 60,
            left: 24,
            right: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 68,
                  width: 68,
                  decoration: const BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle)),
              const SizedBox(height: 20),
              Container(height: 30, width: 250, color: Colors.white),
              const SizedBox(height: 40),
              Container(height: 20, width: 100, color: Colors.white),
              const SizedBox(height: 15),
              Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 30),
              Container(height: 20, width: 150, color: Colors.white),
              const SizedBox(height: 15),
              Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20))),
              const SizedBox(height: 15),
              Container(
                  height: 70,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20))),
            ],
          ),
        ),
      ),
    );
  }
}
