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
    GetPage(
      name: Routes.LEADS_DETAIL,
      page: () => const LeadsDetailScreen(),
      binding: LeadsDetailControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_SERVICE,
      page: () => const ProductServiceScreen(),
      binding: ProductServiceControllerBinding(),
    ),
    GetPage(
      name: Routes.FREIGHT_PRODUCT,
      page: () => const FreightProductScreen(),
      binding: FreightProductControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_CATEGORY,
      page: () => const ProductCategoryScreen(),
      binding: ProductCategoryControllerBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMER,
      page: () => const CustomerScreen(),
      binding: CustomerControllerBinding(),
    ),
    GetPage(
      name: Routes.QUOTATIONS,
      page: () => const QuotationsScreen(),
      binding: QuotationsControllerBinding(),
    ),
    GetPage(
      name: Routes.ACTIVITY_HISTORY,
      page: () => const ActivityHistoryScreen(),
      binding: ActivityHistoryControllerBinding(),
    ),
    GetPage(
      name: Routes.FREIGHT_PRODUCT_DETAIL,
      page: () => const FreightProductDetailScreen(),
      binding: FreightProductDetailControllerBinding(),
    ),
    GetPage(
      name: Routes.FREIGHT_PRODUCT_FORM,
      page: () => const FreightProductFormScreen(),
      binding: FreightProductFormControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_CATEGORY_FORM,
      page: () => const ProductCategoryFormScreen(),
      binding: ProductCategoryFormControllerBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT_CATEGORY_DETAIL,
      page: () => const ProductCategoryDetailScreen(),
      binding: ProductCategoryDetailControllerBinding(),
    ),
    GetPage(
      name: Routes.CUSTOMER_DETAIL,
      page: () => const CustomerDetailScreen(),
      binding: CustomerDetailControllerBinding(),
    ),
    GetPage(
      name: Routes.ADDRESS_FORM,
      page: () => const AddressFormScreen(),
      binding: AddressFormControllerBinding(),
    ),
  ];
}
