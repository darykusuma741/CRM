import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  EnvironmentsBadge({required this.child});
  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenScreen(),
      binding: SplashScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.CALL_ACTIVITIES,
      page: () => const CallActivitiesScreen(),
      binding: CallActivitiesControllerBinding(),
    ),
    GetPage(
      name: Routes.DOCUMENT_ACTIVITIES,
      page: () => const DocumentActivitiesScreen(),
      binding: DocumentActivitiesControllerBinding(),
    ),
    GetPage(
      name: Routes.SNA_FORM,
      page: () => const SnaFormScreen(),
      binding: SnaFormControllerBinding(),
    ),
    GetPage(
      name: Routes.FACE_SCAN,
      page: () => const FaceScanScreen(),
      binding: FaceScanControllerBinding(),
    ),
    GetPage(
      name: Routes.CHECK_IN,
      page: () => const CheckInScreen(),
      binding: CheckInControllerBinding(),
    ),
    GetPage(
      name: Routes.ADD_LEAD,
      page: () => const AddLeadScreen(),
      binding: AddLeadControllerBinding(),
    ),
    GetPage(
      name: Routes.MEETING_ACTIVITIES,
      page: () => const MeetingActivitiesScreen(),
      binding: MeetingActivitiesControllerBinding(),
    ),
  ];
}
