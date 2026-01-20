import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greenzone_medical/src/features/chats/presentation/model/chatcontact_model.dart';
import 'package:greenzone_medical/src/features/health_record/model/health_record_model.dart';
import 'package:greenzone_medical/src/features/prescription/models/get_prescriptions_model.dart';
import 'package:greenzone_medical/src/model/all_alergy_response.dart';
import 'package:greenzone_medical/src/model/category_model.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';
import 'package:greenzone_medical/src/model/contact_model.dart';
import 'package:greenzone_medical/src/model/doctord_list_response.dart';
import 'package:greenzone_medical/src/model/nationality_model.dart';
import 'package:greenzone_medical/src/model/user_model.dart';

import '../app_pkg.dart';
import '../features/account/model/referral_list.dart';
import '../features/appointment/model/appointment_model.dart';
import '../features/appointment/model/doctors_rating.dart';
import '../features/biling/model/billing_response.dart';
import '../features/caregivers/presentation/model/care_giver_response.dart';
import '../features/chats/StateNotifier/chat_pagination_notifier.dart';
import '../features/chats/presentation/model/conversation_mode.dart';
import '../features/chats/presentation/model/unread_chat_model.dart';
import '../features/community/model/all_friends.dart';
import '../features/community/model/receiver_community_model.dart';
import '../features/community/post/model/all_post_model.dart';
import '../features/community/post/model/post_query_params.dart';
import '../features/health_record/model/hmo_model.dart';
import '../features/home/model/all_interest_model.dart';
import '../features/home/model/friend_request_receiver.dart';
import '../features/home/model/friend_request_sender.dart';
import '../features/home/model/patient_by_id.dart';
import '../features/notifications/model/notification_model.dart';
import '../features/prescription/models/media_post_model.dart';
import '../features/prescription/models/prescription_model.dart';
import '../model/article_response.dart';
import '../model/banner_response.dart';
import '../services/all_service.dart';
import '../services/cloud_translate_service.dart';

// Provider for ArticleService
final isLoadingProvider = StateProvider<bool>((ref) => false);
final isAgreedProvider = StateProvider<bool>((ref) => false);
final languageProvider = StateProvider<String>((ref) => "en");

final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageServiceImpl();
});

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final allServiceProvider = Provider<AllService>((ref) {
  final storageService = ref.watch(storageServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return AllService(apiService, storageService);
});

// FutureProvider for fetching articles

final articleProvider =
    FutureProvider.autoDispose<List<ArticleResponse>>((ref) async {
  final articleService = ref.watch(allServiceProvider);
  return await articleService.fetchArticles();
});
final bannerProvider = FutureProvider<List<BannerResponse>>((ref) async {
  final bannerService = ref.watch(allServiceProvider);
  return await bannerService.fetchBanners();
});
// final stateListProvider = FutureProvider<List<StateData>>((ref) async {
//   final stateListService = ref.watch(authServiceProvider);
//   return await stateListService.fetchState();
// });
final nationalityListProvider =
    FutureProvider<List<NationalityData>>((ref) async {
  final nationalityListService = ref.watch(authServiceProvider);
  return await nationalityListService.fetchNationality();
});
final categoryProvider =
    FutureProvider.autoDispose<List<CategoryResponse>>((ref) async {
  final categoryService = ref.watch(allServiceProvider);
  return await categoryService.fetchCategories();
});
final doctorListProvider =
    FutureProvider.autoDispose<List<DoctorListResponse>>((ref) async {
  final doctorListService = ref.watch(allServiceProvider);
  return await doctorListService.fetchDoctorList();
});
// final doctorListProvider =
//     FutureProvider.autoDispose<List<DoctorListResponse>>((ref) async {
//   final doctorListService = ref.watch(allServiceProvider);
//   return await doctorListService.fetchDoctorListPage(
//       1, 10); // Initial call for first page
// });
// final doctorListProvider = FutureProvider.autoDispose
//     .family<List<DoctorListResponse>, int>((ref, currentPage) async {
//   final allService = ref.watch(allServiceProvider);
//   final pageSize = 10; // Fixed pageSize, or you can adjust as needed
//   final startIndex = (currentPage - 1) * pageSize; // Start index for pagination

//   return await allService.fetchDoctorListPage(
//       startIndex, pageSize); // Pass startIndex
// });

final communityListProvider =
    FutureProvider.autoDispose<List<CommunityListResponse>>((ref) async {
  final communityListService = ref.watch(allServiceProvider);
  return await communityListService.fetchCommunityList();
});
final loginDataProvider = FutureProvider.autoDispose<String?>((ref) async {
  final loginDataService = ref.watch(authServiceProvider);
  return await loginDataService.getLoginData();
});

final allAllegyListProvider =
    FutureProvider.autoDispose<List<AllAlergyResponse>>((ref) async {
  final allAllegyLListService = ref.watch(allServiceProvider);
  return await allAllegyLListService.fetchAllergies();
});
final allIntolleranceListProvider =
    FutureProvider.autoDispose<List<AllAlergyResponse>>((ref) async {
  final allIntolleranceegyLListService = ref.watch(allServiceProvider);
  return await allIntolleranceegyLListService.fetchIntollerance();
});
final allPrescriptionsListProvider =
    FutureProvider.autoDispose<List<GetPrescriptionModel>>((ref) async {
  final allPrescriptionListService = ref.watch(allServiceProvider);
  return await allPrescriptionListService.getPrescriptions();
});

final myCommunityListProvider =
    FutureProvider.autoDispose<List<CommunityListResponse>>((ref) async {
  final communityListService = ref.watch(allServiceProvider);
  return await communityListService.fetchMyCommunityList();
});
final myRefferredListProvider =
    FutureProvider.autoDispose<List<ReferralList>>((ref) async {
  final referralListService = ref.watch(allServiceProvider);
  return await referralListService.fetchMyReferredList();
});
final adminUserCommunityListProvider =
    FutureProvider.autoDispose<List<CommunityListResponse>>((ref) async {
  final communityListService = ref.watch(allServiceProvider);
  return await communityListService.fetchMyCommunityListByAdminUser();
});

final userProvider = FutureProvider.autoDispose<UserData>((ref) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getUserData();
});
final userContactProvider =
    FutureProvider.autoDispose<UserContact>((ref) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getContactData();
});
final userEmergencyContactProvider =
    FutureProvider.autoDispose<UserEmergency>((ref) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getEmergencyContactData();
});
final userFetchImmunizationProvider =
    FutureProvider.autoDispose<List<ImmunizationResponse>>((ref) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.fetchImmunization();
});

final userFetchMedicalRecordProvider =
    FutureProvider.autoDispose<List<MedicalRecordResponse>>((ref) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.fetchMedicalHistory();
});
// final userFetchMedicalRecordProvider =
//     FutureProvider<List<MedicalRecordResponse>>((ref) async {
//   final userDataService = ref.watch(allServiceProvider);
//   return userDataService.fetchMedicalHistory();
// });

final userPrescriptionByIdProvider = FutureProvider.autoDispose
    .family<List<PrescriptionByIDResponse>, int>((ref, id) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getPrescriptionById(id);
});
final userAllPrescriptionProvider =
    FutureProvider.autoDispose<List<PrescriptionByIDResponse>>((ref) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.fetchAllPrescription();
});
final userAllegiesListProvider =
    FutureProvider.autoDispose<List<UserAllegiesResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchAllergiesByUserID();
});
final userAppointmentProvider =
    FutureProvider.autoDispose<List<AppointmentResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchAppointmentByUserId();
});

final userHMOProvider =
    FutureProvider.autoDispose<List<HmoResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchHMOByUserId();
});
final userPrescriptionProvider =
    FutureProvider.autoDispose<List<PrescriptionByPatientResponse>>(
        (ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchPrescriptionByPatientId();
});
final userFriendRequestReceiverProvider =
    FutureProvider.autoDispose<List<FriendRequestReceiverResponse>>(
        (ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchFriendRequestByreceiver();
});

final userPatientIdProvider = FutureProvider.autoDispose
    .family<PatientByIDResponse, int>((ref, id) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getPatientById(id);
});
final userFriendRequestSenderProvider =
    FutureProvider.autoDispose<List<FriendRequestSenderResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchFriendRequestBySender();
});
final userAllFriendsSenderProvider =
    FutureProvider.autoDispose<List<AllFriendRequestResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchAllFriends();
});
final userGroupInterestProvider = FutureProvider.autoDispose
    .family<List<CommunityListResponse>, List<int>>((ref, categoryId) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getGroupInterest(categoryId);
});
final userReceiverCommunityProvider =
    FutureProvider.autoDispose<List<CommunityGroupReceiverResponse>>(
        (ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchRecieverPatientId();
});
final userSenderCommunityProvider =
    FutureProvider.autoDispose<List<CommunityGroupReceiverResponse>>(
        (ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchSenderPatientId();
});
final userBillingProvider =
    FutureProvider.autoDispose<List<BillingResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchBilingList();
});
final userGetInterestProvider =
    FutureProvider.autoDispose<List<AllInterestResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchAllInterest();
});
final userAllPostProvider = FutureProvider.autoDispose
    .family<List<AllPostResponse>, PostQueryParams>((ref, params) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.fetchAllPosts(
    params.groupId,
    params.pageNumber,
    params.pageSize,
  );
});

final userAllFlaggedPostProvider =
    FutureProvider.autoDispose<List<AllPostResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchAllFlaggedPosts();
});

final userAllMediaProvider = FutureProvider.autoDispose
    .family<List<PostMediaResponse>, int>((ref, categoryId) async {
  final userDataService = ref.watch(allServiceProvider);
  return await userDataService.getAllPostMedia(categoryId);
});

final userAlDoctorsRatingProvider =
    FutureProvider.autoDispose<List<DoctorsRatingResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.getAllDoctorsRating();
});

final userAllHealthCareProvider =
    FutureProvider.autoDispose<List<CareGiverResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.getAllCareGiver();
});
// final chatListProvider =
//     FutureProvider.autoDispose<List<ChatContact>>((ref) async {
//   final chatListService = ref.watch(allServiceProvider);
//   return await chatListService.fetchChatContactList();
// });
// final chatPaginationProvider =
//     StateNotifierProvider<ChatPaginationNotifier, List<ChatContact>>((ref) {
//   final service = ref.watch(allServiceProvider);
//   return ChatPaginationNotifier(service);
// });

final chatPaginationProvider = StateNotifierProvider<ChatPaginationNotifier,
    AsyncValue<List<ChatContact>>>(
  (ref) => ChatPaginationNotifier(ref.read(allServiceProvider)),
);

final chatConversationProvider = FutureProvider.autoDispose.family<
    List<ConversationResponse>,
    ({
      String userIdTwo,
      String userTypeTwo,
      int page,
      int size
    })>((ref, params) async {
  final conversationService = ref.watch(allServiceProvider);
  return await conversationService.fetchChatConversationList(
      params.userIdTwo, params.userTypeTwo, params.page, params.size);
});

final userUnreadChatProvider =
    FutureProvider.autoDispose<UnreadMessageResponse>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchUnreadChat();
});
final userNotificationProvider =
    FutureProvider.autoDispose<List<NotificationResponse>>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchNotificationList();
});
final userUnreadNotificationProvider =
    FutureProvider.autoDispose<UnreadNotificationResponse>((ref) async {
  final responseListService = ref.watch(allServiceProvider);
  return await responseListService.fetchUnreadNotification();
});
final cloudTranslateProvider = Provider((ref) {
  const apiKey = "AIzaSyAr16nQrhWSnyM9geBTAJlBBwkg69kGTEc";
  return CloudTranslateService(apiKey);
});

final cloudTranslatedTextProvider =
    FutureProvider.family<String, String>((ref, text) async {
  final lang = ref.watch(languageProvider);
  final service = ref.watch(cloudTranslateProvider);

  if (lang == "en") return text;

  return await service.translateText(
    text: text,
    to: lang,
  );
});
