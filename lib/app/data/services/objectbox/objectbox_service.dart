import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:karpardaz/objectbox.g.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxService extends GetxService {
  late final Store _store;
  late final Box<CreditCardModel> _creditCardBox;

  Box<CreditCardModel> get creditCardBox => _creditCardBox;

  Future<void> openBoxes() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'karpardaz');
    _store = Store(getObjectBoxModel(), directory: path);
    _creditCardBox = _store.box<CreditCardModel>();
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
