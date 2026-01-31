import 'package:flutter/material.dart';
import 'package:mvvmclean/presentation/forgot_password/forgotpassword_view.dart';
import 'package:mvvmclean/presentation/login/login_view.dart';
import 'package:mvvmclean/presentation/main/main_view.dart';
import 'package:mvvmclean/presentation/onboarding/onboarding_view.dart';
import 'package:mvvmclean/presentation/register/register_view.dart';
import 'package:mvvmclean/presentation/resources/strings_manger.dart';
import 'package:mvvmclean/presentation/splash/splash_view.dart';
import 'package:mvvmclean/presentation/store_details/store_details_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String mainRoute = "/main";
  static const String storeDetalisRoute = "/storeDetails";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingView());

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => const RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotpasswordView());

      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const MainView());
      case Routes.storeDetalisRoute:
        return MaterialPageRoute(builder: (_) => const StoredetailsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ), //todo move this to Strings manager

        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ), //todo move this to Strings manager
      ),
    );
  }
}
