import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/doctor_controller/doctor_details_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/write_review_widget.dart';

class RatingSummaryWidget extends StatelessWidget {
  final DoctorDetailsController controller;

  const RatingSummaryWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsController>(
      builder: (_) {
        final doctor = controller.doctorProfile;
        final double rating = double.tryParse("${doctor?.averageRating ?? 0}") ?? 0;
        final int totalReviews = doctor?.reviewsCount ?? 0;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.black.withOpacity(0.06), width: 1.5),
          ),
          child: Row(
            children: [
              // Left side: Rating & Reviews (Like image_9d2e47.png)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ratings & Reviews",
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    rating.toStringAsFixed(1),
                    style: GoogleFonts.nunitoSans(fontWeight: FontWeight.w900, fontSize: 32),
                  ),
                  Text(
                    "$totalReviews reviews",
                    style: GoogleFonts.nunitoSans(color: Colors.grey.shade600, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) => Icon(
                      index < rating.round() ? Icons.star_rounded : Icons.star_outline_rounded,
                      color: Colors.amber,
                      size: 20,
                    )),
                  ),
                ],
              ),

              const Spacer(),

              // Right side: Rate Button
              InkWell(
                onTap: () => _showReviewDialog(context, controller),
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.9),
                      width: 1.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Keeps the button as small as possible
                    children: [
                     const Icon(
  Icons.edit_outlined,
  size: 14,
  color: Colors.black87,
),
                      const SizedBox(width: 6),
                      Text(
                        "Rate",
                        style: GoogleFonts.nunitoSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReviewDialog(
    BuildContext context,
    DoctorDetailsController controller,
  ) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.white,
          clipBehavior: Clip.antiAlias,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.75,
              maxWidth: 400,
            ),
            child: WriteReviewWidget(
              controller: controller,
            ),
          ),
        );
      },
    );
  }
}