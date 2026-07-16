import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/order_controller/order_list_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/order_model/order_response_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/order/order_details_screen.dart';

class MyOrdersScreen extends StatelessWidget {
  MyOrdersScreen({super.key});

  final OrderListController controller = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.bgGreyColor,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.orders.isEmpty) {
          return Center(
            child: Text("No orders found",
                style:
                    TextStyleConst.mediumTextStyle(ColorConst.blackColor, 16)),
          );
        }
        return RefreshIndicator(
          onRefresh: controller.getOrdersData,
          color: ColorConst.primaryColor,
          backgroundColor: Colors.white,
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 20, top: 10),
            itemCount: controller.orders.length,
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            itemBuilder: (context, index) {
              final order = controller.orders[index];
              return _buildOrderCard(context, order);
            },
          ),
        );
      }),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderDataModel order) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderDetailsScreen(order: order));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Order #${order.orderId}",
                    style:
                        TextStyleConst.boldTextStyle(ColorConst.blackColor, 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            if (order.items != null && order.items!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.medication_liquid,
                      size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      order.items!
                          .map((e) => e.medicineName ?? "Medicine")
                          .join(", "),
                      style: TextStyleConst.mediumTextStyle(Colors.black87, 14)
                          .copyWith(height: 1.3),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
            const Divider(height: 25, color: ColorConst.borderGreyColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Amount",
                      style: TextStyleConst.mediumTextStyle(
                          ColorConst.hintGreyColor, 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "₹${order.totalAmount ?? 0}",
                      style: TextStyleConst.boldTextStyle(
                          ColorConst.primaryColor, 18),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: ColorConst.lightGreyColor.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.chevron_right,
                      color: Colors.grey, size: 20),
                )
              ],
            ),
          ],
        ),
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
}
