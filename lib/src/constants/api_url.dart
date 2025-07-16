import 'package:greenzone_medical/src/app_pkg.dart';

class ApiUrl {
  ApiUrl._();

  static const String login = '/auth/login';
  static const String socialLogin = '/Auth/login/social';

  static const String registerUrl = '/Patient';
  static const String uploadProfileUrl = '/Patient/photo-update';

  static const String updateDeviceTokenUrl = '/Auth/update-device-token';

  static const String profileGetUrl = '/Patient/myprofile';
  static const String contactGetUrl = '/Patient/contact/';
  static const String emergencyGetUrl = '/Patient/emergencycontact/';

  static const String changePasswordPostUrl = '/user/change-password/';
  static const String forgetPasswordPostUrl = '/Auth/forgot-password';
  static const String otpSendUrl = '/Auth/generate-otp?email=';
  static const String allArticleUrl = '/Articles?page=1&pageSize=100000';
  static const String allBannersUrl = '/Banners';
  static const String allCategoriesUrl = '/Categories';
  // static const String allDoctorsUrl = '/Doctors/list/1/98';
  static const String stateUrl = '/employee/state-list';
  static const String immunizationUrl = '/Patient/immunization/';
  static const String medicalRecordUrl = '/Treatment';
  static const String prescriptionByIdUrl = '/Prescription/treatment/';
  static const String allPrescriptionUrl = '/Prescription';
  static const String prescriptionByUserIdUrl = '/Prescription/patient/';
  static const String allInterestUrl =
      '/FavoriteCategory/list/user-favorite-categories/';
  // static String allDoctorsUrl(int first, int last) =>
  //     '/Doctors/list/$first/$last';
  // static String allDoctorsUrl(int page, int pageSize) =>
  //     '/Doctors/list/1/${page * pageSize}';

  static String allDoctorsUrl(int pageSize) => '/Doctors/list';

  // static const String communityListUrl = '/Community/list';
  static const String communityListUrl = '/CommunityGroup/list';
  static const String myCommunityListUrl = '/CommunityGroup/list/user-groups';
  static const String sendInviteUrl = '/CommunityGroupInvite';
  static const String saveFavouriteCategoyURL = '/FavoriteCategory';

  // static String joinCommunityUrl(int id) => '/Community/$id/join-community';
  static String joinCommunityUrl(int id) =>
      '/CommunityGroup/$id/join-community-group';

  static String follorFriendRequestUrl(int id) =>
      '/FriendRequest/$id/create-friend-request';
  static String billingRequestUrl(int id) => '/Patient/paymenthistory/$id';
  static String fetchAdminUserCommunityUrl(int id) =>
      '/CommunityGroup/list/admin-user/$id';
  static String unfollorFriendRequestUrl(int id) => '/Friend/$id/remove-friend';
  static String patientById(int id) => '/Patient/single/$id';
  static String friendrequestResponseRequestURL(
          int id, int receiverPatientId) =>
      '/FriendRequest/$id/patient/$receiverPatientId/respond-to-request';
  static String allPostURL(int groupId, int pageNumber, int pageSize) =>
      '/Posts/get-group-posts-including-comments?groupId=$groupId&pageNumber=$pageNumber&pageSize=$pageSize';
  static String imageAnalysisUrl = '/ImageAnalysis/snack-image-analysis';
  static String imageUploadUrl = '/Image';

  static String likePostUrl(int postId, int memberId) =>
      '/Posts/$postId/like?memberId=$memberId';
  static const String reactToPostUrl = '/Posts/ReactToPost';
  static const String addPostCommentsUrl = '/Posts/add-post-comments';
  static const String chatWithImageUrl = '/Posts/send-text-with-image';
  static const String chatWithTextUrl = '/Posts/send-text';
  static const String allUnreadChatUrl = '/Posts/unread-count/';
  static const String allAllergyUrl = '/employee/get-allergies';
  static const String fetchAllAllergyUrl = '/employee/get-allergies';
  static const String updateAllergyUrl = '/employee/update-allergies';

  static const String fetchAllIntolleranceUrl = '/employee/get-intollerance';

  static const String createPasswordUrl = '/Auth/create-password';
  static const String bookAppointmentUrl = '/Appointment';
  static const String doctorRatingUrl = '/DoctorRating';
  static const String fetchAllergyUrl = '/employee/list/allergy/userid?Id=';

  static String communityGroupInviteReceiverURL(int id) =>
      '/CommunityGroupInvite/list/receiver-patient/$id';
  static String generateCallTokenURL(String channelName, String uid) =>
      '/Posts/generate-call-token?channelName=$channelName&uid=$uid';
  static String communityGroupInviteSenderURL(int id) =>
      '/CommunityGroupInvite/list/patient/$id';
  static String responseToInviteURL(int id) =>
      '/CommunityGroupInvite/$id/respond-to-invite';
  static String notifyCallURL = '/Posts/notify-call';

  static String verifyOTPPostUrlForAfterReg(String code, String email) =>
      '/Patient/ValidateOtp?otp=$code&email=$email';
  // static String createPasswordUrl(String email, String password, String confirmPassword) =>
  // '/Patient/ValidateOtp?otp=$code&email=$email';
  static const String resetPasswordPutUrl = '/user/reset_password_for_mobile/';
  static String verifyOTPForResetPasswordGetUrl(
          String otpCode, String userName) =>
      '/user/otp_login_match_data_return_token_for_reset/?otp_code=$otpCode&user_name=$userName';
  static const getCountryList =
      '/country_managers/country_list_from_db_without_authorization/';
  static String getHome(int id) => "/products/home-product/?country_id=$id";
  static String getProductDetailsUrl(String productId) =>
      "/products/product-detail/$productId/?country_id=${SharedPreferencesService.instance.getString(StorageConstants.countryId)}";
  static const String getFollowed = "/promoter/get-promoter/";
  static const String getFollowedAndRecommendedUrl =
      "/promoter/follow-recommended/";
  static const String postSubmitReview = "/products/productReview/";
  //e2b
  static const String getDivisions = "/settings/divisions";
  static const String getDistricts = "/settings/districts";
  static const String sendOTP = "/settings/send-otp";
  static const String verifyOTP = "/settings/verify-otp";
  static String hmoUrl(int patientId) => "/Patient/hmo/$patientId";
  static const String allFriendsURL = "/Friend/list-patient-friends/patient/";
  static const String allDoctorsRatingURL = "/DoctorRating/list";
  static String allChatContactUrl(String userId, String userType,
          {required int pageNumber, required int pageSize}) =>
      '/Posts/contacts/$userId/$userType?pageNumber=$pageNumber&pageSize=$pageSize';

  static String allChatConversationUrl(
          String userId,
          String userType,
          String userIDSecond,
          String userTypeSecond,
          int pagenumber,
          int pageSize) =>
      '/Posts/conversation-between-users?user1Id=$userId&user1Type=$userType&user2Id=$userIDSecond&user2Type=$userTypeSecond&pageNumber=$pagenumber&pageSize=$pageSize';
  static String allNotificationUrl(String userId) =>
      '/Notifications/user/$userId';
  static String allUnreadNotificationUrl(String userId) =>
      '/Notifications/unread-count/$userId';

  // Appointment
  static String appointment(int patientId) => "/appointment/patient/$patientId";
  static String friendRequestReceiver(int patientId) =>
      "/FriendRequest/list/receiver-patient/$patientId";
  static String friendRequestSender(int patientId) =>
      "/FriendRequest/list/patient/$patientId";

  static String groupInterestURL(List<int> categoryIds) {
    final query = categoryIds.map((id) => "categoryIds=$id").join("&");
    return "/CommunityGroup/list/by-favorite-categories?$query";
  }

  static String groupPostMediaURL(int groupId) =>
      "/Posts/media?groupId=$groupId";

  static const cancelAppointment = "/appointment/cancel-appointment";
  static const rescheduleAppointment = "/appointment";
  static String careGivers(int page, int pageSize) =>
      "/HealthCareProvider/list/$page/$pageSize";
  static String careGiverSearch =
      "/HealthCareProvider/GetAllHealthCareProviderList";
  // https://edogoverp.com/ConnectedHealthWebApi/api/HealthCareProvider/HealthCareProvider/y/1/10

  // https://edogoverp.com/ConnectedHealthWebApi/api/HealthCareProvider/list/1/10

  //  static String getHome(int id) => "/products/home-product/?country_id=$id";
}
