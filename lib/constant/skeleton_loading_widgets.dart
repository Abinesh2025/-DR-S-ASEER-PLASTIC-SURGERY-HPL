import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_shimmer.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/common/skeleton_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? height, width;
  final double borderRadius;

  const Skeleton({super.key, this.height, this.width, this.borderRadius = 12});

  @override
  Widget build(BuildContext context) {
    final config = SkeletonLoadingConfig.hospitalTheme();
    return CommonShimmer(
      height: height,
      width: width,
      borderRadius: borderRadius,
      baseColor: config.baseColor,
      highlightColor: config.highlightColor,
    );
  }
}

class BannerSkeleton extends StatelessWidget {
  const BannerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Skeleton(
        height: 180,
        width: MediaQuery.of(context).size.width,
        borderRadius: 20,
      ),
    );
  }
}

class CategorySkeleton extends StatelessWidget {
  const CategorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Skeleton(
          height: width * 0.15,
          width: width * 0.15,
          borderRadius: 15,
        ),
        const SizedBox(height: 8),
        const Skeleton(height: 10, width: 50, borderRadius: 4),
      ],
    );
  }
}

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorConst.greyShadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: Skeleton(borderRadius: 15),
          ),
          Container(
            height: 95,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Skeleton(height: 15, width: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Skeleton(height: 20, width: 40),
                    Skeleton(height: 25, width: 25, borderRadius: 25),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorSkeleton extends StatelessWidget {
  const DoctorSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.7,
      margin: const EdgeInsets.only(right: 15),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: ColorConst.greyShadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Skeleton(
            height: width * 0.14,
            width: width * 0.14,
            borderRadius: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Skeleton(height: 14, width: 120),
                const SizedBox(height: 6),
                const Skeleton(height: 12, width: 80),
                const SizedBox(height: 6),
                Row(
                  children: const [
                    Skeleton(height: 10, width: 30),
                    SizedBox(width: 8),
                    Skeleton(height: 10, width: 50),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AppointmentSkeleton extends StatelessWidget {
  const AppointmentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Match card radius
        boxShadow: [
          BoxShadow(
            color: ColorConst.greyShadowColor,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Skeleton(height: 60, width: 60, borderRadius: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Skeleton(height: 16, width: 150),
                    SizedBox(height: 8),
                    Skeleton(height: 14, width: 100),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Skeleton(
                  height: 32, width: 32, borderRadius: 10), // Arrow placeholder
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: ColorConst.lightGreyColor),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Skeleton(height: 14, width: 100),
              Skeleton(height: 14, width: 80),
            ],
          ),
        ],
      ),
    );
  }
}

class NewAppointmentSkeleton extends StatelessWidget {
  const NewAppointmentSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          // Specialist Card Skeleton
          _buildDetailedSkeletonCard(
            context,
            children: [
              _buildCardHeader(
                  "Specialist Details", Icons.medical_services_outlined),
              const SizedBox(height: 16),
              const Skeleton(height: 14, width: 150),
              const SizedBox(height: 8),
              const Skeleton(
                  height: 55, width: double.infinity, borderRadius: 12),
              const SizedBox(height: 20),
              const Skeleton(height: 14, width: 100),
              const SizedBox(height: 8),
              const Skeleton(
                  height: 55, width: double.infinity, borderRadius: 12),
            ],
          ),
          const SizedBox(height: 20),

          // Date & Time Card Skeleton
          _buildDetailedSkeletonCard(
            context,
            children: [
              _buildCardHeader("Date & Time", Icons.calendar_month_outlined),
              const SizedBox(height: 16),
              const Skeleton(height: 14, width: 60),
              const SizedBox(height: 10),
              // Month Switcher Sim
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Skeleton(height: 35, width: 35, borderRadius: 30),
                  Skeleton(height: 18, width: 120),
                  Skeleton(height: 35, width: 35, borderRadius: 30),
                ],
              ),
              const SizedBox(height: 15),
              // Days Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  5,
                  (index) =>
                      const Skeleton(height: 70, width: 55, borderRadius: 15),
                ),
              ),
              const SizedBox(height: 25),
              const Skeleton(height: 14, width: 120),
              const SizedBox(height: 15),
              // Slots Grid
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  6,
                  (index) => Skeleton(
                    height: 40,
                    width: (MediaQuery.of(context).size.width - 90) / 3,
                    borderRadius: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Description Card Skeleton
          _buildDetailedSkeletonCard(
            context,
            children: [
              _buildCardHeader("Additional Details", Icons.notes_outlined),
              const SizedBox(height: 16),
              const Skeleton(height: 14, width: 100),
              const SizedBox(height: 10),
              const Skeleton(
                  height: 100, width: double.infinity, borderRadius: 12),
            ],
          ),
          const SizedBox(height: 30),

          // Total & Button Skeleton
          Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Skeleton(height: 16, width: 180),
                Skeleton(height: 18, width: 80),
              ],
            ),
          ),
          const Skeleton(
            height: 55,
            width: double.infinity,
            borderRadius: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildCardHeader(String title, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConst.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: ColorConst.primaryColor, size: 20),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
        ),
      ],
    );
  }

  Widget _buildDetailedSkeletonCard(BuildContext context,
      {required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }
}

class NewsletterSkeleton extends StatelessWidget {
  const NewsletterSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author
          Row(
            children: const [
              Skeleton(height: 24, width: 24, borderRadius: 12),
              SizedBox(width: 8),
              Skeleton(height: 14, width: 100),
            ],
          ),
          const SizedBox(height: 12),
          
          // Title & Image
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Skeleton(height: 16, width: double.infinity),
                    const SizedBox(height: 4),
                    const Skeleton(height: 16, width: 150),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Skeleton(height: 20, width: 60, borderRadius: 20),
                        SizedBox(width: 12),
                        Skeleton(height: 12, width: 80),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Skeleton(height: 14, width: 30),
                        SizedBox(width: 12),
                        Skeleton(height: 14, width: 30),
                        SizedBox(width: 12),
                        Skeleton(height: 14, width: 30),
                        SizedBox(width: 12),
                        Skeleton(height: 14, width: 30),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 15),
              const Expanded(
                flex: 3,
                child: Skeleton(height: 75, borderRadius: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
