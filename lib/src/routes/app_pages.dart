import 'package:greenzone_medical/src/features/account/presentation/flagged_content.dart';
import 'package:greenzone_medical/src/features/account/presentation/referred_content.dart';
import 'package:greenzone_medical/src/features/appointment/appointment.dart';
import 'package:greenzone_medical/src/features/appointment/presentation/widgets/reasoncancelled_appointments.dart';
import 'package:greenzone_medical/src/features/caregivers/presentation/engage_page.dart';
import 'package:greenzone_medical/src/features/chats/chats.dart';
import 'package:greenzone_medical/src/features/chats/presentation/model/chatcontact_model.dart';
import 'package:greenzone_medical/src/features/health_record/presentation/widget/main_health_record.dart';
import 'package:greenzone_medical/src/features/home/presentation/suspended_products.dart';
import 'package:greenzone_medical/src/features/notifications/notifications.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/delivery_details.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/drug_checkout.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/drug_search_result.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/pharmacy_search_screen.dart';
import 'package:greenzone_medical/src/features/pharmacy/presentation/single_drug_detail.dart';
import 'package:greenzone_medical/src/features/plan/presentation/single_plan_dashboard.dart';
import 'package:greenzone_medical/src/features/prescription/presentation/prescriptions.dart';
import 'package:greenzone_medical/src/features/plan/presentation/my_goals_screen.dart';
import 'package:greenzone_medical/src/features/profile/presentation/profile_management.dart';
import 'package:greenzone_medical/src/features/plan/widgets/start_plan_screen.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';
import 'package:greenzone_medical/src/model/my_app_model.dart';
import '../features/account/presentation/account_reset_password.dart';
import '../features/appointment/model/appointment_model.dart';
import '../features/article/all_articles.dart';
import '../features/biling/presentation/billings_page.dart';
import '../features/chats/presentation/model/widget/chat_detail_screen.dart';
import '../features/chats/presentation/model/widget/contact_info.dart';
import '../features/community/presentation/community_friends_details.dart';
import '../features/community/presentation/friends_with_search.dart';
import '../features/health_record/model/health_record_model.dart';
import '../features/health_record/presentation/widget/doctorsnote/notes_page.dart';
import '../features/home/model/friend_request_receiver.dart';
import '../features/home/presentation/friend_request/all_friend_request.dart';
import '../features/home/presentation/friend_request/view_patient.dart';
import '../features/home/presentation/widget/all_group_interest.dart';
import '../features/rating/rating_page.dart';
import '../model/doctord_list_response.dart';
import '../utils/packages.dart';

part 'app_routes.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;
}

final routerProvider = Provider<GoRouter>((ref) {
  // ref.watch(authProvider);
  // final authNotifier = ref.read(authProvider.notifier);
  // static String get routeName => 'splash';
  // static String get routeLocation => '/$routeName';
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: _Paths.SPLASH,
    routes: [
      GoRoute(
        path: SuspendedProducts.routeName,
        builder: (context, state) {
          return const SuspendedProducts();
        },
      ),
      GoRoute(
        path: DeliveryDetails.routeName,
        builder: (context, state) {
          return const DeliveryDetails();
        },
      ),
      GoRoute(
        path: DrugCheckout.routeName,
        builder: (context, state) {
          return const DrugCheckout();
        },
      ),
      GoRoute(
        path: DrugSearchResult.routeName,
        builder: (context, state) {
          return const DrugSearchResult();
        },
      ),
      GoRoute(
        path: PharmacySearchScreen.routeName,
        builder: (context, state) {
          return const PharmacySearchScreen();
        },
      ),
      GoRoute(
        path: SingleDrugDetail.routeName,
        builder: (context, state) {
          return const SingleDrugDetail();
        },
      ),
      GoRoute(
        path: SinglePlanDashboard.routeName,
        builder: (context, state) {
          return SinglePlanDashboard(
            myApp: state.extra as MyAppModel,
          );
        },
      ),
      GoRoute(
        path: StartPlanScreen.routeName,
        builder: (context, state) {
          return StartPlanScreen(
            app: state.extra as MyAppModel,
          );
        },
      ),
      GoRoute(
        path: MyGoalsScreen.routeName,
        builder: (context, state) {
          return const MyGoalsScreen();
        },
      ),
      GoRoute(
        path: ProfileManagement.routeName,
        builder: (context, state) {
          return const ProfileManagement();
        },
      ),
      //  //  //
      GoRoute(
        path: _Paths.SPLASH,

        // name: SplashPage.routeName,
        builder: (context, state) {
          return const SplashPage();
        },
      ),
      GoRoute(
        path: _Paths.ONBOARDING,

        // name: SplashPage.routeName,
        builder: (context, state) {
          return const OnBoardingPage();
        },
      ),
      GoRoute(
        path: _Paths.ACCOUNTCREATION,
        // name: SplashPage.routeName,
        builder: (context, state) {
          return const AccountCreationScreen();
        },
      ),
      GoRoute(
        path: _Paths.SIGNIN,
        name: _Paths.SIGNIN,
        builder: (context, state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: _Paths.RESETPASSWORD,
        name: _Paths.RESETPASSWORD,
        builder: (context, state) {
          return const ResetPasswordPage();
        },
      ),
      GoRoute(
        path: _Paths.OTPPAGE,
        name: _Paths.OTPPAGE,
        builder: (context, state) {
          final email = state.extra as String;
          return OTPPage(
            email: email,
          );
        },
      ),
      GoRoute(
        path: _Paths.CHATDETAILS,
        name: _Paths.CHATDETAILS,
        builder: (context, state) {
          final chat = state.extra as ChatContact;
          return ChatDetailScreen(chat: chat);
        },
      ),
      //  GoRoute(
      //   path: _Paths.UPLOADPROFILEIMAGE,
      //   name: _Paths.UPLOADPROFILEIMAGE,
      //   builder: (context, state) {
      //     final email = state.extra as String;
      //     return OTPPage(
      //       email: email,
      //     );
      //   },
      // ),
      GoRoute(
        path: _Paths.NEWPASSWORD,
        name: _Paths.NEWPASSWORD,
        builder: (context, state) {
          final extra = state.extra as Map<String, String>?; // Extract extras
          return NewPasswordPage(
            email: extra?['email'] ?? '',
            otp: extra?['otp'] ?? '',
          );
        },
      ),
      GoRoute(
        path: _Paths.SIGNUP,
        name: _Paths.SIGNUP,
        builder: (context, state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: _Paths.HOMEPAGE,
        name: _Paths.HOMEPAGE,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: _Paths.BOTTOMNAV,
        name: _Paths.BOTTOMNAV,
        builder: (context, state) {
          return CustomBottomNavBar();
        },
      ),
      GoRoute(
        path: _Paths.ARTICLESCREEN,
        name: _Paths.ARTICLESCREEN,
        builder: (context, state) {
          return const ArticleScreen();
        },
      ),
      GoRoute(
        path: _Paths.COMMUNITYPAGE,
        name: _Paths.COMMUNITYPAGE,
        builder: (context, state) {
          return const CommunityPage();
        },
      ),
      GoRoute(
        path: _Paths.COMMUNITYLIST,
        name: _Paths.COMMUNITYLIST,
        builder: (context, state) {
          return const CommunityList();
        },
      ),
      GoRoute(
        path: _Paths.COMMUNITYDETAILS,
        name: _Paths.COMMUNITYDETAILS,
        builder: (context, state) {
          final community = state.extra as CommunityListResponse;
          return CommunityDetails(community: community);
        },
      ),
      GoRoute(
        path: _Paths.SEARCHCOMMUNITY,
        name: _Paths.SEARCHCOMMUNITY,
        builder: (context, state) {
          return const SearchCommunity();
        },
      ),
      GoRoute(
        path: _Paths.DOCTORPAGE,
        name: _Paths.DOCTORPAGE,
        builder: (context, state) {
          return const DoctorPage();
        },
      ),
      GoRoute(
        path: _Paths.DOCTORLISTING,
        name: _Paths.DOCTORLISTING,
        builder: (context, state) {
          final doctor = state.extra as DoctorListResponse;
          return DoctorListing(doctor: doctor);
        },
      ),
      GoRoute(
        path: _Paths.BOOKAPPOINTMENT,
        name: _Paths.BOOKAPPOINTMENT,
        builder: (context, state) {
          final doctor = state.extra as DoctorListResponse;
          return BookAppointment(
            doctor: doctor,
          );
        },
      ),
      GoRoute(
        path: _Paths.CAREGIVERSPAGE,
        name: _Paths.CAREGIVERSPAGE,
        builder: (context, state) {
          final type = state.extra as String;
          return CaregiversPage(
            type: type,
          );
        },
      ),
      GoRoute(
        path: _Paths.ENGAGEPAGE,
        name: _Paths.ENGAGEPAGE,
        builder: (context, state) {
          final type = state.extra as String;
          return EngagePage(
            type: type,
          );
        },
      ),
      GoRoute(
        path: _Paths.RESCHEDULEAPPOINTMENT,
        name: _Paths.RESCHEDULEAPPOINTMENT,
        builder: (context, state) {
          final appointmentData = state.extra as Map<String, dynamic>;
          return RescheduleAppointmentPage(data: appointmentData);
        },
      ),
      GoRoute(
        path: _Paths.DOCTORSREPORT,
        name: _Paths.DOCTORSREPORT,
        builder: (context, state) {
          return const DoctorsReportPage();
        },
      ),
      GoRoute(
        path: _Paths.DOCTORSREPORTDETAILS,
        name: _Paths.DOCTORSREPORTDETAILS,
        builder: (context, state) {
          return const DoctorsReportDetails();
        },
      ),
      GoRoute(
        path: _Paths.HEALTHGOAL,
        name: _Paths.HEALTHGOAL,
        builder: (context, state) {
          return const HealthGoalPage();
        },
      ),
      GoRoute(
        path: _Paths.ABOUTHEALTH,
        name: _Paths.ABOUTHEALTH,
        builder: (context, state) {
          return const AboutGoalPage();
        },
      ),
      GoRoute(
        path: _Paths.ARTICLEDETAILS,
        name: _Paths.ARTICLEDETAILS,
        builder: (context, state) {
          final article = state.extra as ArticleResponse;
          return ArticleDetails(article: article);
        },
      ),
      GoRoute(
        path: _Paths.MYCOMMUNITY,
        name: _Paths.MYCOMMUNITY,
        builder: (context, state) {
          return const MyCommunity();
        },
      ),
      GoRoute(
        path: _Paths.PRODUCTSCAN,
        name: _Paths.PRODUCTSCAN,
        builder: (context, state) {
          return const ProductScanScreen();
        },
      ),
      GoRoute(
        path: _Paths.LOADINGPRODUCTSCAN,
        name: _Paths.LOADINGPRODUCTSCAN,
        builder: (context, state) {
          final imagePath = state.extra as String;
          return LoadingScreen(
            imagePath: imagePath,
          );
        },
      ),
      GoRoute(
        path: _Paths.PRODUCTSCANRESULT,
        name: _Paths.PRODUCTSCANRESULT,
        builder: (context, state) {
          final args = state.extra as ScanResultArgs;

          return ResultScreen(
            imagePath: args.imagePath,
            productData: args.productData,
          );
        },
      ),
      GoRoute(
        path: _Paths.USERPERSONAL,
        name: _Paths.USERPERSONAL,
        builder: (context, state) {
          return const PersonalDataScreen();
        },
      ),
      GoRoute(
        path: _Paths.USERCONTACT,
        name: _Paths.USERCONTACT,
        builder: (context, state) {
          return const HealthContactDetails();
        },
      ),
      GoRoute(
        path: _Paths.USEREMERGENCY,
        name: _Paths.USEREMERGENCY,
        builder: (context, state) {
          return const EmergencyContactDetails();
        },
      ),
      GoRoute(
        path: _Paths.MAINHEALTHRECORD,
        name: _Paths.MAINHEALTHRECORD,
        builder: (context, state) {
          return const MainHealthRecord();
        },
      ),
      GoRoute(
        path: _Paths.NOTESPAGE,
        name: _Paths.NOTESPAGE,
        builder: (context, state) {
          final medicalRes = state.extra as MedicalRecordResponse;
          return NotesPage(screenData: medicalRes);
        },
      ),
      GoRoute(
        path: _Paths.PRESCRIPTION,
        name: _Paths.PRESCRIPTION,
        builder: (context, state) {
          final showBack = (state.extra as bool?) ?? false;
          return PrescriptionPage(showBackButton: showBack);
        },
      ),
      // GoRoute(
      //   path: _Paths.REASONCANCELAPPOINTMENT,
      //   name: _Paths.REASONCANCELAPPOINTMENT,
      //   builder: (context, state) {
      //     return ReasoncancelledAppointments();
      //   },
      // ),
      GoRoute(
        path: _Paths.REASONCANCELAPPOINTMENT,
        name: _Paths.REASONCANCELAPPOINTMENT,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return ReasoncancelledAppointments(
            appointmentId: extra['appointmentId'],
            onRefresh: extra['onRefresh'],
            isCanceled: extra['isCanceled'],
          );
        },
      ),

      GoRoute(
        path: _Paths.APPOINTMENT,
        name: _Paths.APPOINTMENT,
        builder: (context, state) {
          final showBack = state.extra as bool;
          return AppointmentPage(showBackButton: showBack);
        },
      ),
      GoRoute(
        path: _Paths.RATINGPAGE,
        name: _Paths.RATINGPAGE,
        builder: (context, state) {
          final doctor = state.extra as AppointmentResponse;
          return RatingPage(
            doctor: doctor,
          );
        },
      ),
      GoRoute(
        path: _Paths.ALLFRIENDREQUEST,
        name: _Paths.ALLFRIENDREQUEST,
        builder: (context, state) {
          return const AllFriendRequest();
        },
      ),
      GoRoute(
        path: _Paths.VIEWPATIENTPAGE,
        name: _Paths.VIEWPATIENTPAGE,
        builder: (context, state) {
          final friendRequestReceiverResponse =
              state.extra as FriendRequestReceiverResponse;
          return ViewPatientPage(
            friendRequestReceiverResponse: friendRequestReceiverResponse,
          );
        },
      ),
      GoRoute(
        path: _Paths.VIEWALLGROUPINTEREST,
        name: _Paths.VIEWALLGROUPINTEREST,
        builder: (context, state) {
          final categoryIds = state.extra as List<int>;
          return AllGroupInterestScreen(
            categoryIds: categoryIds,
          );
        },
      ),
      GoRoute(
        path: _Paths.COMMUNITYFRIENDSDETAILS,
        name: _Paths.COMMUNITYFRIENDSDETAILS,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final community = extra['community'] as CommunityListResponse;
          final id = extra['id'] as int;

          return CommunityFriendDetails(
            community: community,
            id: id,
          );
        },
      ),
      GoRoute(
        path: _Paths.FRIENDWITHSEARCHPAGE,
        name: _Paths.FRIENDWITHSEARCHPAGE,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          final community = extra['community'] as CommunityListResponse;

          return FriendWithSearchPage(
            community: community,
          );
        },
      ),
      GoRoute(
        path: _Paths.BILLINGPAGE,
        name: _Paths.BILLINGPAGE,
        builder: (context, state) {
          return const BillingsPage();
        },
      ),
      GoRoute(
        path: _Paths.ALLARTICLESECTION,
        name: _Paths.ALLARTICLESECTION,
        builder: (context, state) {
          return const AllArticleScreen();
        },
      ),
      GoRoute(
        path: _Paths.CHATPAGE,
        name: _Paths.CHATPAGE,
        builder: (context, state) {
          return const ChatPage();
        },
      ),
      GoRoute(
        path: _Paths.NOTIFICATIONPAGE,
        name: _Paths.NOTIFICATIONPAGE,
        builder: (context, state) {
          return const NotificationPage();
        },
      ),
      GoRoute(
        path: _Paths.CONTACTINFOPAGE,
        name: _Paths.CONTACTINFOPAGE,
        builder: (context, state) {
          final userID = state.extra as int;
          return ContactInfoPage(
            friendRequestReceiverResponse: userID,
          );
        },
      ),
      GoRoute(
        path: _Paths.ACCOUNTRESETPASSWORDPAGE,
        name: _Paths.ACCOUNTRESETPASSWORDPAGE,
        builder: (context, state) {
          return AccountResetPasswordPage();
        },
      ),
      GoRoute(
        path: _Paths.FLAGGEDCONTENTPAGE,
        name: _Paths.FLAGGEDCONTENTPAGE,
        builder: (context, state) {
          return FlaggedContentPage();
        },
      ),
      GoRoute(
        path: _Paths.REFFEREDCONTENTPAGE,
        name: _Paths.REFFEREDCONTENTPAGE,
        builder: (context, state) {
          return ReferredContentPage();
        },
      ),
    ],
    // redirect: (context, state) {
    // print(state);
    // print('router redirect call ');
    // // If our async state is loading, don't perform redirects, yet
    // if (authNotifier.isLoading) return null;
    //
    // final isAuth = authNotifier.isAuthenticated;
    //
    // final isSplash = state.location == SplashPage.routeLocation;
    // if (isSplash) {
    //   return isAuth ? HomePage.routeLocation : LoginPage.routeLocation;
    // }
    //
    // final isLoggingIn = state.location == LoginPage.routeLocation;
    // if (isLoggingIn) return isAuth ? HomePage.routeLocation : null;
    //
    // return isAuth ? null : SplashPage.routeLocation;
    // },
  );
});
