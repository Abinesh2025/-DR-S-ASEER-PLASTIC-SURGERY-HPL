import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/order_model/order_response_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderDataModel order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      appBar: CommonAppBar(
        title: "Order Details",
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status Card
            _buildStatusCard(),
            const SizedBox(height: 20),

            // Delivery Info Card
            _buildDeliveryCard(),
            const SizedBox(height: 20),

            // Itemized List Card
            _buildItemsCard(),
            const SizedBox(height: 20),

            // Payment Summary Card
            _buildPaymentSummaryCard(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return _buildCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order #${order.orderId}",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getStatusColor(order.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  (order.status ?? "Unknown").toUpperCase(),
                  style: TextStyleConst.boldTextStyle(
                      _getStatusColor(order.status), 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildInfoRow(
              Icons.calendar_today, "Order Date", _formatDate(order.createdAt)),
        ],
      ),
    );
  }

  Widget _buildDeliveryCard() {
    return _buildCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConst.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Icon(Icons.location_on_outlined,
                    color: ColorConst.primaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                "Delivery Address",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          ),
          Text(
            "${order.deliveryAddress ?? ''}\n${order.deliveryCity ?? ''} - ${order.deliveryPincode ?? ''}",
            style: TextStyleConst.mediumTextStyle(Colors.black87, 14)
                .copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsCard() {
    if (order.items == null || order.items!.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConst.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Icon(Icons.medication_liquid,
                    color: ColorConst.primaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                "Order Items",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
              ),
              const Spacer(),
              Text(
                "${order.items!.length} Items",
                style: TextStyleConst.mediumTextStyle(Colors.grey, 14),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          ),
          ...order.items!.map((item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: ColorConst.lightGreyColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.medical_services_outlined,
                          color: Colors.grey, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.medicineName ?? "Medicine",
                            style: TextStyleConst.boldTextStyle(
                                Colors.black87, 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Qty: ${item.quantity}",
                            style:
                                TextStyleConst.mediumTextStyle(Colors.grey, 13),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "₹${item.price}",
                      style: TextStyleConst.boldTextStyle(Colors.black87, 14),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPaymentSummaryCard() {
    return _buildCardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorConst.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:  Icon(Icons.receipt_long_outlined,
                    color: ColorConst.primaryColor, size: 20),
              ),
              const SizedBox(width: 10),
              Text(
                "Payment Summary",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Amount",
                style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
              ),
              Text(
                "₹${order.totalAmount ?? 0}",
                style:
                    TextStyleConst.boldTextStyle(ColorConst.primaryColor, 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: child,
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyleConst.mediumTextStyle(Colors.grey.shade700, 14),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    if (status == null) return Colors.grey;
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "N/A";
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
