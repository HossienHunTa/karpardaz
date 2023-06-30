import 'package:get/get.dart';
import 'package:karpardaz/app/data/services/repository.dart';
import 'package:karpardaz/core/values/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'repository.dart';

class CreditCardsBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<CreditCardsController>(() => CreditCardsController());
    Get.lazyPut<CreditCardBackupService>(() => CreditCardBackupService());
    await Supabase.initialize(
      url: Env.supabaseURL,
      anonKey: Env.supabaseKEY,
    );
  }
}
