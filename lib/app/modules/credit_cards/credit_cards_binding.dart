import 'package:get/get.dart';
import 'package:karpardaz/app/data/services/repository.dart';

import 'repository.dart';

class CreditCardsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<CreditCardsController>(() => CreditCardsController());
    Get.lazyPut<CreditCardBackupService>(() => CreditCardBackupService());
  }
}
