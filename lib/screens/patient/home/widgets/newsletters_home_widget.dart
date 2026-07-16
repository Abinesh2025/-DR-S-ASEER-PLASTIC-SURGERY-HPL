import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/newsletters_controller/newsletters_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/newsletters/newsletters_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/newsletters/newsletter_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';
import 'package:intl/intl.dart';

class NewslettersHomeWidget extends StatelessWidget {
  const NewslettersHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final NewslettersController controller = Get.put(NewslettersController());

    return Obx(() {
      if (controller.isLoading.value) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) => const NewsletterSkeleton(),
        );
      }

      // We can use allArticles directly since this is just a preview
      final articles = controller.allArticles.take(3).toList();

      if (articles.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringUtils.newsletters,
                  style: TextStyleConst.boldTextStyle(
                    ColorConst.blackColor,
                    18,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigate to NewslettersScreen with AppBar
                    Get.to(() => const NewslettersScreen(showAppBar: true));
                  },
                  child: Row(
                    children: [
                      Text(
                        StringUtils.seeAll,
                        style: TextStyleConst.mediumTextStyle(
                          ColorConst.primaryColor.withOpacity(0.7),
                          14,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: ColorConst.primaryColor.withOpacity(0.7),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: articles.length,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) {
              final article = articles[index];
              return GestureDetector(
                onTap: () {
                  Get.to(() => NewsletterDetailsScreen(article: article));
                },
                child: Container(
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
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: NetworkImage(article.authorImage ?? ''),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(width: 8),
                          Text(
                            article.authorName ?? '',
                            style: TextStyleConst.mediumTextStyle(
                              ColorConst.blackColor,
                              14,
                            ).copyWith(fontWeight: FontWeight.w600),
                          ),
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
                                Text(
                                  article.title ?? '',
                                  style: TextStyleConst.boldTextStyle(
                                    ColorConst.blackColor,
                                    16,
                                  ).copyWith(height: 1.3),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Colors.grey[100],
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          article.category ?? '',
                                          style: TextStyleConst.mediumTextStyle(
                                            ColorConst.hintGreyColor,
                                            12,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      article.createdAt != null
                                          ? DateFormat('dd-MM-yyyy')
                                          .format(DateTime.parse(article.createdAt!))
                                          : '',
                                      style: TextStyleConst.mediumTextStyle(
                                        ColorConst.hintGreyColor,
                                        12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Interactions (Likes, Comments, Shares, Views)
                                Obx(() {
                                  // Rebuilding when the list changes (or when controller calls update())
                                  // The controller.allArticles is an RxList, but modifying a single item doesn't always trigger Obx.
                                  // So we find the article from the controller's list to bind it.
                                  // Assuming the list itself triggers update, or we manually call update() on the controller.
                                  final currentArticle = controller.allArticles.firstWhereOrNull((a) => a.id == article.id) ?? article;

                                  return Row(
                                    children: [
                                      _buildInteractionItem(
                                        (currentArticle.isLiked ?? false) ? Icons.favorite : Icons.favorite_border,
                                        currentArticle.totalLikes,
                                        iconColor: (currentArticle.isLiked ?? false) ? Colors.red : ColorConst.hintGreyColor,
                                        onTap: () async {
                                          bool isCurrentlyLiked = currentArticle.isLiked ?? false;
                                          int currentLikes = currentArticle.totalLikes ?? 0;
                                          // Optimistic Update
                                          currentArticle.isLiked = !isCurrentlyLiked;
                                          int newLikes = isCurrentlyLiked ? (currentLikes - 1) : (currentLikes + 1);
                                          currentArticle.totalLikes = newLikes < 0 ? 0 : newLikes;
                                          controller.allArticles.refresh(); // Trigger Obx

                                          // API Call
                                          bool? updatedLikedState = await controller.likeNewsletter(currentArticle.id ?? 0);

                                          if (updatedLikedState != null) {
                                            currentArticle.isLiked = updatedLikedState;
                                            controller.allArticles.refresh();
                                          }
                                        }
                                      ),
                                      const SizedBox(width: 12),
                                      _buildInteractionItem(
                                        Icons.chat_bubble_outline,
                                        currentArticle.totalComments,
                                      ),
                                      // const SizedBox(width: 12),
                                      // _buildInteractionItem(
                                      //   Icons.share,
                                      //   currentArticle.totalShares,
                                      // ),
                                      const SizedBox(width: 12),
                                      _buildInteractionItem(
                                        Icons.visibility_outlined,
                                        currentArticle.viewsCount,
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                article.image ?? '',
                                height: 75,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 75,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.error),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }

  Widget _buildInteractionItem(IconData icon, int? count, {Color? iconColor, VoidCallback? onTap}) {
    if (count == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor ?? ColorConst.hintGreyColor),
          const SizedBox(width: 4),
          Text(
            _formatCount(count),
            style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 12),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}k';
    }
    return count.toString();
  }
}
