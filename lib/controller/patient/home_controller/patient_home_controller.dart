import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/constant/color_const.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/token_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/banner/banner_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/follow_up_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/widgets/follow_up_detail_bottom_sheet.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/emergency_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_socket_exception.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/component/common_snackbar.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/doctor_department_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/disease_model.dart';
import 'package:pusher_client_socket/pusher_client_socket.dart';
import 'package:pusher_client_socket/channels/channel.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/variable_utils.dart';
import 'package:record/record.dart';
import 'package:geolocator/geolocator.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/doctor/doctor_list_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/doctor/get_doctor_model.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/preference_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/string_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/medicine_controller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/search_doctor_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/utils/config_utils.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/screens/patient/home/sos_screen.dart';
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/controller/patient/newsletters_controller/newsletters_controller.dart';

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:dr_s_aseer_plastic_surgery_and_accident_care_hospital/model/patient/appointment_model/appointment_model.dart';

class PatientHomeController extends GetxController {
  GetDoctorModel? getDoctorModel;
  DoctorDepartmentModel? doctorDepartmentModel;
  bool isDoctorsLoading = true;
  RxList<DoctorListData> allDoctors = <DoctorListData>[].obs;
  RxBool isAllDoctorsLoading = false.obs;

  // Diseases
  RxList<DiseaseData> diseases = <DiseaseData>[].obs;
  RxBool isDiseasesLoading = true.obs;

  // Banner
  RxList<BannerData> banners = <BannerData>[].obs;
  RxBool isBannersLoading = true.obs;

  // Follow-ups
  RxList<FollowUpData> followUps = <FollowUpData>[].obs;
  RxBool isFollowUpsLoading = false.obs;

  RxList<TokenModel> tokens = <TokenModel>[].obs;
  RxBool hasActiveToken = false.obs; // Tracks if user has an appointment
  RxList<AppointmentData> myAppointments = <AppointmentData>[].obs;
  RxList<AppointmentData> todayAppointments = <AppointmentData>[].obs; // 🔥 Added for UpcomingAppointmentsWidget
  RxInt activeAppointmentId = 0.obs; // 🔥 Tracks currently viewing appointment for Socket
  RxBool isMyAppointmentsLoading = false.obs;
  Timer? _tokenTimer;
  TextEditingController searchController = TextEditingController();
  CarouselSliderController carouselController = CarouselSliderController();
  RxDouble currentCarouselPos = 0.0.obs;
  RxString doctorStatus = "".obs; // 'stopped', 'started', 'paused', 'not started'
  RxString doctorReason = "".obs;
  // Pusher
  PusherClient? _pusherClient;
  Channel? _pusherChannel;
  bool _isFetchingFallback = false; // Prevent multiple fallback calls

  RxBool _isRefreshing = false.obs;

  // Search Enhancements
  late stt.SpeechToText _speech;
  RxBool isListening = false.obs;
  RxDouble soundLevel = 0.0.obs;
  RxString voicePreviewText = "".obs;

  // Rotating Hint
  RxString currentHint = "Search Doctor...".obs;
  int _hintIndex = 0;
  Timer? _hintTimer;
  final List<String> _hints = [
    "Search Doctor...",
    "Search 'Cardiologist'",
    "Search 'Dr. John'",
    "Search 'Fever'",
    "Search 'Dentist'",
  ];

  RxInt cartCount = 2.obs; // Mock cart count

  String get greeting {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  // @override
  // void onInit() {
  //
  //   super.onInit();
  //   getDoctors();
  //   getAllDoctors();
  //   _initializeTokens();
  //   _startTokenPolling();
  //   _startTokenPolling();
  //   getBanners();
  //   getDiseases();
  //   _initPusher();
  //
  //   // Search Init
  //   _speech = stt.SpeechToText();
  //   _startRotatingHints();
  //
  //   // Set initial position if needed based on "mine"
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     int myIndex = tokens.indexWhere((t) => t.isMine);
  //     if (myIndex != -1) currentCarouselPos.value = myIndex.toDouble();
  //   });
  // }
  @override
  void onInit() {
    super.onInit();
    // Fetch initial data if token is already present
    if (PreferenceUtils.getStringValue("token").isNotEmpty) {
      refreshData();
    }
    _initPusher();

    // Search Init
    _speech = stt.SpeechToText();
    _startRotatingHints();

    // Set initial position if needed based on "mine"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int myIndex = tokens.indexWhere((t) => t.isMine);
      if (myIndex != -1) currentCarouselPos.value = myIndex.toDouble();
    });
  }

  // @override
  // void onClose() {
  //   _tokenTimer?.cancel();
  //   _hintTimer?.cancel();
  //   super.onClose();
  // }
  void onTabSelected() {
    refreshData();
  }

  @override
  void onReady() {
    super.onReady();

    refreshData(); // 🔥 Reload APIs every time you return
  }

  @override
  void onClose() {
    // 🔥 ADDED THIS: Kill the socket connection when you leave the page!
    // This stops ghost connections from stealing your data.
    // _pusherClient?.disconnect();

    _tokenTimer?.cancel();
    _hintTimer?.cancel();
    _audioRecorder.dispose(); // 🔥 ADDED: Clean up recorder
    super.onClose();
  }
// / Tokens are handled by polling, but we can force one update
//     _initializeTokens();

//     // 🔥 Disconnect and reconnect Pusher on refresh
//     if (_pusherClient != null) {
//       debugPrint("Pusher: Disconnecting for refresh...");
//       _pusherClient!.disconnect();
//       _pusherClient = null;
//     }
//     _initPusher();

//     // 🔥 FIX: Use the actively selected appointment, or fallback to the first one!
//     int? targetApptId = activeAppointmentId.value != 0
//         ? activeAppointmentId.value
//         : myAppointments.firstOrNull?.id;

//     if (targetApptId != null) {
//       StringUtils.client
//           .broadcastTodayAppointment(
//         PreferenceUtils.getStringValue("token"),
//         {"appointment_id": targetApptId},
//       )
//           .then((response) {
//         if (response != null && response['success'] == true && response['data'] != null) {
//            _handleTokenUpdate(response['data']);
//         }
//       })
//           .catchError((error) {
//         if (error is dio.DioException && error.response?.statusCode == 404) {
//           // This is expected if the patient has no appointment today
//           debugPrint("Pusher: No appointment today for this patient (404 expected)");
//         } else {
//           debugPrint("Pusher: Broadcast API error in refreshData: $error");
//           fetchTodayAppointment(); // Fallback if broadcast fails
//         }
//       });
//     }
  Future<void> refreshData() async {
    if (_isRefreshing.value) return;
    _isRefreshing.value = true;

    isDoctorsLoading = true;
    isAllDoctorsLoading.value = true;
    isDiseasesLoading.value = true;
    isBannersLoading.value = true;
    update();

    List<Future> futures = [
      getDoctors(),
      getAllDoctors(),
      getBanners(),
      getDiseases(),
      getFollowUps(),
      fetchMyAppointments(),
    ];

    // Also refresh MedicineController if it exists
    if (Get.isRegistered<MedicineController>()) {
      final medController = Get.find<MedicineController>();
      futures.add(medController.fetchMedicines());
      futures.add(medController.fetchCategories());
    }

    if (!Get.isRegistered<NewslettersController>()) {
      Get.put(NewslettersController());
    }
    final newsController = Get.find<NewslettersController>();
    futures.add(newsController.fetchCategories());

    await Future.wait(futures);

    _isRefreshing.value = false;
    update();

    
  }

  void _startRotatingHints() {
    _hintTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _hintIndex = (_hintIndex + 1) % _hints.length;
      currentHint.value = _hints[_hintIndex];
    });
  }

  void updateSearchText(String text) {
    searchController.text = text;
    update(); // Update UI if needed
  }

  void startListening() async {
    if (!isListening.value) {
      var status = await Permission.microphone.status;
      if (status.isDenied) {
        status = await Permission.microphone.request();
      }

      if (status.isRestricted || status.isPermanentlyDenied) {
        DisplaySnackBar.displaySnackBar(
            "Please enable microphone access in settings to use voice search.",
            3,
            ColorConst.redColor);
        return;
      }

      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('onStatus: $status'),
        onError: (errorNotification) =>
            debugPrint('onError: $errorNotification'),
      );
      if (available) {
        isListening.value = true;
        soundLevel.value = 0.0;
        voicePreviewText.value = "";
        _speech.listen(
          onSoundLevelChange: (level) {
            soundLevel.value = level;
          },
          onResult: (result) {
            voicePreviewText.value = result.recognizedWords;

            if (result.finalResult && result.recognizedWords.isNotEmpty) {
              String recognized = result.recognizedWords;

              if (Get.isBottomSheetOpen == true) {
                Get.back();
              }
              stopListening();

              // Direct search based on recognized words
              searchDoctors(query: recognized);
              Get.to(() => const SearchDoctorScreen());
            }
          },
        );
      }
    } else {
      stopListening();
    }
  }

  void stopListening() {
    isListening.value = false;
    soundLevel.value = 0.0;
    _speech.stop();
  }

  void _initializeTokens() {
    // Initialize 5 slots
    tokens.value = List.generate(5, (index) {
      return TokenModel(
        id: index,
        tokenNumber: index + 1,
        status: TokenStatus.empty,
        isMine: false,
      );
    });
  }

  void _startTokenPolling() {
    // Mock Polling - Simulate updates every 5 seconds
    _tokenTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _mockUpdateTokens();
    });
  }

  void _mockUpdateTokens() {
    if (!hasActiveToken.value) return; // Don't update slots if no booking

    final random = Random();
    List<TokenModel> newTokens = List.from(tokens);

    var myTokenIndex = newTokens.indexWhere((t) => t.isMine);

    if (myTokenIndex != -1) {
      // 🔥 DELETED carouselController.animateToPage HERE TO FIX THE CRASH!
    } else {
      int emptyIndex =
          newTokens.indexWhere((t) => t.status == TokenStatus.empty);
      if (emptyIndex != -1) {
        newTokens[emptyIndex].status = TokenStatus.waiting;
        newTokens[emptyIndex].isMine = true;
      }
    }

    // Random noise for other tokens
    int indexToChange = random.nextInt(5);
    if (!newTokens[indexToChange].isMine) {
      TokenStatus current = newTokens[indexToChange].status;
      TokenStatus next = current;
      switch (current) {
        case TokenStatus.empty:
          next = TokenStatus.waiting;
          break;

        case TokenStatus.waiting:
          next = TokenStatus.active;
          break;

        case TokenStatus.booked: // 🔥 ADD THIS
          next = TokenStatus.waiting; // or active based on your logic
          break;

        case TokenStatus.active:
          next = TokenStatus.completed;
          break;

        case TokenStatus.completed:
          next = TokenStatus.empty;
          break;
      }
      newTokens[indexToChange].status = next;
    }

    tokens.value = newTokens;
    update();
  }

  // Call this from UI to simulate Booking/Canceling
  void toggleBooking() {
    hasActiveToken.value = !hasActiveToken.value;
    if (hasActiveToken.value) {
      DisplaySnackBar.displaySnackBar(
          "You have booked a slot. Token assigned.", 3, ColorConst.primaryColor);
      _initializeTokens(); // Reset for fresh start
      // Assign specific token immediately
      var list = List<TokenModel>.from(tokens);
      list[0].status = TokenStatus.waiting;
      list[0].isMine = true; // Assign Token #1 to me
      tokens.value = list;
    } else {
      DisplaySnackBar.displaySnackBar(
          "Your appointment is cancelled.", 3, ColorConst.redColor);
      _initializeTokens(); // Reset to empty
    }
    update();
  }

  Future<void> getDoctors() async {
    isDoctorsLoading = true;
    update();
    StringUtils.client
        .getDoctorDepartment(PreferenceUtils.getStringValue("token"))
      ..then((value) {
        doctorDepartmentModel = value;
        if (value.success == true &&
            value.data != null &&
            value.data!.isNotEmpty) {
          // Fetch doctors for the first department as default
          // Use search init or keep as is? getDoctorsByDepartmentId now returns different model.
          // The Home Page usage of getDoctorModel needs update if we use this method.
          // BUT getDoctorsByDepartmentId is MAINLY used for the "View All" or specific department screen.
          // The Home Page usually displays a horizontal list.
          // Let's comment this out or update if `getDoctorModel` type is changed.
          // Since getDoctorModel is GetDoctorModel type, we can't assign DoctorListModel result.
          // We should update getDoctorModel type too?
          // fetchDoctorsByDepartment(value.data![0].id!);
          isDoctorsLoading = false;
          update();
        } else {
          isDoctorsLoading = false;
          update();
        }
      })
      ..onError((dio.DioException error, stackTrace) {
        isDoctorsLoading = false;
        update();
        CheckSocketException.checkSocketException(error);
        return DoctorDepartmentModel();
      });
  }

  Future<GetDoctorModel> getDoctorsByDepartmentId(int departmentId) {
    return StringUtils.client
        .getDoctor(PreferenceUtils.getStringValue("token"), departmentId);
  }

  Future<DoctorListModel> getDoctorsByDepartmentIdRich(int departmentId) async {
    try {
      final response = await StringUtils.dio.get(
        "${StringUtils.domainUrl}api/doctor-search",
        queryParameters: {
          'department_id': departmentId,
        },
        options: dio.Options(headers: {
          'Authorization': PreferenceUtils.getStringValue("token"),
          'X-HOSPITAL': ConfigUtils.hospitalSku,
        }),
      );
      return DoctorListModel.fromJson(response.data);
    } catch (e) {
      if (e is dio.DioException) {
        CheckSocketException.checkSocketException(e);
      }
      return DoctorListModel(success: false, message: e.toString());
    }
  }

  Future<DoctorListModel> getDoctorsBySpecialist(String specialist) {
    return StringUtils.client.searchDoctors(
      PreferenceUtils.getStringValue("token"),
      ConfigUtils.hospitalSku,
      null, // gender
      null, // minPrice
      null, // maxPrice
      specialist, // specialist
      null, // sort
      null, // search
    );
  }

  void fetchDoctorsByDepartment(int departmentId) {
    // Keep existing method for home page if needed, or refactor to use above
    getDoctorsByDepartmentId(departmentId).then((value) {
      getDoctorModel = value;
      isDoctorsLoading = false;
      update();
    }).onError((dio.DioException error, stackTrace) {
      isDoctorsLoading = false;
      update();
      CheckSocketException.checkSocketException(error);
    });
  }

  Future<void> getBanners() async {
    isBannersLoading.value = true;
    StringUtils.client
        .getBanners(PreferenceUtils.getStringValue("token"))
        .then((value) {
      if (value.success == true && value.data != null) {
        banners.value = value.data!;
      }
      isBannersLoading.value = false;
    }).catchError((error) {
      debugPrint("Banner Error: $error");
      isBannersLoading.value = false;
    });
  }

  Future<void> getDiseases() async {
    isDiseasesLoading.value = true;
    StringUtils.client
        .getDiseases(PreferenceUtils.getStringValue("token"))
        .then((value) {
      if (value.success == true && value.data != null) {
        diseases.value = value.data!;
      }
      isDiseasesLoading.value = false;
    }).catchError((error) {
      debugPrint("Disease Error: $error");
      isDiseasesLoading.value = false;
    });
  }

  Future<void> getFollowUps() async {
    isFollowUpsLoading.value = true;
    update();
    StringUtils.client
        .getAppointmentFollowUps(PreferenceUtils.getStringValue("token"))
        .then((value) {
      if (value.success == true && value.data != null) {
        followUps.value = value.data!;
      }
      isFollowUpsLoading.value = false;
      update();
    }).catchError((error) {
      debugPrint("Follow-up Error: $error");
      isFollowUpsLoading.value = false;
      update();
    });
  }

  Future<FollowUpData?> getFollowUpDetail(int id) async {
    try {
      final response = await StringUtils.client
          .getFollowUpDetail(PreferenceUtils.getStringValue("token"), id);
      if (response.success == true && response.data != null) {
        return response.data;
      }
    } catch (e) {
      debugPrint("Follow-up Detail Error: $e");
    }
    return null;
  }

  void showFollowUpDetailById(int id) async {
    // Show loading if needed, or just fetch since it's fast
    final detail = await getFollowUpDetail(id);
    if (detail != null) {
      Get.bottomSheet(
        FollowUpDetailBottomSheet(data: detail),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
      );
    } else {
      DisplaySnackBar.displaySnackBar(
        "Could not fetch follow-up details. Please try again.",
        3,
        ColorConst.redColor,
      );
    }
  }

  // Search
  Rx<DoctorListModel?> searchResults = Rx<DoctorListModel?>(null);
  RxBool isSearching = false.obs;

  // Filter State
  String? currentGender;
  double? currentMinPrice;
  double? currentMaxPrice;
  int? currentDepartmentId;
  String? currentSort;

  Future<void> getAllDoctors() async {
    isAllDoctorsLoading.value = true;
    StringUtils.client
        .searchDoctors(PreferenceUtils.getStringValue("token"),
            ConfigUtils.hospitalSku, null, null, null, null, null, null)
        .then((value) {
      if (value.success == true && value.data != null) {
        allDoctors.value = value.data!;
      }
      isAllDoctorsLoading.value = false;
    }).catchError((error) {
      debugPrint("All Doctors Error: $error");
      isAllDoctorsLoading.value = false;
    });
  }

  void searchDoctors({
    String? query,
    String? gender,
    dynamic minPrice,
    dynamic maxPrice,
    int? departmentId,
    String? sort,
  }) async {
    isSearching.value = true;
    update();

    // If query is empty, reset search results (unless filtering by other means, but user request implies reset)
    if ((query == null || query.trim().isEmpty) &&
        gender == null &&
        minPrice == null &&
        maxPrice == null &&
        departmentId == null &&
        sort == null) {
      searchResults.value = null;
      isSearching.value = false;
      update();
      return;
    }

    // Update current filter state if provided
    if (gender != null) currentGender = gender;
    if (minPrice != null) currentMinPrice = (minPrice as num).toDouble();
    if (maxPrice != null) currentMaxPrice = (maxPrice as num).toDouble();
    if (departmentId != null) currentDepartmentId = departmentId;
    if (sort != null) currentSort = sort;

    // Mapping Gender to Backend values (Male=0, Female=1)
    String? genderValue;
    if (currentGender == "Male") {
      genderValue = "0";
    } else if (currentGender == "Female") {
      genderValue = "1";
    }

    try {
      final response = await StringUtils.dio.get(
        "${StringUtils.domainUrl}api/doctor-search",
        queryParameters: {
          if (query != null && query.isNotEmpty) 'search': query,
          if (genderValue != null) 'gender': genderValue,
          if (currentMinPrice != null) 'min_price': currentMinPrice!.round(),
          if (currentMaxPrice != null) 'max_price': currentMaxPrice!.round(),
          if (currentDepartmentId != null) 'department_id': currentDepartmentId,
          if (currentSort != null) 'sort': currentSort,
        },
        options: dio.Options(headers: {
          'Authorization': PreferenceUtils.getStringValue("token"),
          'X-HOSPITAL': ConfigUtils.hospitalSku,
        }),
      );

      if (response.statusCode == 200) {
        searchResults.value = DoctorListModel.fromJson(response.data);
      } else {
        searchResults.value =
            DoctorListModel(success: false, message: "Search failed");
      }
    } catch (e) {
      if (e is dio.DioException) {
        CheckSocketException.checkSocketException(e);
      }
      debugPrint("Search Error: $e");
      searchResults.value =
          DoctorListModel(success: false, message: e.toString());
    } finally {
      isSearching.value = false;
      update();
    }
  }

  void _initPusher() async {
    if (_pusherClient != null &&
        _pusherClient!.connectionState == 'CONNECTED') {
      debugPrint("Pusher: Already connected. Skipping init.");
      return;
    }

    final String id = VariableUtils.userId.value.isNotEmpty
        ? VariableUtils.userId.value
        : PreferenceUtils.getStringValue("id");

    debugPrint("Pusher: Initializing for user ID: $id");
    debugPrint(
        "Pusher: Initializing for user ID: ${PreferenceUtils.getStringValue("token")}");
    final options = PusherOptions(
      key: 'local',
      host: ConfigUtils.pusherHost,
      wssPort: 443,
      encrypted: true,
      authOptions: PusherAuthOptions(
        "${StringUtils.domainUrl}api/broadcasting/auth",
        headers: () async {
          final token = PreferenceUtils.getStringValue("token");
          return {
            "Accept": "application/json",
            // 🔥 PUT THE  TOKEN BACK SO LARAVEL LETS YOU IN!
            "Authorization": "$token",
          };
        },
      ),
      autoConnect: false,
      enableLogging: true,
      activityTimeout: 30000,
      pongTimeout: 10000,
      maxReconnectionAttempts: 10,
      reconnectGap: const Duration(seconds: 3),
    );
    _pusherClient = PusherClient(options: options);

    _pusherClient!.onConnectionEstablished((data) {
      debugPrint(
          "Pusher: Connection established - socket-id: ${_pusherClient!.socketId}");
      _subscribeToChannel(id);
    });

    _pusherClient!.onConnectionError((error) {
      debugPrint("Pusher: Connection error - $error");
      fetchTodayAppointment(); // Fallback if connection fails
    });

    _pusherClient!.onError((error) {
      debugPrint("Pusher: Error - $error");
      fetchTodayAppointment(); // Fallback on general error
    });

    _pusherClient!.onDisconnected((data) {
      debugPrint("Pusher: Disconnected - $data");
       fetchTodayAppointment();
    });

    _pusherClient!.connect();
  }

  // void _subscribeToChannel(String patientId) {
  //   if (_pusherClient == null) return;
  //
  //   final channelName = 'private-patient.$patientId';
  //   debugPrint("Pusher: Subscribing to $channelName");
  //
  //   _pusherChannel = _pusherClient!.privateChannel(channelName);
  //
  //   _pusherChannel!.bind('.appointment.updated', (data) {
  //     debugPrint('Pusher: appointment.updated received - $data');
  //     _handleTokenUpdate(data);
  //   });
  // }
  // void _subscribeToChannel(String patientId) {
  //   if (_pusherClient == null) return;
  //
  //   final channelName = 'private-patient.$patientId';
  //   debugPrint("Pusher: Subscribing to $channelName");
  //
  //   // 🔥 THIS IS THE MAGIC WORD: subscribe() instead of channel()
  //   _pusherChannel = _pusherClient!.subscribe(channelName);
  //
  //   // 🔥 1. Check if Private Auth Succeeded or Failed
  //   _pusherChannel!.bind('pusher:subscription_succeeded', (data) {
  //     debugPrint('✅ PUSHER: SUBSCRIPTION SUCCEEDED for $channelName');
  //   });
  //
  //   _pusherChannel!.bind('pusher:subscription_error', (data) {
  //     debugPrint('❌ PUSHER: SUBSCRIPTION ERROR: $data');
  //   });
  //
  //   // 🔥 2. Try the 3 possible event names Laravel might be sending
  //
  //   // Option A: Standard broadcastAs()
  //   _pusherChannel!.bind('appointment.updated', (data) {
  //     debugPrint('🔥 EVENT [appointment.updated] RECEIVED: $data');
  //     _handleTokenUpdate(data);
  //   });
  //
  //   // Option B: Echo dot prefix
  //   _pusherChannel!.bind('.appointment.updated', (data) {
  //     debugPrint('🔥 EVENT [.appointment.updated] RECEIVED: $data');
  //     _handleTokenUpdate(data);
  //   });
  //
  //   // Option C: Laravel default class namespace
  //   _pusherChannel!.bind('App\\Events\\AppointmentUpdated', (data) {
  //     debugPrint('🔥 EVENT [App\\Events\\AppointmentUpdated] RECEIVED: $data');
  //     _handleTokenUpdate(data);
  //   });
  // }
  void _subscribeToChannel(String patientId) {
    if (_pusherClient == null) return;

    final channelName = 'private-patient.$patientId';
    debugPrint("Pusher: Subscribing to $channelName");

    _pusherChannel = _pusherClient!.subscribe(channelName);

    _pusherChannel!.bind('pusher:subscription_succeeded', (data) {
      debugPrint('✅ PUSHER: SUBSCRIPTION SUCCEEDED for $channelName');

      // 🔥 FIX: Instead of broadcasting (which needs an ID), just fetch the latest data
      fetchTodayAppointment();
    });

    _pusherChannel!.bind('pusher:subscription_error', (data) {
      debugPrint('❌ PUSHER: SUBSCRIPTION ERROR: $data');
      fetchTodayAppointment(); // Fallback if subscription fails
    });

    _pusherChannel!.bind('appointment.updated', (data) {
      debugPrint('🔥 EVENT [appointment.updated] RECEIVED: $data');
      _handleTokenUpdate(data);
    });

    _pusherChannel!.bind('.appointment.updated', (data) {
      debugPrint('🔥 EVENT [.appointment.updated] RECEIVED: $data');
      _handleTokenUpdate(data);
    });

    _pusherChannel!.bind('App\\Events\\AppointmentUpdated', (data) {
      debugPrint('🔥 EVENT [App\\Events\\AppointmentUpdated] RECEIVED: $data');
      _handleTokenUpdate(data);
    });
  }

  // void _handleTokenUpdate(dynamic data) {
  //   try {
  //     debugPrint("RAW PUSHER DATA: $data");
  //
  //     if (data == null) return;
  //
  //     Map<String, dynamic> decoded;
  //
  //     // 🔥 Handle both String and already-parsed Map cases correctly
  //     if (data is String) {
  //       decoded = jsonDecode(data);
  //     } else if (data is Map) {
  //       decoded = Map<String, dynamic>.from(data);
  //     } else {
  //       debugPrint("❌ Unknown data type: ${data.runtimeType}");
  //       return;
  //     }
  //
  //     final appointment = decoded['appointment'];
  //     final tokensFromServer = decoded['tokens'];
  //
  //     if (appointment != null && tokensFromServer != null) {
  //       final int? tokenNumber =
  //       int.tryParse(appointment['token_number']?.toString() ?? '');
  //
  //       if (tokenNumber != null) {
  //         hasActiveToken.value = true;
  //         _updateTokensFromServer(tokenNumber, tokensFromServer);
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("❌ Error parsing socket data: $e");
  //   }
  // }

  void _handleTokenUpdate(dynamic data) {
    try {
      if (data == null) return;

      Map<String, dynamic> decoded;
      if (data is String) {
        decoded = jsonDecode(data);
      } else if (data is Map) {
        decoded = Map<String, dynamic>.from(data);
      } else {
        return;
      }

      final tokensPayload = decoded['tokens'];
      final appointmentInfo = decoded['appointment'];

      int incomingId = int.tryParse(
          appointmentInfo?['appointment_id']?.toString() ?? 
          appointmentInfo?['id']?.toString() ?? ''
      ) ?? 0;

      // 🔥 C. Improved ID Matching: Handle 1000000+ prefix variations (e.g., 2315 matches 1002315)
      bool isMatch = (incomingId == activeAppointmentId.value);
      if (!isMatch && incomingId != 0 && activeAppointmentId.value != 0) {
         if (incomingId % 1000000 == activeAppointmentId.value % 1000000) {
            isMatch = true;
         }
      }

      // 1. GLOBAL COMPLETION CHECK: If any of my appointments finish, refresh the list!
      if (tokensPayload != null && appointmentInfo != null) {
        int myTokenNum = int.tryParse(appointmentInfo['token_number']?.toString() ?? '') ?? 0;
        bool isCompleted = false;

        if (tokensPayload is Map && tokensPayload['bookingSlotArr'] is List) {
          final mySlot = (tokensPayload['bookingSlotArr'] as List).firstWhereOrNull((t) {
             int tNum = int.tryParse(t['token_number']?.toString() ?? '') ?? 0;
             return tNum != 0 && tNum == myTokenNum;
          });
          if (mySlot != null) {
            String status = mySlot['status']?.toString().toLowerCase() ?? "";
            if (status == "completed" || status == "checked_out" || status == "checked out") {
               isCompleted = true;
            }
          }
        }

        if (isCompleted) {
          debugPrint("✅ Appointment $incomingId is completed/checked out. Refreshing list...");
          if (incomingId == activeAppointmentId.value) {
            activeAppointmentId.value = 0;
            PreferenceUtils.setStringValue("active_appointment_id", "");
            hasActiveToken.value = false;
            tokens.clear();
          }
          fetchMyAppointments();
          return; // Stop processing further for a completed appointment
        }
      }

      // 2. GUARD: Only process UI updates for the currently watched appointment
      if (incomingId != 0 && activeAppointmentId.value != 0 && !isMatch) {
        debugPrint("Pusher: Ignoring update for appointment ID $incomingId (Active: ${activeAppointmentId.value})");
        return;
      }

      if (tokensPayload != null) {
        // 🔥 D. Hiding if no data: Only show the widget if there are tokens or a valid doctor state
        bool hasData = false;
        if (tokensPayload is List && tokensPayload.isNotEmpty) hasData = true;
        if (tokensPayload is Map && (tokensPayload['bookingSlotArr'] as List?)?.isNotEmpty == true) hasData = true;

        if (!hasData) {
           debugPrint("Pusher: Received empty tokens payload. Hiding widget.");
           hasActiveToken.value = false;
           return;
        }

        hasActiveToken.value = true;

        List<dynamic> tokenList = [];

        if (tokensPayload is Map) {
          // New structure: {"bookingSlotArr": [...], "doctor_state": {...}}
          tokenList = tokensPayload['bookingSlotArr'] is List
              ? tokensPayload['bookingSlotArr']
              : [];

          final doctorState = tokensPayload['doctor_state'];
          if (doctorState != null && doctorState is Map) {
            // Normalize: 'not_started' -> 'not started'
            doctorStatus.value = (doctorState['status']?.toString() ?? "")
                .replaceAll('_', ' ');
            doctorReason.value = doctorState['reason']?.toString() ?? "";
          }
        } else if (tokensPayload is List) {
          // Fallback for old list-based structure
          final stateItem = tokensPayload.firstWhere(
            (element) => element is Map && element.containsKey('doctor_state'),
            orElse: () => null,
          );

          if (stateItem != null) {
            final doctorState = stateItem['doctor_state'];
            doctorStatus.value = (doctorState['status']?.toString() ?? "")
                .replaceAll('_', ' ');
            doctorReason.value = doctorState['reason']?.toString() ?? "";
          } else {
            doctorStatus.value = "started";
          }

          tokenList = tokensPayload
              .where((e) => e is Map && !e.containsKey('doctor_state'))
              .toList();
        }

        _updateTokensFromServer(tokenList, myAppointment: appointmentInfo);
      }
    } catch (e) {
      debugPrint("❌ Error parsing doctor state: $e");
    }
  }

  // Future<void> fetchMyAppointments() async {
  //   try {
  //     isMyAppointmentsLoading.value = true;
  //     final response = await StringUtils.client.getMyAppointments(
  //       PreferenceUtils.getStringValue("token"),
  //     );
  //     if (response.success == true) {
  //       myAppointments.assignAll(response.data ?? []);
  //       // For now, treat all fetched upcoming appointments as 'today' for the switcher
  //       todayAppointments.assignAll(myAppointments);
  //
  //       // Auto-select the first one if nothing is tracked yet
  //       if (activeAppointmentId.value == 0 && todayAppointments.isNotEmpty) {
  //         activeAppointmentId.value = todayAppointments.first.id ?? 0;
  //         // Trigger broadcast for the first one to start socket updates
  //         broadcastAppointment(activeAppointmentId.value);
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("❌ Error fetching my appointments: $e");
  //   } finally {
  //     isMyAppointmentsLoading.value = false;
  //   }
  // }
  //
  Future<void> fetchMyAppointments() async {
    try {
      isMyAppointmentsLoading.value = true;
      final response = await StringUtils.client.getMyAppointments(
        PreferenceUtils.getStringValue("token"),
      );

      if (response.success == true) {
        final fetchedList = response.data ?? [];

        myAppointments.assignAll(fetchedList);
        todayAppointments.assignAll(fetchedList);

        // 🔥 Persistence: Check stored ID if current is 0
        if (activeAppointmentId.value == 0) {
          String storedId = PreferenceUtils.getStringValue("active_appointment_id");
          if (storedId.isNotEmpty) {
            activeAppointmentId.value = int.tryParse(storedId) ?? 0;
          }
        }

        if (todayAppointments.isNotEmpty) {
          // 2. Check if the currently active appointment STILL exists in the new refreshed list
          bool exists = todayAppointments.any((appt) => appt.id == activeAppointmentId.value);

          // 3. If we don't have an active appointment OR the active one disappeared (e.g. completed)
          if (activeAppointmentId.value == 0 || !exists) {
            activeAppointmentId.value = todayAppointments.first.id ?? 0;
            PreferenceUtils.setStringValue("active_appointment_id", activeAppointmentId.value.toString());
          }

          // 🔥 ALWAYS broadcast on start/refresh to ensure the backend is synced for this session
          if (activeAppointmentId.value != 0) {
            broadcastAppointment(activeAppointmentId.value);
          }
        } else {
          // List is empty
          activeAppointmentId.value = 0;
        }
      }
    } catch (e) {
      if (e is dio.DioException && e.response?.statusCode == 404) {
        debugPrint("API: No upcoming appointments found (404). Clearing lists.");
        myAppointments.clear();
        todayAppointments.clear();
        activeAppointmentId.value = 0;
        PreferenceUtils.setStringValue("active_appointment_id", "");
        hasActiveToken.value = false;
        tokens.clear();
      } else {
        debugPrint("❌ Error fetching my appointments: $e");
      }
    } finally {
      isMyAppointmentsLoading.value = false;
    }
  }


  void selectAndBroadcastAppointment(int? id) {
    if (id == null || id == 0) return;
    debugPrint("🔄 Switching active appointment to: $id");
    activeAppointmentId.value = id;
    
    // 🔥 Save selection to survive refreshes/navigation
    PreferenceUtils.setStringValue("active_appointment_id", id.toString());
    
    broadcastAppointment(id);
    // After broadcasting, the socket will start sending updates for this new ID
  }

  Future<void> broadcastAppointment(int appointmentId) async {
    try {
      final response = await StringUtils.client.broadcastTodayAppointment(
        PreferenceUtils.getStringValue("token"),
        {"appointment_id": appointmentId},
      );
      
      if (response != null && response['success'] == true && response['data'] != null) {
        debugPrint("Pusher: Broadcast data received. Updating UI immediately.");
        _handleTokenUpdate(response['data']);
      }
    } catch (e) {
      debugPrint("❌ Error broadcasting appointment: $e");
    }
  }
  // void _handleTokenUpdate(dynamic data) {
  //   try {
  //     debugPrint("RAW PUSHER DATA: $data");
  //
  //     if (data == null) return;
  //
  //     Map<String, dynamic> decoded;
  //
  //     if (data is String) {
  //       decoded = jsonDecode(data);
  //     } else if (data is Map) {
  //       decoded = Map<String, dynamic>.from(data);
  //     } else {
  //       debugPrint("❌ Unknown data type: ${data.runtimeType}");
  //       return;
  //     }
  //
  //     final tokensFromServer = decoded['tokens'];
  //     final type = decoded['type'];
  //
  //     if (tokensFromServer != null) {
  //       hasActiveToken.value = true;
  //
  //       if (type == "time_based") {
  //         _updateTimeBasedTokens(tokensFromServer);
  //       } else {
  //         _updateTokensFromServer(tokensFromServer);
  //       }
  //     }
  //   } catch (e) {
  //     debugPrint("❌ Error parsing socket data: $e");
  //   }
  // }

  void _updateTimeBasedTokens(List<dynamic> serverTokens) {
    List<TokenModel> updated = [];

    for (int i = 0; i < serverTokens.length; i++) {
      final token = serverTokens[i];

      String backendStatus = token['status'].toString();

      TokenStatus status;
      bool isMine = false;

      if (backendStatus == "Available") {
        status = TokenStatus.empty;
      } else if (backendStatus == "Your Time") {
        status = TokenStatus.waiting;
        isMine = true;
      } else if (backendStatus == "Booked" || backendStatus == "Confirmed") {
        status = TokenStatus.waiting;
      } else if (backendStatus == "Checked In") {
        status = TokenStatus.active;
      } else if (backendStatus == "Completed") {
        status = TokenStatus.completed;
      } else {
        status = TokenStatus.empty;
      }

      updated.add(
        TokenModel(
          id: i,
          tokenNumber: i + 1,
          status: status,
          isMine: isMine,
          startTime: token['time'],
          endTime: token['end_time'],
          label: token['label'],
        ),
      );
    }

    tokens.assignAll(updated);
  }

  // void _handleTokenUpdate(dynamic data) {
  //   try {
  //     debugPrint("RAW PUSHER DATA: $data");
  //
  //     if (data == null) return;
  //
  //     Map<String, dynamic> decoded;
  //
  //     if (data is String) {
  //       decoded = jsonDecode(data);
  //     } else if (data is Map) {
  //       decoded = Map<String, dynamic>.from(data);
  //     } else {
  //       debugPrint("❌ Unknown data type: ${data.runtimeType}");
  //       return;
  //     }
  //
  //     final tokensFromServer = decoded['tokens'];
  //
  //     if (tokensFromServer != null) {
  //       hasActiveToken.value = true;
  //       _updateTokensFromServer(tokensFromServer);
  //     }
  //   } catch (e) {
  //     debugPrint("❌ Error parsing socket data: $e");
  //   }
  // }
  // void _updateTokensFromServer(List<dynamic> serverTokens) {
  //   List<TokenModel> updated = [];
  //
  //   for (int i = 0; i < serverTokens.length; i++) {
  //     final token = serverTokens[i];
  //
  //     String backendStatus = token['status'].toString();
  //     int tokenNumber = token['token_number'];
  //
  //     TokenStatus status;
  //     bool isMine = false;
  //
  //     if (backendStatus == "Available") {
  //       status = TokenStatus.empty;
  //     } else if (backendStatus == "Your Token") {
  //       status = TokenStatus.waiting;
  //       isMine = true; // 🔥 THIS IS THE REAL FIX
  //     } else if (backendStatus == "Checked In") {
  //       status = TokenStatus.active;
  //     } else if (backendStatus == "Confirmed" || backendStatus == "Booked") {
  //       status = TokenStatus.waiting;
  //     } else if (backendStatus == "Completed") {
  //       status = TokenStatus.completed;
  //     } else {
  //       status = TokenStatus.empty;
  //     }
  //
  //     updated.add(
  //       TokenModel(
  //         id: i,
  //         tokenNumber: tokenNumber,
  //         status: status,
  //         isMine: isMine,
  //       ),
  //     );
  //   }
  //
  //   tokens.assignAll(updated);
  // }
  // void _updateTokensFromServer(List<dynamic> serverTokens) {
  //   List<TokenModel> updated = [];
  //
  //   for (int i = 0; i < serverTokens.length; i++) {
  //     final token = serverTokens[i];
  //     String backendStatus = token['status'].toString();
  //     int tokenNumber = token['token_number'];
  //
  //     TokenStatus status;
  //     bool isMine = false;
  //
  //     if (backendStatus == "Available") {
  //       status = TokenStatus.empty;
  //     } else if (backendStatus == "Your Token") {
  //       status = TokenStatus.waiting;
  //       isMine = true;
  //     } else if (backendStatus == "Checked In") {
  //       status = TokenStatus.active;
  //     } else if (backendStatus == "Confirmed" || backendStatus == "Booked") {
  //       status = TokenStatus.waiting;
  //     } else if (backendStatus == "Completed") {
  //       status = TokenStatus.completed;
  //     } else {
  //       status = TokenStatus.empty;
  //     }
  //
  //     updated.add(
  //       TokenModel(
  //         id: i,
  //         tokenNumber: tokenNumber,
  //         status: status,
  //         isMine: isMine,
  //         // 🔥 CAPTURE THE TIMES HERE
  //         startTime: token['estimated_start_time'],
  //         endTime: token['estimated_end_time'],
  //       ),
  //     );
  //   }
  //   tokens.assignAll(updated);
  // }

  void _updateTokensFromServer(List<dynamic> serverTokens, {Map<String, dynamic>? myAppointment}) {
    List<TokenModel> updated = [];
    bool myTokenCompleted = false; // 🔥 Tracks if your token is done

    try {
      // 1. Reliably extract your exact token number from the appointment payload
      int myTokenNum = 0;
      if (myAppointment != null) {
        myTokenNum = int.tryParse(myAppointment['token_number']?.toString() ?? '') ?? 0;
      }

      for (int i = 0; i < serverTokens.length; i++) {
        final token = serverTokens[i];

        int tokenNumber = int.tryParse(token['token_number']?.toString() ?? '') ?? 0;
        String rawStatus = token['status']?.toString() ?? "Available";
        String normalizedStatus = rawStatus.toLowerCase().replaceAll('_', ' ').trim();

        TokenStatus status;

        // 2. Safely check if this specific token matches your token number
        bool isMine = (myTokenNum != 0 && tokenNumber == myTokenNum);

        bool isBookedFlag = token['isBooked'] == true;

        switch (normalizedStatus) {
          case "available":
          case "pending": // 🔥 Move 'pending' here so it becomes 'empty' and disappears from UI
            status = TokenStatus.empty;
            break;

          case "your token":
          case "your_token":
            status = TokenStatus.waiting;
            isMine = true;
            break;

          case "in queue":
          case "in oueue":
          case "waiting":
            status = TokenStatus.waiting;
            break;

          case "booked":
          case "confirmed":
            status = TokenStatus.booked;
            break;

          case "checked in":
          case "active":
            status = TokenStatus.active;
            break;

          case "completed":
          case "checked_out":
          case "checked out":
            status = TokenStatus.completed;
            break;

          default:
            status = isBookedFlag ? TokenStatus.booked : TokenStatus.empty;
        }
        // 🔥 3. Detect if YOUR token has been completed/checked out
        if (isMine && status == TokenStatus.completed) {
          myTokenCompleted = true;
        }

        updated.add(
          TokenModel(
            id: i,
            tokenNumber: tokenNumber,
            status: status,
            isMine: isMine,
            startTime: token['estimated_start_time']?.toString(),
            endTime: token['estimated_end_time']?.toString(),
            label: token['label']?.toString(),
          ),
        );
      }

      // 🔥 4. IF YOUR TOKEN IS COMPLETED: Hide the widget & fetch the next appointment!
      if (myTokenCompleted) {
        debugPrint("✅ My Appointment is Completed! Hiding token and refreshing list...");
        hasActiveToken.value = false;   // Hides the socket widget
        activeAppointmentId.value = 0;  // Resets the active appointment
        PreferenceUtils.setStringValue("active_appointment_id", ""); // Clear persistence
        tokens.clear();                 // Clears the token list
        update();

        fetchMyAppointments();          // Calls your API to get the latest appointments
        return;                         // Exit the function early
      }

      // 5. Injection logic for when the token isn't in the array yet
      if (myAppointment != null && myTokenNum != 0) {
        bool alreadyExists = updated.any((t) => t.tokenNumber == myTokenNum);
        if (!alreadyExists) {
          updated.add(
            TokenModel(
              id: updated.length,
              tokenNumber: myTokenNum,
              status: TokenStatus.waiting,
              isMine: true,
              startTime: myAppointment['opd_date'] != null
                  ? myAppointment['opd_date'].toString().substring(11, 16)
                  : null,
              label: myAppointment['token_label']?.toString(),
            ),
          );
          updated.sort((a, b) => a.tokenNumber.compareTo(b.tokenNumber));
        }
      }

      // Force update the UI
      tokens.assignAll(updated);
      update();

      // Fallback API Check
      bool foundMyToken = updated.any((t) => t.isMine);
      if (!foundMyToken && updated.isNotEmpty && !_isFetchingFallback) {
        debugPrint("Pusher: 'Your Token' not found. Triggering API fallback...");
        fetchTodayAppointment();
      }

    } catch (e) {
      debugPrint("❌ Error in _updateTokensFromServer loop: $e");
    }
  }
  Future<void> fetchTodayAppointment() async {
    if (_isFetchingFallback) return;
    
    final token = PreferenceUtils.getStringValue("token");
    if (token.isEmpty) return;

    _isFetchingFallback = true;
    debugPrint("API: Fetching today's appointment fallback...");

    try {
      final response = await StringUtils.client.getTodayAppointment(token);
      
      if (response != null && response['success'] == true && response['data'] != null) {
        debugPrint("API: Fallback data received successfully");
        _handleTokenUpdate(response['data']);

        // 🔥 Sync the active ID if none is selected yet
        if (activeAppointmentId.value == 0) {
          final payload = response['data']['payload'];
          if (payload != null && payload['appointment_id'] != null) {
            activeAppointmentId.value = payload['appointment_id'];
          }
        }
      } else {
        debugPrint("API: Fallback failed or no data: ${response?['message']}");
      }
    } catch (e) {
       if (e is dio.DioException && e.response?.statusCode == 404) {
         debugPrint("API: No appointment today for fallback (404 expected)");
       } else {
         debugPrint("API: Fallback error: $e");
       }
    } finally {
      // Small delay to prevent rapid-fire fallback calls if Pusher is fluttering
      await Future.delayed(const Duration(seconds: 5));
      _isFetchingFallback = false;
    }
  }
  // void _updateTokensFromServer(int myTokenNumber, List<dynamic> serverTokens) {
  //   List<TokenModel> updated = [];
  //   bool foundMyToken = false;
  //
  //   for (int i = 0; i < serverTokens.length; i++) {
  //     final token = serverTokens[i];
  //     TokenStatus status;
  //
  //     String backendStatus = token['status'].toString();
  //
  //     if (backendStatus == "Available") {
  //       status = TokenStatus.empty;
  //     }
  //
  //     else if (backendStatus == "Booked" || backendStatus == "Your Token" || backendStatus == "Confirmed") {
  //       status = TokenStatus.waiting;
  //     }
  //     else if (backendStatus == "Checked In" ) {
  //       // 🔥 THIS IS THE FIX
  //       status = TokenStatus.active;
  //     }
  //     else if (backendStatus == "Completed") {
  //       status = TokenStatus.completed;
  //     }
  //     else {
  //       status = TokenStatus.empty;
  //     }
  //
  //     bool isMine = token['token_number'] == myTokenNumber;
  //     if (isMine) foundMyToken = true;
  //
  //     updated.add(
  //       TokenModel(
  //         id: i,
  //         tokenNumber: token['token_number'],
  //         status: status,
  //         isMine: isMine,
  //       ),
  //     );
  //   }
  //
  //   // 🔥 FALLBACK: If your token (e.g. 46) wasn't in the 1-20 array, add it manually so it shows up!
  //   if (!foundMyToken) {
  //     updated.add(
  //       TokenModel(
  //         id: myTokenNumber,
  //         tokenNumber: myTokenNumber,
  //         status: TokenStatus.waiting,
  //         isMine: true,
  //       ),
  //     );
  //   }
  //
  //   // 🔥 VERY IMPORTANT: Use assignAll() to force the GetX Obx widget to rebuild!
  //   tokens.assignAll(updated);
  // }
  void _mockUpdateWithRealToken(int myTokenNumber, String doctorName) {
    List<TokenModel> newTokens = List.from(tokens);

    int myIndex = newTokens.indexWhere((t) => t.isMine);
    if (myIndex != -1) {
      newTokens[myIndex].tokenNumber = myTokenNumber;
    } else {
      int target = newTokens.indexWhere((t) => t.status == TokenStatus.empty);
      if (target == -1) target = 0;
      newTokens[target] = TokenModel(
        id: target,
        tokenNumber: myTokenNumber,
        status: TokenStatus.active,
        isMine: true,
      );
    }

    tokens.value = newTokens;
    update();
  }

  final AudioRecorder _audioRecorder = AudioRecorder();
  RxBool isSosRecording = false.obs;
  RxBool isSosPaused = false.obs;
  RxInt sosRecordingDuration = 0.obs;
  Timer? _sosTimer;
  String? _recordedAudioPath;
  Position? _sosPosition;
  RxBool hasRecordedAudio = false.obs;

  void goToSosScreen() async {
    // 1. Check Permissions
    var micStatus = await Permission.microphone.status;
    var locStatus = await Permission.location.status;

    if (!micStatus.isGranted || !locStatus.isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.microphone,
        Permission.location,
      ].request();

      if (statuses[Permission.microphone] ==
              PermissionStatus.permanentlyDenied ||
          statuses[Permission.location] == PermissionStatus.permanentlyDenied) {
        Get.snackbar(
          "Permissions Required",
          "Please enable Microphone and Location in app settings to use SOS.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () => openAppSettings(),
            child:
                const Text("Settings", style: TextStyle(color: Colors.white)),
          ),
        );
        return;
      }

      if (statuses[Permission.microphone] != PermissionStatus.granted ||
          statuses[Permission.location] != PermissionStatus.granted) {
        Get.snackbar(
          "Permissions Required",
          "Microphone and Location permissions are needed to use SOS.",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }
    }

    // Permissions granted, navigate to SOS screen
    // Reset states
    await stopSosRecording(); // 🔥 Ensure previous session is CLOSED
    isSosRecording.value = false;
    isSosPaused.value = false;
    sosRecordingDuration.value = 0;
    hasRecordedAudio.value = false;
    _recordedAudioPath = null;
    _sosPosition = null;

    Get.to(() => const SosScreen());
  }

  void startSosRecording() async {
    try {
      // 1. Immediately update UI state to provide instant feedback
      isSosRecording.value = true;
      isSosPaused.value = false;
      hasRecordedAudio.value = false;
      sosRecordingDuration.value = 0;

      _sosTimer?.cancel();
      _sosTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        sosRecordingDuration.value++;
      });

      // 2. Prepare recording path
      final Directory tempDir = await getTemporaryDirectory();
      _recordedAudioPath =
          '${tempDir.path}/sos_record_${DateTime.now().millisecondsSinceEpoch}.wav';

      // 3. Start recording immediately
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 16000, // 16kHz for smaller size (Mono)
          numChannels: 1,
        ),
        path: _recordedAudioPath!,
      );

      // 4. Fetch location in background so it's ready when sending
      // Don't 'await' it here to avoid stalling the start
      Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      ).then((position) {
        _sosPosition = position;
        debugPrint("SOS: Location fetched in background");
      }).catchError((e) {
        debugPrint("SOS Background Location Error: $e");
      });

    } catch (e) {
      isSosRecording.value = false;
      _sosTimer?.cancel();
      debugPrint("SOS Start Record Error: $e");
      Get.snackbar("Error", "Failed to start recording.",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<void> stopSosRecording() async {
    try {
      // Check both flag and internal state
      if (isSosRecording.value || await _audioRecorder.isRecording()) {
        final String? path = await _audioRecorder.stop();
        if (path != null) {
          _recordedAudioPath = path;
          hasRecordedAudio.value = true;
        }
      }
      isSosRecording.value = false;
      isSosPaused.value = false;
      _sosTimer?.cancel();
    } catch (e) {
      debugPrint("SOS Stop Record Error: $e");
      // Force flags to false even on error
      isSosRecording.value = false;
      isSosPaused.value = false;
      _sosTimer?.cancel();
    }
  }

  Future<void> pauseSosRecording() async {
    try {
      if (isSosRecording.value && !isSosPaused.value) {
        await _audioRecorder.pause();
        isSosPaused.value = true;
        _sosTimer?.cancel();
      }
    } catch (e) {
      debugPrint("SOS Pause Record Error: $e");
    }
  }

  Future<void> resumeSosRecording() async {
    try {
      if (isSosRecording.value && isSosPaused.value) {
        await _audioRecorder.resume();
        isSosPaused.value = false;
        _sosTimer?.cancel();
        _sosTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          sosRecordingDuration.value++;
        });
      }
    } catch (e) {
      debugPrint("SOS Resume Record Error: $e");
    }
  }

  Future<void> cancelSos() async {
    await stopSosRecording();
    // Delete file if exists
    if (_recordedAudioPath != null) {
      final file = File(_recordedAudioPath!);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
    // Get.back(); // close screen
  }

  Future<void> sendSosData() async {
    if (isSosRecording.value) {
      await stopSosRecording();
    }

    if (_recordedAudioPath == null || !File(_recordedAudioPath!).existsSync()) {
      Get.snackbar("Error", "No audio recorded to send.",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Show loading
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      if (_sosPosition == null) {
        _sosPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
      }

      dio.FormData formData = dio.FormData.fromMap({
        "latitude": _sosPosition!.latitude.toString(),
      "longitude": _sosPosition!.longitude.toString(),
      "status": "1",
      "voice_note": await dio.MultipartFile.fromFile(
        _recordedAudioPath!,
        filename: "voice_note.wav",
        contentType: MediaType("audio", "x-wav"), // Best for Laravel validation
      ),
    });

    final response = await StringUtils.dio.post(
      ConfigUtils.sosUrl,
      data: formData,
      options: dio.Options(
        sendTimeout: const Duration(seconds: 60), 
        receiveTimeout: const Duration(seconds: 60),
        headers: {
          "Accept": "application/json",
          "Content-Type": "multipart/form-data",
          "Authorization":
              " ${PreferenceUtils.getStringValue("token")}",
          // "X-HOSPITAL": ConfigUtils.hospitalSku,
        },
      ),
    );

      final value = EmergencyResponseModel.fromJson(response.data);

      // Close loading dialog safely
      Get.close(2);

      if (value.success == true) {
        Get.snackbar(
          "SOS Alert Sent",
          value.message ?? "Help is on the way. Ambulance requested.",
          backgroundColor: ColorConst.greenColor,
          colorText: Colors.white,
          duration: const Duration(seconds: 5),
        );
      } else {
        Get.snackbar(
          "SOS Failed",
          value.message ?? "Failed to send emergency request.",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      if (Get.isDialogOpen == true) Get.back(); // close loading
      debugPrint("SOS API Error: $error");
      if (error is dio.DioException) {
        CheckSocketException.checkSocketException(error);
      } else {
        Get.snackbar("Error", "Network error sending SOS.",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
}
