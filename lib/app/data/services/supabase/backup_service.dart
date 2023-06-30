import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CreditCardBackupService extends GetxService {
  late Supabase supabase;

  @override
  Future<void> onInit() async {
    super.onInit();
    supabase = Supabase.instance;
  }

  @override
  void onClose() {
    super.onClose();
    supabase.dispose();
  }

  void creditCardsBackup(itemList) async {
    if (itemList != []) {
      List<Map<String, dynamic>> newList = [];
      for (var v in itemList) {
        await supabase.client
            .from('creditCards')
            .delete()
            .eq('creditCardNumber', v.creditCardNumber)
            .select('*');
        newList.add({
          'creditCardName': v.creditCardName,
          'creditCardNumber': v.creditCardNumber,
          'creditCardIBAN': v.creditCardIBAN
        });
      }
      await supabase.client.from('creditCards').insert(newList);
    }
  }

  Future<List<CreditCardModel>> creditCardsRestore() async {
    final list = await supabase.client.from('creditCards').select('*');
    List<CreditCardModel> newList = [];
    for (var v in list) {
      newList.add(CreditCardModel.fromJson(v));
    }
    return newList;
  }
}
