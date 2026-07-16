import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/api_request/api_request.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_category_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletters_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/newsletters_model/newsletter_comments_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';

class NewslettersController extends GetxController {
  final ApiClient _apiClient = ApiClient(Dio(), baseUrl: ConfigUtils.baseUrl);

  RxBool isLoading = false.obs;
  RxList<NewsletterCategory> categories = <NewsletterCategory>[].obs;
  RxList<Newsletter> allArticles = <Newsletter>[].obs;

  RxList<NewsletterComment> comments = <NewsletterComment>[].obs;
  RxBool isLoadingComments = false.obs;

  RxInt selectedCategoryIndex = 0.obs;

  // Helper getter to easily track which initialized articles are currently liked globally
  List<int> get likedNewsletterIds => allArticles.where((a) => a.isLiked == true && a.id != null).map((a) => a.id!).toList();

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }


  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      final token = PreferenceUtils.getStringValue("token");
      final response = await _apiClient.getNewsletterCategories(" $token");

      if (response.success == true && response.data != null) {
        // Add an "All" category at index 0
        final List<NewsletterCategory> fetchedCategories = [
          NewsletterCategory(id: 0, name: "All")
        ];
        fetchedCategories.addAll(response.data!);
        categories.value = fetchedCategories;

        // Fetch articles for the default "All" category initially.
        fetchNewsletters();
      } else {
        isLoading.value = false;
      }
    } catch (e) {
      print("Error fetching newsletter categories: $e");
      isLoading.value = false;
    }
  }

  Future<void> fetchNewsletters({int? categoryId}) async {
    isLoading.value = true;
    try {
      final token = PreferenceUtils.getStringValue("token");
      // Pass null if ID is 0 ("All") so the query param is omitted
      final reqCategoryId = (categoryId != null && categoryId != 0) ? categoryId : null;
      final response = await _apiClient.getNewsletters(" $token", reqCategoryId);

      if (response.success == true && response.data != null) {
        allArticles.value = response.data!;
      } else {
        allArticles.clear();
      }
    } catch (e) {
      print("Error fetching newsletters: $e");
      allArticles.clear();
    }

    isLoading.value = false;
  }

  void changeTab(int index) {
    if (index != selectedCategoryIndex.value) {
      selectedCategoryIndex.value = index;
      allArticles.clear(); // Clear local list to show Skeletons immediately upon tab transition
      if (categories.isNotEmpty && index < categories.length) {
        fetchNewsletters(categoryId: categories[index].id);
      }
    }
  }

  // Returns all currently fetched articles (since they are already filtered by the API call)
  List<Newsletter> getArticlesForCategoryIndex(int index) {
    return allArticles;
  }

  Future<bool?> likeNewsletter(int id) async {
    try {
      final token = PreferenceUtils.getStringValue("token");
      final response = await _apiClient.likeNewsletter(" $token", id);
      if (response.success == true && response.data != null) {
        final newIsLikedState = response.data!.isLiked ?? false;

        // Update the state in allArticles
        final index = allArticles.indexWhere((article) => article.id == id);
        if (index != -1) {
          // Only modify totalLikes if the API state differs from our optimistic UI state
          if (allArticles[index].isLiked != newIsLikedState) {
            allArticles[index].isLiked = newIsLikedState;

            if (newIsLikedState) {
              allArticles[index].totalLikes = (allArticles[index].totalLikes ?? 0) + 1;
            } else {
              allArticles[index].totalLikes = (allArticles[index].totalLikes ?? 1) - 1;
              if (allArticles[index].totalLikes! < 0) {
                allArticles[index].totalLikes = 0;
              }
            }
          }

          allArticles.refresh();
        }

        return newIsLikedState;
      }
    } catch (e) {
      print("Error liking newsletter: $e");
    }
    return null;
  }

  Future<void> viewNewsletter(int id) async {
    try {
      final token = PreferenceUtils.getStringValue("token");
      await _apiClient.viewNewsletter(" $token", id);
    } catch (e) {
      print("Error viewing newsletter: $e");
    }
  }

  Future<void> shareNewsletter(int id) async {
    try {
      final token = PreferenceUtils.getStringValue("token");
      await _apiClient.shareNewsletter(" $token", id);
    } catch (e) {
      print("Error sharing newsletter: $e");
    }
  }

  Future<void> fetchComments(int id) async {
    isLoadingComments.value = true;
    try {
      final token = PreferenceUtils.getStringValue("token");
      final response = await _apiClient.getNewsletterComments(" $token", id);
      if (response.success == true && response.data != null) {
        comments.value = response.data!;
      } else {
        comments.clear();
      }
    } catch (e) {
      print("Error fetching comments: $e");
      comments.clear();
    }
    isLoadingComments.value = false;
  }

  Future<int?> postComment(int id, String text) async {
    if (text.trim().isEmpty) return null;
    try {
      final token = PreferenceUtils.getStringValue("token");
      final response = await _apiClient.postNewsletterComment(" $token", id, {"comment": text});
      if (response.success == true) {
        // Refresh comments after successful post
        await fetchComments(id);

        // Use the newly fetched comments length as the true source of truth
        final newCommentCount = comments.length;

        // Update the total comments count in the main list
        final index = allArticles.indexWhere((article) => article.id == id);
        if (index != -1) {
          allArticles[index].totalComments = newCommentCount;
          allArticles.refresh();
        }

        return newCommentCount;
      }
    } catch (e) {
      print("Error posting comment: $e");
    }
    return null;
  }
}
