import 'package:greenzone_medical/src/app_pkg.dart';

class ApiUrl {
  ApiUrl._();

  static const String login = '/ConnectedHealthWebApi/api/auth/login';
  static const String socialLogin =
      '/ConnectedHealthWebApi/api/Auth/login/social';

  static const String registerUrl = '/ConnectedHealthWebApi/api/Patient';
  static const String uploadProfileUrl =
      '/ConnectedHealthWebApi/api/Patient/photo-update';

  static const String updateDeviceTokenUrl =
      '/ConnectedHealthWebApi/api/Auth/update-device-token';

  static String getImmunizationResult(String id) =>
      '/ConnectedHealthWebApi/api/Patient/immunization/$id';
  static String getAllergyResult(String id) =>
      '/ConnectedHealthWebApi/api/UserAllergies/list/patient/$id';
  static String getOtherAllergyResult(String id) =>
      '/ConnectedHealthWebApi/api/UserAllergies/list/others/patient/$id';
  static String getPatientProfile(String id) =>
      '/ConnectedHealthWebApi/api/Patient/single/$id';
  static const String profileGetUrl =
      '/ConnectedHealthWebApi/api/Patient/myprofile';
  static const String contactGetUrl =
      '/ConnectedHealthWebApi/api/Patient/contact/';
  static const String emergencyGetUrl =
      '/ConnectedHealthWebApi/api/Patient/emergencycontact/';

  static const String changePasswordPostUrl =
      '/ConnectedHealthWebApi/api/user/change-password/';
  static const String forgetPasswordPostUrl =
      '/ConnectedHealthWebApi/api/Auth/forgot-password';
  static const String resetPasswordPostUrl =
      '/ConnectedHealthWebApi/api/Auth/reset-password';
  static String otpSendUrlWithChannel(String userId, String sendChannel) =>
      '/ConnectedHealthWebApi/api/Auth/generate-my-otp?userId=$userId&sendChannel=$sendChannel';
  static String otpSendUrl(String email) =>
      '/ConnectedHealthWebApi/api/Auth/generate-otp?email=$email';
  //   '/ConnectedHealthWebApi/api/Auth/generate-otp?email=';
  static const String allArticleUrl =
      '/ConnectedHealthWebApi/api/Articles?page=1&pageSize=100000';
  // static const String allBannersUrl = '/Banners';
  static const String allBannersUrl =
      '/ConnectedHealthWebApi/api/Adverts/all-adverts';

  static const String allCategoriesUrl =
      '/ConnectedHealthWebApi/api/Categories';
  // static const String allDoctorsUrl = '/Doctors/list/1/98';
  static const String stateUrl =
      '/ConnectedHealthWebApi/api/employee/state-list';
  static const String immunizationUrl =
      '/ConnectedHealthWebApi/api/Patient/immunization/';
  // static const String medicalRecordUrl = '/ConnectedHealthWebApi/api/Treatment';
  static String medicalRecordUrl(String id) =>
      '/medicals/api/patients/$id/medicalhistory';

  static const String prescriptionByIdUrl =
      '/ConnectedHealthWebApi/api/ConnectedHealthWebApi/api/Prescription/treatment/';
  static const String allPrescriptionUrl =
      '/ConnectedHealthWebApi/api/Prescription';
  static const String prescriptionByUserIdUrl =
      '/ConnectedHealthWebApi/api/Prescription/patient/';
  static const String allInterestUrl =
      '/ConnectedHealthWebApi/api/FavoriteCategory/list/user-favorite-categories/';
  // static String allDoctorsUrl(int first, int last) =>
  //     '/Doctors/list/$first/$last';
  // static String allDoctorsUrl(int page, int pageSize) =>
  //     '/Doctors/list/1/${page * pageSize}';

  static String allDoctorsUrl(int pageSize) =>
      '/ConnectedHealthWebApi/api/doctors/list/true?pageNumber=1&pageSize=$pageSize';
  // static const String communityListUrl = '/Community/list';
  static const String communityListUrl =
      '/ConnectedHealthWebApi/api/CommunityGroup/list';
  static const String myCommunityListUrl =
      '/ConnectedHealthWebApi/api/CommunityGroup/list/user-groups';
  static const String sendInviteUrl =
      '/ConnectedHealthWebApi/api/CommunityGroupInvite';
  static const String saveFavouriteCategoyURL =
      '/ConnectedHealthWebApi/api/FavoriteCategory';
  static String refferedURL(String id) =>
      '/ConnectHealthAdmin/api/patient/list/agents/$id/1/99/citizens_by-agent-id';

  // static String joinCommunityUrl(int id) => '/Community/$id/join-community';
  static String joinCommunityUrl(int id) =>
      '/ConnectedHealthWebApi/api/CommunityGroup/$id/join-community-group';

  static String follorFriendRequestUrl(int id) =>
      '/ConnectedHealthWebApi/api/FriendRequest/$id/create-friend-request';
  static String billingRequestUrl(int id) =>
      '/ConnectedHealthWebApi/api/Patient/paymenthistory/$id';
  static String fetchAdminUserCommunityUrl(int id) =>
      '/ConnectedHealthWebApi/api/CommunityGroup/list/admin-user/$id';
  static String unfollorFriendRequestUrl(int id) =>
      '/ConnectedHealthWebApi/api/Friend/$id/remove-friend';
  static String patientById(int id) =>
      '/ConnectedHealthWebApi/api/Patient/single/$id';
  static String friendrequestResponseRequestURL(
          int id, int receiverPatientId) =>
      '/ConnectedHealthWebApi/api/FriendRequest/$id/patient/$receiverPatientId/respond-to-request';
  static String allPostURL(int groupId, int pageNumber, int pageSize) =>
      '/ConnectedHealthWebApi/api/Posts/get-group-posts-including-comments?groupId=$groupId&pageNumber=$pageNumber&pageSize=$pageSize';
  static String allFlaggedPostURL(String id) =>
      '/ConnectedHealthWebApi/api//Posts/get-flagged-posts?citizensId=$id&pageNumber=1&pageSize=99';

  static String imageAnalysisUrl =
      '/ConnectedHealthWebApi/api/ImageAnalysis/snack-image-analysis';
  static String imageUploadUrl = '/ConnectedHealthWebApi/api/Image';

  static String likePostUrl(int postId, int memberId) =>
      '/ConnectedHealthWebApi/api/Posts/$postId/like?memberId=$memberId';
  static const String reactToPostUrl =
      '/ConnectedHealthWebApi/api/Posts/ReactToPost';
  static const String addPostCommentsUrl =
      '/ConnectedHealthWebApi/api/Posts/add-post-comments';
  static const String chatWithImageUrl =
      '/ConnectedHealthWebApi/api/Posts/send-text-with-image';
  static const String chatWithTextUrl =
      '/ConnectedHealthWebApi/api/Posts/send-text';
  static const String allUnreadChatUrl =
      '/ConnectedHealthWebApi/api/Posts/unread-count/';
  static const String allAllergyUrl =
      '/ConnectedHealthWebApi/api/employee/get-allergies';
  static const String fetchAllAllergyUrl =
      '/ConnectedHealthWebApi/api/employee/get-allergies';
  static const String updateAllergyUrl =
      '/ConnectedHealthWebApi/api/employee/update-allergies';

  static const String fetchAllIntolleranceUrl =
      '/ConnectedHealthWebApi/api/employee/get-intollerance';

  static const String createPasswordUrl =
      '/ConnectedHealthWebApi/api/Auth/create-password';
  static const String bookAppointmentUrl =
      '/ConnectedHealthWebApi/api/Appointment';
  static const String doctorRatingUrl =
      '/ConnectedHealthWebApi/api/DoctorRating';
  static const String fetchAllergyUrl =
      '/ConnectedHealthWebApi/api/employee/list/allergy/userid?Id=';

  static String communityGroupInviteReceiverURL(int id) =>
      '/ConnectedHealthWebApi/api/CommunityGroupInvite/list/receiver-patient/$id';
  static String generateCallTokenURL(String channelName, String uid) =>
      '/ConnectedHealthWebApi/api/Posts/generate-call-token?channelName=$channelName&uid=$uid';
  static String communityGroupInviteSenderURL(int id) =>
      '/ConnectedHealthWebApi/api/CommunityGroupInvite/list/patient/$id';
  static String responseToInviteURL(int id) =>
      '/ConnectedHealthWebApi/api/CommunityGroupInvite/$id/respond-to-invite';
  static String notifyCallURL = '/ConnectedHealthWebApi/api/Posts/notify-call';

  static String verifyOTPPostUrlForAfterReg(String code, String email) =>
      '/ConnectedHealthWebApi/api/Patient/ValidateOtp?otp=$code&email=$email';
  // static String createPasswordUrl(String email, String password, String confirmPassword) =>
  // '/Patient/ValidateOtp?otp=$code&email=$email';
  static const String resetPasswordPutUrl =
      '/ConnectedHealthWebApi/api/user/reset_password_for_mobile/';
  static String verifyOTPForResetPasswordGetUrl(
          String otpCode, String userName) =>
      '/ConnectedHealthWebApi/api/user/otp_login_match_data_return_token_for_reset/?otp_code=$otpCode&user_name=$userName';
  static const getCountryList =
      '/ConnectedHealthWebApi/api/country_managers/country_list_from_db_without_authorization/';
  static String getHome(int id) =>
      "/ConnectedHealthWebApi/api/products/home-product/?country_id=$id";
  static String getProductDetailsUrl(String productId) =>
      "/ConnectedHealthWebApi/api/products/product-detail/$productId/?country_id=${SharedPreferencesService.instance.getString(StorageConstants.countryId)}";
  static const String getFollowed =
      "/ConnectedHealthWebApi/api/promoter/get-promoter/";
  static const String getFollowedAndRecommendedUrl =
      "/ConnectedHealthWebApi/api/promoter/follow-recommended/";
  static const String postSubmitReview =
      "/ConnectedHealthWebApi/api/products/productReview/";
  //e2b
  static const String getDivisions =
      "/ConnectedHealthWebApi/api/settings/divisions";
  static const String getDistricts =
      "/ConnectedHealthWebApi/api/settings/districts";
  static const String sendOTP = "/ConnectedHealthWebApi/api/settings/send-otp";
  static const String verifyOTP =
      "/ConnectedHealthWebApi/api/settings/verify-otp";
  static String hmoUrl(int patientId) =>
      "/ConnectedHealthWebApi/api/Patient/hmo/$patientId";
  static const String allFriendsURL =
      "/ConnectedHealthWebApi/api/Friend/list-patient-friends/patient/";
  static const String allDoctorsRatingURL =
      "/ConnectedHealthWebApi/api/DoctorRating/list";
  static String allChatContactUrl(String userId, String userType,
          {required int pageNumber, required int pageSize}) =>
      '/ConnectedHealthWebApi/api/Posts/contacts/$userId/$userType?pageNumber=$pageNumber&pageSize=$pageSize';

  static String allChatConversationUrl(
          String userId,
          String userType,
          String userIDSecond,
          String userTypeSecond,
          int pagenumber,
          int pageSize) =>
      '/ConnectedHealthWebApi/api/Posts/conversation-between-users?user1Id=$userId&user1Type=$userType&user2Id=$userIDSecond&user2Type=$userTypeSecond&pageNumber=$pagenumber&pageSize=$pageSize';
  static String allNotificationUrl(String userId) =>
      '/ConnectedHealthWebApi/api/Notifications/user/$userId';
  static String allUnreadNotificationUrl(String userId) =>
      '/ConnectedHealthWebApi/api/Notifications/unread-count/$userId';

  // Appointment
  static String appointment(int patientId) =>
      "/ConnectedHealthWebApi/api/appointment/patient/$patientId";
  static String friendRequestReceiver(int patientId) =>
      "/ConnectedHealthWebApi/api/FriendRequest/list/receiver-patient/$patientId";
  static String friendRequestSender(int patientId) =>
      "/ConnectedHealthWebApi/api/FriendRequest/list/patient/$patientId";

  static String groupInterestURL(List<int> categoryIds) {
    final query = categoryIds.map((id) => "categoryIds=$id").join("&");
    return "/ConnectedHealthWebApi/api/CommunityGroup/list/by-favorite-categories?$query";
  }

  static String groupPostMediaURL(int groupId) =>
      "/ConnectedHealthWebApi/api/Posts/media?groupId=$groupId";

  static const cancelAppointment =
      "/ConnectedHealthWebApi/api/appointment/cancel-appointment";
  static const rescheduleAppointment = "/ConnectedHealthWebApi/api/appointment";
  static String careGivers(int page, int pageSize) =>
      "/ConnectedHealthWebApi/api/HealthCareProvider/list/$page/$pageSize";
  static String careGiverSearch =
      "/ConnectedHealthWebApi/api/HealthCareProvider/GetAllHealthCareProviderList";
  // https://edogoverp.com/ConnectedHealthWebApi/api/HealthCareProvider/HealthCareProvider/y/1/10

  // https://edogoverp.com/ConnectedHealthWebApi/api/HealthCareProvider/list/1/10

  //  static String getHome(int id) => "/products/home-product/?country_id=$id";

  //

  static String getAppsByCategory(int id) =>
      '/ConnectedHealthWebApi/api/apps/appByCategoryId?id=$id';
  static String getApps([int? id]) =>
      '/ConnectedHealthWebApi/api/apps/${id ?? ''}';
  static String getAppsCategories = '/ConnectedHealthWebApi/api/appCategories';
  static String appPlan([int? id]) =>
      '/ConnectedHealthWebApi/api/AppPlans/${id ?? ''}';
  static String userGoals = '/ConnectedHealthWebApi/api/userGoals';
  static String userGoalJournals(int goalId) =>
      '/ConnectedHealthWebApi/api/userGoalJournal/goal/$goalId';
  static String saveJournal(String uid) =>
      '/ConnectedHealthWebApi/api/userGoalJournal?userid=$uid';
  static String getAppPlanDashboard(String uid, int appId) =>
      '/ConnectedHealthWebApi/api/AppDashboard/DashboardData?userId=$uid&appId=$appId';

  static String updatePatientProfile(String id) =>
      '/ConnectedHealthWebApi/api/patient/$id';

  static String getPatientContact(String id) =>
      '/ConnectedHealthWebApi/api/patient/contact/$id';
  static String updatePatientContact(String id) =>
      '/ConnectedHealthWebApi/api/patient/$id/contact-update';

  static String getEmergencyContactInfo(String id) =>
      '/ConnectedHealthWebApi/api/patient/emergencyContact/$id';

  static String updateEmergencyContactInfo(String id) =>
      '/ConnectedHealthWebApi/api/patient/$id/emergency-contact-update';

  static String addImmunization(String id) =>
      '/ConnectedHealthDoctorApi/api/immunization/$id';
  static String getAllAllergies =
      '/ConnectedHealthWebApi/api/UserAllergies/list/allergies/';
  static String getPatientAllergies(String id) =>
      '/ConnectedHealthWebApi/api/UserAllergies/list/patient/$id';
  static String addAllergy(String id) =>
      '/ConnectedHealthWebApi/api/UserAllergies/create/patient/$id';
  static String deleteOtherAllergy(String id) =>
      '/ConnectedHealthWebApi/api/UserAllergies/others/$id';
  static String deleteAllergy(String id) =>
      '/ConnectedHealthWebApi/api/UserAllergies/$id';
  static String deleteImmunization(String id) =>
      '/ConnectedHealthDoctorApi/api/immunization/$id';

  static String getCountry = '/ConnectedHealthWebApi/api/Geography/countries/';
  static String getState(String cid) =>
      '/ConnectedHealthWebApi/api/Geography/countries/$cid/states';

  static String specialistUrl =
      '/ConnectedHealthWebApi/api/Categories/SpecialistCategories';
}
