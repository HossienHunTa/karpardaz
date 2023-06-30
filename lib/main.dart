import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/services/objectbox/objectbox_service.dart';
import 'package:karpardaz/core/values/values.dart';
import 'package:karpardaz/routes/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    Languages().getLanguageStatus();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Get.putAsync(() async => ObjectBoxService(), permanent: true),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            return GetMaterialApp(
              title: 'application_title'.tr,
              debugShowCheckedModeBanner: false,
              defaultTransition: Transition.fade,
              localizationsDelegates: Languages.localizationsDelegates,
              supportedLocales: Languages.supportedLocales,
              translations: Languages(),
              getPages: AppPages.routes,
              initialRoute: AppPages.initial,
              locale: Languages.isPersian
                  ? const Locale('fa', 'IR')
                  : const Locale('en', 'US'),
              theme: ThemeData(
                fontFamily: 'iransans',
                floatingActionButtonTheme: const FloatingActionButtonThemeData(
                  backgroundColor: Colors.amber,
                  elevation: 0.5,
                  shape: CircleBorder(),
                ),
                buttonTheme: const ButtonThemeData(buttonColor: Colors.amber),
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
                useMaterial3: true,
              ),
            );
          }
        });
  }
}
