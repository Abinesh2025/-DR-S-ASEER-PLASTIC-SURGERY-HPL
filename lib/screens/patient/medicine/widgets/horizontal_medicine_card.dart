import 'package:flutter/material.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/medicine/medicine_model.dart';

class HorizontalMedicineCard extends StatelessWidget {
  final MedicineModel medicine;
  final VoidCallback onTap;

  const HorizontalMedicineCard({
    super.key,
    required this.medicine,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image Section
            Container(
              height: 110,
              width: 110,
              decoration: const BoxDecoration(
                color: Color(0xFFF5F7FA),
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(16)),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: medicine.imageUrl != null &&
                              medicine.imageUrl!.isNotEmpty
                          ? Image.network(
                              medicine.imageUrl!,
                              fit: BoxFit.contain,
                              errorBuilder: (c, o, s) => const Icon(
                                Icons.medication_liquid_rounded,
                                size: 40,
                                color: Colors.grey,
                              ),
                            )
                          : const Icon(
                              Icons.medication_liquid_rounded,
                              size: 40,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                  if (medicine.categoryName?.isNotEmpty ?? false)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: ColorConst.primaryColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
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

            // Details Section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (medicine.brandName?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          medicine.brandName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyleConst.mediumTextStyle(
                            Colors.grey.shade600,
                            11,
                          ),
                        ),
                      ),
                    Text(
                      medicine.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyleConst.boldTextStyle(
                        ColorConst.blackColor,
                        15,
                      ).copyWith(height: 1.2),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "₹${(medicine.sellingPrice ?? 0.0).toStringAsFixed(0)}",
                          style: TextStyleConst.boldTextStyle(
                            ColorConst.primaryColor,
                            16,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: ColorConst.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ],
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
