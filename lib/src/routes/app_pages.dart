import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:greenzone_medical/src/features/article/presentation/article_details.dart';
import 'package:greenzone_medical/src/features/auth/presentation/new_password_page.dart';
import 'package:greenzone_medical/src/features/community/community.dart';
import 'package:greenzone_medical/src/features/community/presentation/community_details.dart';
import 'package:greenzone_medical/src/features/community/presentation/community_list.dart';
import 'package:greenzone_medical/src/features/doctors/doctors.dart';
import 'package:greenzone_medical/src/features/doctors/presentation/book_appointment.dart';
import 'package:greenzone_medical/src/features/doctors/presentation/doctor_listing.dart';
import 'package:greenzone_medical/src/features/healthgoal/presentation/healthgoal_page.dart';
import 'package:greenzone_medical/src/features/home/home.dart';
import 'package:greenzone_medical/src/model/community_list_response.dart';
import 'package:greenzone_medical/src/model/doctord_list_response.dart';

import '../app_pkg.dart';
import '../features/article/presentation/article_screen.dart';
import '../features/community/presentation/search_community.dart';
import '../features/healthgoal/presentation/about_health.dart';
import '../features/home/presentation/widget/custom_bottom_navbar.dart';
import '../features/onboarding/onboarding.dart';

part 'app_routes.dart';

final _key = GlobalKey<NavigatorState>();

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
    navigatorKey: _key,
    debugLogDiagnostics: true,
    initialLocation: _Paths.SPLASH,
    routes: [
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
          final article = state.extra as Map<String, String>;
          return ArticleDetails(
            title: article["title"]!,
            description: article["description"]!,
            imageUrl: article["imageUrl"]!,
          );
        },
      ),
    ],
    redirect: (context, state) {
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
    },
  );
});
