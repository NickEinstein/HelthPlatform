import 'package:greenzone_medical/src/app_pkg.dart';

class ApiUrl {
  ApiUrl._();

  static const String login = '/auth/login';
  static const String registerUrl = '/Patient';
  static const String profileGetUrl = '/user/profile/';
  static const String changePasswordPostUrl = '/user/change-password/';
  static const String forgetPasswordPostUrl = '/Auth/forgot-password';
  static const String otpSendUrl = '/Auth/generate-otp?email=';
  static const String allArticleUrl = '/Articles?page=1&pageSize=100000';
  static const String allBannersUrl = '/Banners';
  static const String allCategoriesUrl = '/Categories';
  static const String allDoctorsUrl = '/Doctors/list/1/98';
  static const String stateUrl = '/employee/state-list';
  static const String communityListUrl = '/Community/list';
  static String joinCommunityUrl(int id) => '/Community/$id/join-community';
  static const String allAllergyUrl = '/employee/get-allergies';
  static const String createPasswordUrl = '/Auth/create-password';
  static const String bookAppointmentUrl = '/Appointment';

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


  // Appointment
  static String appointment (int patientId) => "/appointment/patient/$patientId";
  static const cancelAppointment = "/appointment/cancel-appointment";
  static const rescheduleAppointment = "/appointment";
  static String careGivers(int page, int pageSize)=> "/HealthCareProvider/list/$page/$pageSize";
  static String careGiverSearch(int page, int pageSize, String searchText)=> "/HealthCareProvider/HealthCareProvider/$searchText/$page/$pageSize";
  // https://edogoverp.com/ConnectedHealthWebApi/api/HealthCareProvider/HealthCareProvider/y/1/10

  // https://edogoverp.com/ConnectedHealthWebApi/api/HealthCareProvider/list/1/10
  
  

  //  static String getHome(int id) => "/products/home-product/?country_id=$id";

  
}
