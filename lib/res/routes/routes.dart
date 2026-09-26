import 'package:forge_fit_app/res/routes/route_middleware.dart';
import 'package:forge_fit_app/res/routes/routes_name.dart';
import 'package:forge_fit_app/view/home/water_tracker_screen.dart';
import 'package:forge_fit_app/view/home/step_counter_screen.dart';
import 'package:forge_fit_app/view/home/weight_tracker_screen.dart';
import 'package:forge_fit_app/view/home/progress_photos_screen.dart';
import 'package:forge_fit_app/view/home/badges_screen.dart';
import 'package:forge_fit_app/view/auth_screens/forgot_password_screen.dart';
import 'package:forge_fit_app/view/auth_screens/login_screen.dart';
import 'package:forge_fit_app/view/auth_screens/personalize_screen.dart';
import 'package:forge_fit_app/view/auth_screens/reset_password_screen.dart';
import 'package:forge_fit_app/view/auth_screens/signup_screen.dart';
import 'package:forge_fit_app/view/home/dashboard_screen.dart';
import 'package:forge_fit_app/view/home/settings_screen.dart';
import 'package:forge_fit_app/view/splash_screen/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> appRoute() => [
        GetPage(
          name: RouteName.splashScreen,
          page: () => SplashScreen(),
          transition: Transition.leftToRightWithFade,
        ),
        // Onboarding Screen (Temporary LoginScreen agar file nahi bani hai toh)
        GetPage(
          name: RouteName.onboardingScreen,
          page: () => const LoginScreen(), 
          transition: Transition.fade,
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => const LoginScreen(),
          transition: Transition.fade,
        ),
        GetPage(
          name: RouteName.signUpScreen,
          page: () => const SignUpScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.forgotPasswordScreen,
          page: () => const ForgotPasswordScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.resetPasswordScreen,
          page: () => const ResetPasswordScreen(),
          transition: Transition.rightToLeftWithFade,
        ),
        GetPage(
          name: RouteName.personalizeScreen,
          page: () => PersonalizeScreen(),
          transition: Transition.rightToLeftWithFade,
        ),

        // ── Protected Routes (Added AuthMiddleware) ─────────────────────
        GetPage(
          name: RouteName.dashboard,
          page: () => const DashboardScreen(),
          transition: Transition.fadeIn,
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: RouteName.settingsScreen,
          page: () => const SettingsScreen(),
          transition: Transition.rightToLeftWithFade,
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: RouteName.waterTrackerScreen,
          page: () => const WaterTrackerScreen(),
          transition: Transition.rightToLeftWithFade,
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: RouteName.stepCounterScreen,
          page: () => const StepCounterScreen(),
          transition: Transition.rightToLeftWithFade,
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: RouteName.weightTrackerScreen,
          page: () => const WeightTrackerScreen(),
          transition: Transition.rightToLeftWithFade,
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: RouteName.progressPhotosScreen,
          page: () => const ProgressPhotosScreen(),
          transition: Transition.rightToLeftWithFade,
          middlewares: [AuthMiddleware()],
        ),
        GetPage(
          name: RouteName.badgesScreen,
          page: () => const BadgesScreen(),
          transition: Transition.rightToLeftWithFade,
          middlewares: [AuthMiddleware()],
        ),
      ];
}
