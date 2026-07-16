import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../constant/color_const.dart';
import '../../../constant/text_style_const.dart';
import '../../../utils/string_utils.dart';
import '../../admin_controllers/push_notification_controller/push_notification_controller.dart';
import '../../../model/push_notification/regular_update_model.dart';

class RegularUpdatesListScreen extends StatelessWidget {
  final RegularUpdateController controller = Get.put(RegularUpdateController());

  RegularUpdatesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      floatingActionButton: SafeArea(
        child: FloatingActionButton.extended(
          onPressed: () => Get.to(() => AddRegularUpdateScreen()),
          backgroundColor: const Color(0xFF6366F1),
          icon: const Icon(Icons.add_rounded, color: Colors.white, size: 20),
          label: Text("Create", style: TextStyleConst.boldTextStyle(Colors.white, 12)),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.refreshUpdates(),
        color: const Color(0xFF6366F1),
        displacement: 40,
        child: CustomScrollView(
          controller: controller.scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            Obx(() {
              // 1. Full-screen Loading State
              if (controller.isLoading.value && controller.updatesList.isEmpty) {
                return SliverFillRemaining(
                   hasScrollBody: false,
                   child: Center(child: CircularProgressIndicator(strokeWidth: 3, color: const Color(0xFF6366F1))),
                );
              }

              // 2. Empty State
              if (controller.updatesList.isEmpty && !controller.isLoading.value) {
                return SliverFillRemaining(
                   hasScrollBody: false,
                   child: _buildEmptyState(),
                );
              }

              // 3. The Actual List (Scrollable)
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      // DIAGNOSTIC PAGINATION TRIGGER
                      if (index >= controller.updatesList.length - 2 && index < controller.updatesList.length) {
                         // print("DEBUG: Item builder index: $index. Triggering loadMore.");
                         controller.loadMore();
                      }

                      if (index < controller.updatesList.length) {
                        return _buildSmallNotificationCard(context, controller.updatesList[index]);
                      } else {
                        // REFINED FOOTER SYSTEM
                        return Obx(() {
                          if (controller.isMoreLoading.value) {
                            return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF6366F1))),
                            );
                          }
                          
                          // If we are at the bottom but not loading, show a spacer or a "no more items" message
                          if (controller.currentPage.value < controller.lastPage.value) {
                             // This handles cases where the user scrolled to the absolute bottom but loadMore haven't finished
                             return Padding(
                               padding: const EdgeInsets.symmetric(vertical: 20),
                               child: Center(
                                 child: TextButton(
                                   onPressed: () => controller.loadMore(),
                                   child: Text("Load More Items...", style: TextStyleConst.boldTextStyle(const Color(0xFF6366F1), 12)),
                                 ),
                               ),
                             );
                          }
                          
                          return const SizedBox(height: 120); // FAB Safety space
                        });
                      }
                    },
                    childCount: controller.updatesList.length + 1,
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showResendDialog(BuildContext context, int id) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 70, width: 70, decoration: BoxDecoration(color: const Color(0xFF10B981).withOpacity(0.1), shape: BoxShape.circle), child: const Icon(Icons.send_rounded, color: Color(0xFF10B981), size: 35)),
              const SizedBox(height: 20),
              Text("Resend Notification?", style: TextStyleConst.boldTextStyle(Colors.black, 18)),
              const SizedBox(height: 12),
              Text("Are you sure you want to broadcast this update to all patients again? This will trigger a new push notification.", textAlign: TextAlign.center, style: TextStyleConst.mediumTextStyle(Colors.black54, 14)),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Get.back(), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text(StringUtils.cancel, style: TextStyleConst.mediumTextStyle(Colors.black54, 14)))),
                  const SizedBox(width: 12),
                  Expanded(child: ElevatedButton(onPressed: () { controller.resendNotification(id); Get.back(); }, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), padding: const EdgeInsets.symmetric(vertical: 12), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text("Resend Now", style: TextStyleConst.boldTextStyle(Colors.white, 14)))),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }

  Widget _buildSmallNotificationCard(BuildContext context, RegularUpdateData item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4))]),
      child: InkWell(
        onTap: () => _showDetailsSheet(context, item),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Hero(tag: "update_img_${item.id}", child: ClipRRect(borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)), child: Container(width: 100, height: 100, color: Colors.grey.shade50, child: (item.imageUrl != null && item.imageUrl!.isNotEmpty) ? Image.network(item.imageUrl!, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image, size: 24, color: Colors.grey)) : const Icon(Icons.image_outlined, size: 24, color: Colors.grey)))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(item.title ?? "", style: TextStyleConst.boldTextStyle(const Color(0xFF1E1B4B), 15), maxLines: 1, overflow: TextOverflow.ellipsis)),
                        const SizedBox(width: 4),
                        _buildActionIcon(Icons.send_rounded, const Color(0xFF10B981), () => _showResendDialog(context, item.id!)),
                        _buildActionIcon(Icons.delete_outline_rounded, const Color(0xFFEF4444), () => _showDeleteDialog(context, item.id!)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(item.description ?? "No description", style: TextStyleConst.mediumTextStyle(Colors.black45, 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 10),
                    Row(
                      children: [const Icon(Icons.calendar_today_rounded, size: 12, color: Color(0xFF6366F1)), const SizedBox(width: 5), Text(_formatDate(item.startDate), style: TextStyleConst.boldTextStyle(const Color(0xFF6366F1), 11))],
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

  Widget _buildActionIcon(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(onTap: onTap, child: Padding(padding: const EdgeInsets.symmetric(horizontal: 4), child: Icon(icon, size: 23, color: color)));
  }

  void _showDetailsSheet(BuildContext context, RegularUpdateData item) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: Container(width: 45, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)))),
              const SizedBox(height: 24),
              ClipRRect(borderRadius: BorderRadius.circular(16), child: (item.imageUrl != null && item.imageUrl!.isNotEmpty) ? Image.network(item.imageUrl!, width: double.infinity, height: 180, fit: BoxFit.cover) : Container(width: double.infinity, height: 180, color: Colors.grey.shade50)),
              const SizedBox(height: 24),
              Text(item.title ?? "", style: TextStyleConst.boldTextStyle(Colors.black, 20)),
              const SizedBox(height: 10),
              Text(item.description ?? "No description provided", style: TextStyleConst.mediumTextStyle(Colors.black54, 14).copyWith(height: 1.6)),
              const SizedBox(height: 30),
              SizedBox(width: double.infinity, height: 52, child: ElevatedButton(onPressed: () => Get.back(), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text("Close", style: TextStyleConst.boldTextStyle(Colors.white, 15)))),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return "N/A";
    try {
      final date = DateTime.tryParse(dateStr) ?? DateTime.now();
      return DateFormat('EEE, dd MMM').format(date);
    } catch (e) { return dateStr; }
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.notifications_none_rounded, size: 70, color: Colors.grey.shade200),
        const SizedBox(height: 16),
        Text("Your alert list is empty", style: TextStyleConst.boldTextStyle(Colors.grey, 16)),
        const SizedBox(height: 8),
        Text("Pull down to refresh or create one below", style: TextStyleConst.mediumTextStyle(Colors.grey.shade400, 13)),
      ],
    );
  }

  void _showDeleteDialog(BuildContext context, int id) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 70, width: 70, decoration: BoxDecoration(color: Colors.red.shade50, shape: BoxShape.circle), child: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent, size: 40)),
              const SizedBox(height: 20),
              Text("Delete Notification", style: TextStyleConst.boldTextStyle(Colors.black, 18)),
              const SizedBox(height: 12),
              Text("This action cannot be undone. Are you sure you want to remove this notification permanently?", textAlign: TextAlign.center, style: TextStyleConst.mediumTextStyle(Colors.black54, 14)),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: () => Get.back(), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), side: BorderSide(color: Colors.grey.shade300), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text(StringUtils.cancel, style: TextStyleConst.mediumTextStyle(Colors.black54, 14)))),
                  const SizedBox(width: 12),
                  Expanded(child: ElevatedButton(onPressed: () { controller.deleteUpdate(id); Get.back(); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, padding: const EdgeInsets.symmetric(vertical: 12), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))), child: Text(StringUtils.delete, style: TextStyleConst.boldTextStyle(Colors.white, 14)))),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: true,
    );
  }
}

class AddRegularUpdateScreen extends StatelessWidget {
  final RegularUpdateController controller = Get.find<RegularUpdateController>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  AddRegularUpdateScreen({super.key}) { controller.clearFields(); }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, leading: IconButton(icon: const Icon(Icons.close_rounded, color: Colors.black, size: 24), onPressed: () => Get.back()), title: Text(StringUtils.createPushNotification, style: TextStyleConst.boldTextStyle(const Color(0xFF1E1B4B), 17))),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildFormLabel("Notification Title"), const SizedBox(height: 8), _buildTextField(titleController, "e.g. Daily Health Tip"), const SizedBox(height: 24), _buildFormLabel("Description Content"), const SizedBox(height: 8), _buildTextField(descController, "Write your message here...", maxLines: 6), const SizedBox(height: 24), _buildFormLabel("Cover Image"), const SizedBox(height: 12), _buildImagePicker()]))),
          _buildActionButtons(),
        ],
      ),
    );
  }
  Widget _buildFormLabel(String text) { return Text(text, style: TextStyleConst.boldTextStyle(const Color(0xFF1E1B4B), 14)); }
  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) { return TextField(controller: controller, maxLines: maxLines, style: TextStyleConst.mediumTextStyle(Colors.black, 14), decoration: InputDecoration(hintText: hint, hintStyle: TextStyleConst.mediumTextStyle(Colors.grey.shade400, 14), filled: true, fillColor: const Color(0xFFF8FAFC), border: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(14)), contentPadding: const EdgeInsets.all(18))); }
  Widget _buildImagePicker() { return GestureDetector(onTap: () => controller.pickImage(), child: Obx(() => Container(width: double.infinity, height: 160, decoration: BoxDecoration(color: const Color(0xFFF8FAFC), border: Border.all(color: Colors.grey.shade100), borderRadius: BorderRadius.circular(16)), child: controller.selectedImage.value == null ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [const Icon(Icons.add_a_photo_outlined, size: 36, color: Color(0xFF6366F1)), const SizedBox(height: 8), Text("Upload Image", style: TextStyleConst.mediumTextStyle(const Color(0xFF6366F1), 13))]) : ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.file(controller.selectedImage.value!, fit: BoxFit.cover))))); }
  Widget _buildActionButtons() { return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade100))), child: Row(children: [Expanded(child: OutlinedButton(onPressed: () => Get.back(), style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: const Text("Cancel"))), const SizedBox(width: 14), Expanded(child: Obx(() => ElevatedButton(onPressed: controller.isSaving.value ? null : () => controller.addUpdate(title: titleController.text, desc: descController.text), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.symmetric(vertical: 16), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))), child: controller.isSaving.value ? const SizedBox(height: 22, width: 22, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text("Save Alert", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)))))])); }
}