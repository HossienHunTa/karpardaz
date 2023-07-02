import 'package:get/get.dart';
import 'package:karpardaz/app/modules/credit_cards/repository.dart';
import 'package:karpardaz/app/modules/drivers/repository.dart';
import 'package:karpardaz/app/modules/home/repository.dart';

part 'routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;

  // static GetPage UNKNOWN = GetPage(
  //   name: _Paths.UNKNOWN,
  //   page: () => const UnknownView(),
  //   binding: UnknownBinding(),
  // );

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.creditCards,
      page: () => const CreditCardsView(),
      binding: CreditCardsBinding(),
    ),
    GetPage(
      name: _Paths.driver,
      page: () => const DriverView(),
      binding: DriverBinding(),
    ),
  ];
}
