import 'package:get/get.dart';
import 'package:karpardaz/app/data/services/repository.dart';

class HomeController extends GetxController {
  final ObjectBoxService _objectBoxService = Get.find();
  final RxString _errorMessage = ''.obs;

  String get errorMessage => _errorMessage.value;

  void onBackup() async {
    _objectBoxService.backupDatabaseObjBox();
  }

  void onRestore() async {
    if (await _objectBoxService.restoreDatabaseObjBox()) {
      _errorMessage.value = 'موفقیت امیز بود';
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
