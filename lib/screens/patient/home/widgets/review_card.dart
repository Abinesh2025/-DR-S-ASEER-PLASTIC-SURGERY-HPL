import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_detail_model.dart';

class ReviewCard extends StatelessWidget {
  final DoctorReview review;

  const ReviewCard({
    super.key,
    required this.review,
  });

  @override
  Widget build(BuildContext context) {
    final rating =
        double.tryParse("${review.rating ?? 0}") ?? 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: review.patientImage != null &&
                    review.patientImage!.isNotEmpty
                    ? NetworkImage(review.patientImage!)
                    : null,
                child: review.patientImage == null ||
                    review.patientImage!.isEmpty
                    ? const Icon(
                  Icons.person,
                  size: 30,
                  color: Colors.grey,
                )
                    : null,
              ),

              const SizedBox(width: 15),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      review.patientName ?? "Anonymous",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      children: List.generate(
                        5,
                            (index) {
                          return Icon(
                            index < rating.round()
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 18,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                _formatDate(review.createdAt),
                style: GoogleFonts.nunitoSans(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(
            review.review ?? "",
            style: GoogleFonts.nunitoSans(
              height: 1.5,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return "";

    try {
      final date = DateTime.parse(value);

      return DateFormat("dd MMM yyyy").format(date);
    } catch (_) {
      return value;
    }
  }
}