import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/doctor_controller/doctor_details_controller.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/review_card.dart';

class ReviewsWidget extends StatefulWidget {
  final DoctorDetailsController controller;

  const ReviewsWidget({
    super.key,
    required this.controller,
  });

  @override
  State<ReviewsWidget> createState() => _ReviewsWidgetState();
}

class _ReviewsWidgetState extends State<ReviewsWidget> {
  bool _showAll = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsController>(
      builder: (_) {
        final reviews = widget.controller.doctorProfile?.reviews ?? [];
        final displayReviews = _showAll ? reviews : reviews.take(5).toList();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Patient Reviews",
                style: GoogleFonts.nunitoSans(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              if (reviews.isEmpty)
                _emptyWidget()
              else ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: displayReviews.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 0),
                  itemBuilder: (_, index) {
                    return ReviewCard(
                      review: displayReviews[index],
                    );
                  },
                ),
                if (reviews.length > 5) ...[
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _showAll = !_showAll;
                        });
                      },
                      child: Text(
                        _showAll ? "View Less" : "View All",
                        style: GoogleFonts.nunitoSans(
                          color: const Color(0xff2962FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _emptyWidget() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.reviews_outlined,
            size: 70,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            "No Reviews Yet",
            style: GoogleFonts.nunitoSans(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Be the first patient to share your experience with this doctor.",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunitoSans(
              color: Colors.grey.shade600,
              fontSize: 15,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}