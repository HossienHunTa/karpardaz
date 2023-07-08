# Karpardaz

Karpardaz is an application for doing the daily work of a purchasing manager or an ordinary person.

* For Mobile: https://github.com/HossienHunTa/karpardaz/releases/tag/release (Alpha Version)

## Getting Started

You can customize this program or use it separately as a module in your programs. ([GNU General Public License v3.0](https://github.com/HossienHunTa/karpardaz/blob/master/LICENSE))

## How to Use 

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/HossienHunTa/karpardaz.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies: 

```
flutter pub get 
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter pub run build_runner watch
```

## Karprdaz Features:

* Backup Online && Offline
* Restore Online && Offline
* Jalali Date
* Submit
* Verification
* Validation
* CreditCard
* Drivers
* Share File
* Pick File
* Supabase
* Multi Languages
* Date Convert
### Up-Coming Features:

* Stores
* Bank Checks

### Libraries & Tools Used

* [get](https://pub.dev/packages/get) (State Management)
* [shamsi_date](https://pub.dev/packages/shamsi_date)
* [font_awesome_flutter](https://pub.dev/packages/font_awesome_flutter)
* [flutter_staggered_animations](https://pub.dev/packages/flutter_staggered_animations) 
* [shared_preferences](https://pub.dev/packages/shared_preferences)
* [path_provider](https://pub.dev/packages/path_provider)
* [objectbox](https://pub.dev/packages/objectbox)
* [lazy_load_scrollview](https://pub.dev/packages/lazy_load_scrollview)
* [supabase_flutter](https://pub.dev/packages/supabase_flutter)
* [envied](https://pub.dev/packages/envied)
* [share_plus](https://pub.dev/packages/share_plus)
* [file_picker](https://pub.dev/packages/file_picker)
* [persian_datetime_picker](https://pub.dev/packages/persian_datetime_picker)

### Folder Structure
Here is the core folder structure which flutter provides.

```
karpardaz/
|- android
|- build
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- /app/
|- /core/
|- /routes/
|- main.dart
|- objectbox.g.dart
|- objectbox-model.json
```

### App

This section includes the main parts of the program that have a constructive role, for example: database model, services, communications, status management, user interface, interface management, global widgets, etc.

```
app/
|- /data/
|-     /model/
|-     /provider/
|-     /service/
|- /global_widgets/
|- /modules/
|-     /home/
|-     /drivers/
|-     /credit_cards/
```


### Core

This part includes parts of the program core that play a constructive role, for example: repetitive functions, program language, program appearance, errors, strings and images, interface management, etc.

```
core/
|- /errors/
|- /utils/
|-     /extensions/
|-     /utils.dart
|- /values/
|-     /languages/
|-     /colors.dart
|-     /env.dart
|-     /strings.dart
|-     /credit_card.dart
|-     /values.dart
```

### Routes

This section includes parts of the program path that have a constructive role, for example: entering and returning between pages and transitioning between these pages.

```
routes/
|- pages.dart
|- routes.dart
```


### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/services/objectbox/objectbox_service.dart';
import 'package:karpardaz/core/values/values.dart';
import 'package:karpardaz/routes/pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Supabase.initialize(
    url: Env.supabaseURL,
    anonKey: Env.supabaseKEY,
  );
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

```

## Conclusion

I will be happy to answer any questions that you may have on this approach, and if you want to lend a hand with the karpardaz then please feel free to submit an issue and/or pull request 🙂

Again to note, this is example can appear as over-architectured for what it is - but it is an example only. If you liked my work, don’t forget to ⭐ star the repo to show your support.
