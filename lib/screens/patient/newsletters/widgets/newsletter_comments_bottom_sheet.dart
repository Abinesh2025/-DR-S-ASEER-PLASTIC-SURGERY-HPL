import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/newsletters_controller/newsletters_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';

class NewsletterCommentsBottomSheet extends StatefulWidget {
  final int newsletterId;
  final ValueChanged<int>? onCommentAdded;
  
  const NewsletterCommentsBottomSheet({super.key, required this.newsletterId, this.onCommentAdded});

  @override
  State<NewsletterCommentsBottomSheet> createState() => _NewsletterCommentsBottomSheetState();
}

class _NewsletterCommentsBottomSheetState extends State<NewsletterCommentsBottomSheet> {
  final NewslettersController _controller = Get.find<NewslettersController>();
  final TextEditingController _commentTextController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isPosting = false;

  @override
  void initState() {
    super.initState();
    _controller.fetchComments(widget.newsletterId);
  }

  @override
  void dispose() {
    _commentTextController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _postComment() async {
    final text = _commentTextController.text.trim();
    if (text.isEmpty) return;
    
    setState(() => _isPosting = true);
    
    // Unfocus keyboard
    _focusNode.unfocus();
    
    int? newCommentCount = await _controller.postComment(widget.newsletterId, text);
    
    if (mounted) {
      setState(() => _isPosting = false);
      if (newCommentCount != null) {
        _commentTextController.clear();
        widget.onCommentAdded?.call(newCommentCount);
        Get.snackbar(
          "Success", 
          "Comment added successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      } else {
        Get.snackbar(
          "Error", 
          "Failed to post comment. Please try again.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.9),
          colorText: Colors.white,
          margin: const EdgeInsets.all(15),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Comments",
                  style: TextStyleConst.boldTextStyle(ColorConst.blackColor, 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Comments List
          Expanded(
            child: Obx(() {
              if (_controller.isLoadingComments.value) {
                return const Center(child: CircularProgressIndicator(color: Colors.black));
              }
              
              if (_controller.comments.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline, size: 50, color: Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text(
                        "No comments yet",
                        style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Be the first to share your thoughts!",
                        style: TextStyleConst.mediumTextStyle(Colors.grey[400]!, 14),
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemCount: _controller.comments.length,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 1),
                ),
                itemBuilder: (context, index) {
                  final comment = _controller.comments[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(comment.patientImage ?? ''),
                        backgroundColor: Colors.grey[200],
                        onBackgroundImageError: (_, __) => const Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  comment.patientName ?? 'Anonymous',
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.blackColor, 
                                    14,
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  _formatCommentDate(comment.createdAt),
                                  style: TextStyleConst.mediumTextStyle(
                                    ColorConst.hintGreyColor, 
                                    12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              comment.comment ?? '',
                              style: TextStyleConst.mediumTextStyle(
                                Colors.black87, 
                                14,
                              ).copyWith(height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
          ),
          
          // Comment Input Field
          Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
              bottom: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  offset: const Offset(0, -5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _commentTextController,
                      focusNode: _focusNode,
                      maxLines: 3,
                      minLines: 1,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _postComment(),
                      decoration: InputDecoration(
                        hintText: "Add a comment...",
                        hintStyle: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 14),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: _isPosting ? null : _postComment,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorConst.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: _isPosting 
                      ? const SizedBox(
                          width: 20, 
                          height: 20, 
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                        )
                      : const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  String _formatCommentDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return '';
    try {
      // Very simple formatter, just grabs date part or relies on API format
      // If API returns "2026-03-16 16:06:29", extract just the date or format it nicely
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);
      
      if (difference.inDays == 0) {
        if (difference.inHours == 0) {
          if (difference.inMinutes == 0) {
            return 'Just now';
          }
          return '${difference.inMinutes}m ago';
        }
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      }
      
      return "${date.day}/${date.month}/${date.year}";
    } catch (e) {
      return dateStr.split(' ')[0]; // Fallback
    }
  }
}
