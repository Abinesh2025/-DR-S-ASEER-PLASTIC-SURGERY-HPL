import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/doctor_controller/doctor_details_controller.dart';

class WriteReviewWidget extends StatefulWidget {
  final DoctorDetailsController controller;

  const WriteReviewWidget({
    super.key,
    required this.controller,
  });

  @override
  State<WriteReviewWidget> createState() => _WriteReviewWidgetState();
}

class _WriteReviewWidgetState extends State<WriteReviewWidget> {
  late double rating;

  @override
  void initState() {
    super.initState();
    rating = widget.controller.selectedRating;
  }

  String _ratingText(double rating) {
    if (rating == 5) return "Excellent";
    if (rating == 4) return "Good";
    if (rating == 3) return "Average";
    if (rating == 2) return "Poor";
    return "Bad";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DoctorDetailsController>(
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Header / Title
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundImage: NetworkImage(
                      widget.controller.doctorProfile?.doctorImage ?? "",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.controller.doctorProfile?.doctorName ?? "",
                          style: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.controller.doctorProfile?.specialist ??
                              widget.controller.doctorProfile?.doctorDepartment ??
                              "",
                          style: GoogleFonts.nunitoSans(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            /// Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Doctor Info
                   


                    const SizedBox(height: 8),

                    Text(
                      "How was your experience?",
                      style: GoogleFonts.nunitoSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 15),

                    Center(
                      child: RatingBar.builder(
                        initialRating: rating,
                        itemCount: 5,
                        itemSize: 44,
                        minRating: 1,
                        allowHalfRating: false,
                        unratedColor: Colors.grey.shade300,
                        itemBuilder: (_, __) => const Icon(
                          Icons.star_rounded,
                          color: Colors.green,
                        ),
                        onRatingUpdate: (value) {
                          setState(() => rating = value);
                          widget.controller.selectedRating = value;
                        },
                      ),
                    ),

                    const SizedBox(height: 8),

                    Center(
                      child: Text(
                        _ratingText(rating),
                        style: GoogleFonts.nunitoSans(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Tell us more",
                      style: GoogleFonts.nunitoSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: widget.controller.reviewController,
                      maxLines: 4,
                      minLines: 3,
                      maxLength: 200,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      textCapitalization: TextCapitalization.sentences,
                      style: GoogleFonts.nunitoSans(fontSize: 15),
                      decoration: InputDecoration(
                        hintText: "Share details of your experience with this doctor...",
                        hintStyle: GoogleFonts.nunitoSans(color: Colors.grey.shade500, fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// SUBMIT BUTTON
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: widget.controller.isPostingReview
                      ? null
                      : () async {
                          await widget.controller.submitReview();

                          setState(() {
                            rating = 5;
                          });

                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff2962FF),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: widget.controller.isPostingReview
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Submit Review",
                          style: GoogleFonts.nunitoSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}