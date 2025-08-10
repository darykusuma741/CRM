import 'dart:async';

import 'package:crm/common/app_theme_data.dart';
import 'package:crm/common/components/custom_scaffold.dart';
import 'package:crm/infrastructure/initial_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  runZonedGuarded(
    () async {
      var initialRoute = await Routes.initialRoute;
      WidgetsFlutterBinding.ensureInitialized();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      runApp(Main(initialRoute));
    },
    (error, stackTrace) => print("Error : $error"),
  );
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      builder: (_, child) {
        return GetMaterialApp(
          // translations: AppTranslation(), // <- inisialisasi terjemahan
          locale: Locale('en', 'US'), // <- default locale
          fallbackLocale: Locale('en', 'US'),
          // locale: Locale('en', 'US'), // <- default locale
          // fallbackLocale: Locale('en', 'US'),
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 300),
          initialRoute: initialRoute,
          getPages: Nav.routes,
          initialBinding: InitialBindings(),
          debugShowCheckedModeBanner: false,
          theme: AppThemeData.primary,
          builder: (context, child) {
            return child ?? CustomScaffold();
          },
        );
      },
    );
  }
}
