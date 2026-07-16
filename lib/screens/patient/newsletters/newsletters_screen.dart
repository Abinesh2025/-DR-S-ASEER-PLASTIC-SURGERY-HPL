import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/newsletters_controller/newsletters_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_app_bar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:intl/intl.dart';
import 'newsletter_details_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/skeleton_loading_widgets.dart';

class NewslettersScreen extends StatefulWidget {
  final bool showAppBar;
  const NewslettersScreen({super.key, this.showAppBar = false});

  @override
  State<NewslettersScreen> createState() => _NewslettersScreenState();
}

class _NewslettersScreenState extends State<NewslettersScreen> with TickerProviderStateMixin {
  final NewslettersController controller = Get.put(NewslettersController());
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Initialize immediately if categories are already loaded
    if (controller.categories.isNotEmpty) {
      _initTabController();
    }
    
    // Listen for category updates to recreate tab controller
    ever(controller.categories, (_) {
      _initTabController();
    });
  }

  void _initTabController() {
    if (_tabController != null) {
      _tabController!.dispose();
    }
    _tabController = TabController(length: controller.categories.length, vsync: this);
    
    _tabController!.addListener(() {
      if (!_tabController!.indexIsChanging) {
        // Trigger generic API fetch when sliding or tapping tabs
        controller.changeTab(_tabController!.index);
      }
    });
    
    // Force rebuild
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Show loading if categories haven't loaded yet
      if (controller.categories.isEmpty || _tabController == null) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: widget.showAppBar 
            ? CommonAppBar(
                title: StringUtils.newsletters,
                leadIcon: const Icon(Icons.arrow_back_ios),
                leadOnTap: () => Get.back(),
              ) 
            : null,
          body: const Center(child: CircularProgressIndicator(color: Colors.black)),
        );
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: widget.showAppBar 
          ? CommonAppBar(
              title: StringUtils.newsletters,
              leadIcon: const Icon(Icons.arrow_back_ios),
              leadOnTap: () {
                Get.back();
              },
            ) 
          : null,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tab Bar
              TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.black,
                labelColor: Colors.black,
                unselectedLabelColor: ColorConst.hintGreyColor,
                labelStyle: TextStyleConst.mediumTextStyle(Colors.black, 16).copyWith(fontWeight: FontWeight.w600),
                unselectedLabelStyle: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 16).copyWith(fontWeight: FontWeight.w500),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 5),
                labelPadding: const EdgeInsets.symmetric(horizontal: 15),
                tabAlignment: TabAlignment.start,
                dividerColor: Colors.transparent, // Disable default border
                tabs: controller.categories.map((cat) {
                  return Tab(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5), // Match mockup bottom padding
                      child: Text(cat.name ?? ''),
                    ),
                  );
                }).toList(),
              ),
              
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              
              // Articles List using TabBarView
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: List.generate(
                    controller.categories.length,
                    (index) {
                      return RefreshIndicator(
                        color: Colors.black,
                        onRefresh: () async {
                          await controller.fetchNewsletters(categoryId: controller.categories[index].id);
                        },
                        child: Obx(() {
                          if (controller.isLoading.value && controller.allArticles.isEmpty) {
                             return ListView.separated(
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              padding: const EdgeInsets.all(20),
                              itemCount: 5,
                              separatorBuilder: (context, index) => const Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Divider(color: Color(0xFFEEEEEE), height: 1),
                              ),
                              itemBuilder: (context, index) => const NewsletterSkeleton(),
                            );
                          }
                          
                          final articles = controller.getArticlesForCategoryIndex(index);
                          
                          if (articles.isEmpty) {
                            return ListView(
                              physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                              children: [
                                SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                                Center(
                                  child: Text(
                                    "No newsletters found",
                                    style: TextStyleConst.mediumTextStyle(ColorConst.hintGreyColor, 16),
                                  ),
                                ),
                              ],
                            );
                          }
                          
                          return ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                            padding: const EdgeInsets.all(20),
                            itemCount: articles.length,
                          separatorBuilder: (context, index) => const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(color: Color(0xFFEEEEEE), height: 1),
                          ),
                          itemBuilder: (context, idx) {
                            final article = articles[idx];
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => NewsletterDetailsScreen(article: article));
                              },
                              child: Container(
                                color: Colors.transparent, // Ensures the whole row is clickable
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Author Info
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
                                    
                                    // Title and Image
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
                                                  18,
                                                ).copyWith(height: 1.3),
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 12),
                                              
                                              // Category and Date
                                              Row(
                                                children: [
                                                  Container(
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
                                              

                                              Obx(() {
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
                                                        controller.allArticles.refresh(); 
                                                        
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
                                              height: 80,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) => Container(
                                                height: 80,
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
                        );
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
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
