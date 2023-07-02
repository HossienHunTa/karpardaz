import 'package:get/get.dart';
import 'package:karpardaz/app/data/services/repository.dart';

import 'repository.dart';

class DriverBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<DriverController>(() => DriverController());
    Get.lazyPut<DriverBackupService>(() => DriverBackupService());
  }
}
