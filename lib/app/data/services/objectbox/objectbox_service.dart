import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:karpardaz/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ObjectBoxService extends GetxService {
  late final Store _store;
  late final Box<CreditCardModel> _creditCardBox;
  late final Box<DriverModel> _driverBox;
  late String path;

  Box<CreditCardModel> get creditCardBox => _creditCardBox;

  Box<DriverModel> get driverBox => _driverBox;

  Future<void> openBoxes() async {
    final directory = await getApplicationDocumentsDirectory();
    path = join(directory.path, 'karpardaz');

    _store = Store(getObjectBoxModel(), directory: path);
    _creditCardBox = _store.box<CreditCardModel>();
    _driverBox = _store.box<DriverModel>();
  }

  void backupDatabaseObjBox() async {
    await Share.shareXFiles([XFile('$path/data.mdb'), XFile('$path/lock.mdb')],
        text: 'DataBase Karpardaz Application');
  }

  Future<bool> restoreDatabaseObjBox() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path as String);
      print(file.path);
      file.copy('$path/data.mdb');
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await openBoxes();
  }

  @override
  void onClose() {
    _store.close();
    super.onClose();
  }
}
