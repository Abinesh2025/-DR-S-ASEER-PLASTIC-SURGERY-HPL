import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/text_style_const.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletters_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_details_model.dart';
import 'package:dio/dio.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/api_request/api_request.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/newsletters_controller/newsletters_controller.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/newsletters/widgets/newsletter_comments_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsletterDetailsScreen extends StatefulWidget {
  final Newsletter article;

  const NewsletterDetailsScreen({super.key, required this.article});

  @override
  State<NewsletterDetailsScreen> createState() => _NewsletterDetailsScreenState();
}

class _NewsletterDetailsScreenState extends State<NewsletterDetailsScreen> {
  final ApiClient _apiClient = ApiClient(Dio(), baseUrl: ConfigUtils.baseUrl);
  late Future<NewsletterDetailsModel?> _detailsFuture;

  @override
  void initState() {
    super.initState();
    print("====== SCREEN INIT ======");
    print("====== ARTICLE ID: ${widget.article.id} ======");
    print("====== ARTICLE SLUG: ${widget.article.slug} ======");

    _detailsFuture = _fetchDetails();
  }

  Future<NewsletterDetailsModel?> _fetchDetails() async {
    try {
      final token = PreferenceUtils.getStringValue("token");

      int? articleId = widget.article.id;

      if (articleId == null && widget.article.slug != null) {
        // Fetch details directly by slug if we don't have the ID
        print("====== FETCHING BY SLUG: ${widget.article.slug} ======");
        final detailsResponse = await _apiClient.getNewsletterDetailsBySlug(" $token", widget.article.slug!);
        print('details reponse ${detailsResponse}');
        print("====== SLUG RESPONSE SUCCESS: ${detailsResponse.success} ======");
        if (detailsResponse.data != null) {

          print("====== SLUG RESPONSE TITLE: ${detailsResponse.data!.title} ======");
          print("====== SLUG RESPONSE CONTENT LENGTH: ${detailsResponse.data!.content?.length ?? 0} ======");
        } else {
          print("====== SLUG RESPONSE DATA IS NULL ======");
        }

        if (detailsResponse.success == true && detailsResponse.data != null) {
          final foundData = detailsResponse.data!;

          // Populate the widget with the full data so the UI reflects it immediately
          widget.article.id = foundData.id;
          widget.article.title = foundData.title;
          widget.article.image = foundData.image;
          widget.article.category = foundData.category;
          widget.article.authorName = foundData.authorName;
          widget.article.authorImage = foundData.authorImage;
          widget.article.createdAt = foundData.createdAt;
          widget.article.description = foundData.description;
          widget.article.totalLikes = foundData.totalLikes;
          widget.article.totalComments = foundData.totalComments;
          widget.article.viewsCount = foundData.viewsCount;

          // Safely initialize controller for deep links from terminated state
          final NewslettersController controller = Get.isRegistered<NewslettersController>()
              ? Get.find<NewslettersController>()
              : Get.put(NewslettersController());

          // Trigger View API in the background using the newly found ID
          if (foundData.id != null) {
            controller.viewNewsletter(foundData.id!);
            // Hydrate liked status from the global controller
            detailsResponse.data!.isLiked = controller.likedNewsletterIds.contains(foundData.id);
            widget.article.isLiked = detailsResponse.data!.isLiked;
          }

          if (mounted) setState(() {});
          return detailsResponse;
        } else {
          print("Newsletter not found by slug via API. Success was false or Data was null.");
          return null;
        }
      }

      // Standard fallback if we already had an ID
      if (articleId == null || articleId == 0) return null;

      final controller = Get.isRegistered<NewslettersController>()
          ? Get.find<NewslettersController>()
          : Get.put(NewslettersController());

      // Trigger View API in the background when details are fetched
      controller.viewNewsletter(articleId);

      final detailsResponse = await _apiClient.getNewsletterDetails(" $token", articleId);
      if (detailsResponse.success == true && detailsResponse.data != null) {
          print('details reponse ${detailsResponse}');
           print("====== RESPONSE SUCCESS: ${detailsResponse.success} ======");

          print(
            const JsonEncoder.withIndent('  ')
                .convert(detailsResponse.toJson()),
          );
        // Hydrate the is_liked status from the global controller
        detailsResponse.data!.isLiked = controller.likedNewsletterIds.contains(articleId);
      }
      return detailsResponse;
    } catch (e) {
      print("Error fetching newsletter details: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<NewsletterDetailsModel?>(
          future: _detailsFuture,
          builder: (context, snapshot) {
            final bool isLoading = snapshot.connectionState == ConnectionState.waiting;
            final details = snapshot.data?.data;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.black));
            }

            if (details == null) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
                    onPressed: () {
                      if (Get.previousRoute.isEmpty || Get.previousRoute == '/') {
                        if (GoRouter.of(context).canPop()) {
                          GoRouter.of(context).pop();
                        } else {
                          context.go('/home');
                        }
                      } else {
                        Get.back();
                      }
                    },
                  ),
                ),
                body: Center(
                  child: Text(
                    "No news found",
                    style: TextStyleConst.mediumTextStyle(Colors.grey[600]!, 16),
                  ),
                ),
              );
            }

            return Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    // Header Image with text overlay
                    SliverAppBar(
                      expandedHeight: 350.0,
                      floating: false,
                      pinned: true,
                      backgroundColor: Colors.black,
                      elevation: 0,
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                        onPressed: () {
                          if (Get.previousRoute.isEmpty || Get.previousRoute == '/') {
                            // Try go_router context pop first if we are in a sub route
                            if (GoRouter.of(context).canPop()) {
                              GoRouter.of(context).pop();
                            } else {
                              // If deep linked directly, push to home
                              context.go('/home');
                            }
                          } else {
                            Get.back();
                          }
                        },
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipOval(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.15),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.4),
                                    width: 1.5,
                                  ),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.share, color: Colors.white),
                                  onPressed: () {
                                    _handleShare();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Background Image
                            Builder(
                                builder: (context) {
                                  final String imageUrl = details?.image ?? widget.article.image ?? '';
                                  if (imageUrl.isEmpty) {
                                    return Container(color: Colors.grey[800]);
                                  }
                                  return Image.network(
                                    imageUrl,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[800]),
                                  );
                                }
                            ),
                            // Gradient overlay for text readability
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.4),
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  stops: const [0.0, 0.5, 1.0],
                                ),
                              ),
                            ),
                            // Text overlay
                            Positioned(
                              bottom: 20,
                              left: 20,
                              right: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    details.category ?? '',
                                    style: TextStyleConst.mediumTextStyle(
                                      Colors.white.withOpacity(0.9),
                                      14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    details.title ?? '',
                                    style: TextStyleConst.boldTextStyle(
                                      Colors.white,
                                      26,
                                    ).copyWith(height: 1.2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Article Content
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 100), // Bottom padding for floating bar
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Author Row
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        details.authorName ?? '',
                                        style: TextStyleConst.boldTextStyle(
                                          ColorConst.blackColor,
                                          16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Builder(
                                          builder: (context) {
                                            final String dateString =
                                                details?.createdAt ?? widget.article.createdAt ?? '';

                                            String displayDate = '';

                                            if (dateString.isNotEmpty) {
                                              final DateTime date = DateTime.parse(dateString);
                                              displayDate = DateFormat('dd-MM-yyyy').format(date);
                                            }

                                            return Text(
                                              displayDate,
                                              style: TextStyleConst.mediumTextStyle(
                                                ColorConst.hintGreyColor,
                                                14,
                                              ),
                                            );
                                          }
                                      ),
                                    ],
                                  ),
                                ),
                                Builder(
                                    builder: (context) {
                                      final String avatarUrl = details?.authorImage ?? widget.article.authorImage ?? '';
                                      return CircleAvatar(
                                        radius: 20,
                                        backgroundImage: avatarUrl.isNotEmpty ? NetworkImage(avatarUrl) : null,
                                        backgroundColor: Colors.grey[200],
                                        child: avatarUrl.isEmpty ? Icon(Icons.person, color: Colors.grey[400]) : null,
                                      );
                                    }
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                            const Divider(height: 1, color: Color(0xFFEEEEEE)),
                            const SizedBox(height: 20),

                            // Content Text
                            if (details.content != null && details.content!.isNotEmpty)
                              Html(
                                data: details.content,
                                onLinkTap: (url, attributes, element) async {
                                  if (url != null) {
                                    final uri = Uri.parse(url);

                                    if (await canLaunchUrl(uri)) {
                                      await launchUrl(
                                        uri,
                                        mode: LaunchMode.externalApplication,
                                      );
                                    }
                                  }
                                },
                                style: {
                                  "body": Style(
                                    padding: HtmlPaddings.zero,
                                    margin: Margins.zero,
                                    fontSize: FontSize(16.0),
                                    lineHeight: const LineHeight(1.6),
                                    color: ColorConst.hintGreyColor.withOpacity(0.8),
                                  ),
                                  "a": Style(
                                    color: Colors.blue,
                                    textDecoration: TextDecoration.underline,
                                  ),
                                },
                              )
                            else
                              Text(
                                details.description ?? '', // Fallback to details description
                                style: TextStyleConst.mediumTextStyle(
                                  ColorConst.hintGreyColor.withOpacity(0.8),
                                  16,
                                ).copyWith(
                                  height: 1.6,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Floating Bottom Action Bar
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildActionItem(
                            (details.isLiked ?? false)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            _formatCount(details.totalLikes ?? 0),
                            iconColor: (details.isLiked ?? false)
                                ? Colors.red
                                : Colors.black87,
                            onTap: () async {
                              // Optimistically update local UI
                              bool currentLiked = details.isLiked ?? false;
                              int currentLikes = details.totalLikes ?? 0;

                              setState(() {
                                details.isLiked = !currentLiked;
                                // Always bound check to 0
                                int newLikes = currentLiked ? (currentLikes - 1) : (currentLikes + 1);
                                details.totalLikes = newLikes < 0 ? 0 : newLikes;

                                // Keep the base article id synchronized locally for List Screens
                                widget.article.isLiked = details.isLiked;
                                widget.article.totalLikes = details.totalLikes;
                              });

                              // Safely get or init controller
                              final controller = Get.isRegistered<NewslettersController>()
                                  ? Get.find<NewslettersController>()
                                  : Get.put(NewslettersController());

                              // Trigger Obx re-build on list screens
                              controller.allArticles.refresh();

                              // Call API
                              bool? updatedLikedState = await controller.likeNewsletter(details.id ?? 0);

                              // True state from API
                              if (updatedLikedState != null && mounted) {
                                setState(() {
                                  details.isLiked = updatedLikedState;
                                  widget.article.isLiked = updatedLikedState;
                                });
                                controller.allArticles.refresh();
                              }
                            },
                          ),
                          const SizedBox(width: 24),
                          _buildActionItem(
                            Icons.chat_bubble_outline,
                            _formatCount(details.totalComments ?? 0),
                            onTap: () {
                              _showCommentsBottomSheet(context, details.id ?? 0);
                            },
                          ),
                          const SizedBox(width: 24),
                          _buildActionItem(
                            Icons.visibility_outlined,
                            _formatCount(details.viewsCount ?? 0),
                            onTap: null, // Views are passively triggered
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  void _showCommentsBottomSheet(BuildContext context, int newsletterId) {
    Get.bottomSheet(
      SafeArea(
        child: NewsletterCommentsBottomSheet(
          newsletterId: newsletterId,
          onCommentAdded: (int newCount) {
            // Update local details count with the exact count from API
            setState(() {
              widget.article.totalComments = newCount;
              _detailsFuture.then((res) {
                if (res != null && res.data != null) {
                  res.data!.totalComments = newCount;
                }
              });
            });
          },
        ),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      ignoreSafeArea: false,
    );
  }

  Widget _buildActionItem(IconData icon, String text, {VoidCallback? onTap, Color iconColor = Colors.black87}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: iconColor),
            if (text.isNotEmpty && text != '0') ...[
              const SizedBox(width: 6),
              Text(
                text,
                style: TextStyleConst.boldTextStyle(
                  ColorConst.blackColor,
                  14,
                ).copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _handleShare() async {
    final slug = widget.article.slug ?? '';
    if (slug.isEmpty) return;

    final shareUrl = '${ConfigUtils.newsletterShareUrl}$slug';

    // Open native share sheet
    await Share.share('Check out this newsletter: $shareUrl');

    // Increment share count locally
    setState(() {
      widget.article.totalShares = (widget.article.totalShares ?? 0) + 1;
      _detailsFuture.then((res) {
        if (res != null && res.data != null) {
          res.data!.totalShares = (res.data!.totalShares ?? 0) + 1;
        }
      });
    });
    // Safely get or init controller
    final controller = Get.isRegistered<NewslettersController>()
        ? Get.find<NewslettersController>()
        : Get.put(NewslettersController());

    controller.allArticles.refresh();

    // Fire background API request
    controller.shareNewsletter(widget.article.id ?? 0);
  }

  String _formatCount(int count) {
    if (count == 0) return "";
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(count % 1000 == 0 ? 0 : 1)}k';
    }
    return count.toString();
  }
}