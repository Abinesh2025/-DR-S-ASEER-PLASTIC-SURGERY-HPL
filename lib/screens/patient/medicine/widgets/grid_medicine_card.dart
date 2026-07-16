import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';

class GridMedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;

  const GridMedicineCard({
    super.key,
    required this.medicine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              flex: 5,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                      ),
                      child: medicine.imageUrl != null &&
                              medicine.imageUrl!.isNotEmpty
                          ? Image.network(
                              medicine.imageUrl!,
                              fit: BoxFit.cover,
                              errorBuilder: (c, o, s) => const Icon(
                                Icons.medication,
                                size: 50,
                                color: Colors.grey,
                              ),
                            )
                          : const Icon(
                              Icons.medication,
                              size: 50,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  // Floating Category Tag
                  if (medicine.categoryName?.isNotEmpty ?? false)
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                            )
                          ],
                        ),
                        child: Text(
                          medicine.categoryName!.toUpperCase(),
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor,
                            9,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Info Section
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          medicine.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.blackColor,
                            14,
                          ),
                        ),
                        if (medicine.brandName?.isNotEmpty ?? false) ...[
                          const SizedBox(height: 2),
                          Text(
                            medicine.brandName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleConst.mediumTextStyle(
                              Colors.grey.shade600,
                              11,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      "₹${(medicine.sellingPrice ?? 0.0).toStringAsFixed(0)}",
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.primaryColor,
                        16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
