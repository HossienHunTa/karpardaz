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

class DriverBackupService extends GetxService {
  late Supabase supabase;

  @override
  Future<void> onInit() async {
    super.onInit();
    supabase = Supabase.instance;
  }

  @override
  void onClose() {
    super.onClose();
  }

  void driverBackup(itemList) async {
    if (itemList != []) {
      List<Map<String, dynamic>> newList = [];
      for (var v in itemList) {
        await supabase.client
            .from('driver')
            .delete()
            .eq('driverName', v.driverName)
            .select('*');
        newList.add({
          'driverName': v.driverName,
          'driverCreditCard': v.driverCreditCard,
          'amount': v.amount,
          'date': v.date
        });
      }
      await supabase.client.from('driverName').insert(newList);
    }
  }

  Future<List<DriverModel>> driverRestore() async {
    final list = await supabase.client.from('driver').select('*');
    List<DriverModel> newList = [];
    for (var v in list) {
      newList.add(DriverModel.fromJson(v));
    }
    return newList;
  }
}
