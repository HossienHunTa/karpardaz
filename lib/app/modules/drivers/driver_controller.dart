import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:karpardaz/app/data/services/repository.dart';
import 'package:karpardaz/core/utils/utils.dart';
import 'package:karpardaz/objectbox.g.dart';

class DriverController extends GetxController {
  late TextEditingController textDriverCreditCardsNumberController,
      textDriverNameController,
      textAmountController,
      textDateController,
      textUpdateDriverNameController,
      textUpdateDriverCreditCardsNumberController,
      textUpdateAmountController,
      textUpdateDateController;
  late Box<DriverModel> _driverBox;
  RxList<DriverModel> itemList = <DriverModel>[].obs;
  final ObjectBoxService _objectBoxService = Get.find();
  final DriverBackupService driverBackupService = Get.find();
  final RxBool _creditCardsFieldError = false.obs;
  final RxBool _amountFieldError = false.obs;
  final RxBool _dateFieldError = false.obs;
  final RxBool _nameFieldError = false.obs;
  final RxBool _isLoadingVertical = false.obs;
  final textDriverCreditCardsNumber = ''.obs;
  final textDriverName = ''.obs;
  final textAmount = ''.obs;
  final textDate = DateTime.now();

  bool get creditCardsFieldError => _creditCardsFieldError.value;

  bool get amountFieldError => _amountFieldError.value;

  bool get dateFieldError => _dateFieldError.value;

  bool get nameFieldError => _nameFieldError.value;

  bool get isLoadingVertical => _isLoadingVertical.value;

  @override
  void onInit() async {
    super.onInit();
    textDriverNameController = TextEditingController();
    textDriverCreditCardsNumberController = TextEditingController();
    textAmountController = TextEditingController();
    textDateController = TextEditingController();
    textUpdateDriverNameController = TextEditingController();
    textUpdateDriverCreditCardsNumberController = TextEditingController();
    textUpdateAmountController = TextEditingController();
    textUpdateDateController = TextEditingController();
    _driverBox = _objectBoxService.driverBox;
    onUpdate();
  }

  @override
  void onClose() {
    textDriverCreditCardsNumberController.dispose();
    textDriverNameController.dispose();
    textAmountController.dispose();
    textDateController.dispose();
    textUpdateDriverNameController.dispose();
    textUpdateDriverCreditCardsNumberController.dispose();
    textUpdateAmountController.dispose();
    textUpdateDateController.dispose();
    super.onClose();
  }

  Future loadMore() async {
    _isLoadingVertical.value = true;
  }

  void onBackup() {
    driverBackupService.driverBackup(_driverBox.getAll());
  }

  void onRestore() async {
    final list = await driverBackupService.driverRestore();
    if (list == [] || list.isEmpty) {
      onBackup();
    } else {
      _driverBox.removeAll();
      _driverBox.putMany(list);
      onUpdate();
    }
  }

  bool validateTextCreditCardsNumber(String value) {
    if (value.length == 16) {
      if (testCreditCardBank(value) && testCreditCardNumber(value)) {
        return true;
      }
    }
    return false;
  }

  bool validateTextCreditCardsIBAN(String value) {
    if (value.length == 26) {
      if (testCreditCardIBANBank(value) && testCreditCardIBAN(value)) {
        return true;
      }
    }
    return false;
  }

  void onUpdate() {
    itemList.assignAll(_driverBox.getAll());
  }

  void btnDelete(int id) async {
    final index = itemList.indexWhere((element) => element.id == id);
    _driverBox.remove(id);
    itemList.removeAt(index);
    onUpdate();
  }

  void btnSubmit() async {
    // var iban = fixIBAN(textAmountController.text);
    // if (validateTextCreditCardsNumber(
    //     textDriverCreditCardsNumberController.text)) {
    //   if (validateTextCreditCardsIBAN(iban)) {
    //     iban = fixIBAN('IR');
    //     if (textDriverNameController.text.length >= 3) {
    //       if (validateTextCreditCardsNumber(
    //               textDriverCreditCardsNumberController.text) ||
    //           validateTextCreditCardsIBAN(iban)) {
    //         _creditCardsFieldError.value = false;
    //         _amountFieldError.value = false;
    //         _nameFieldError.value = false;
    //         final item = DriverModel(
    //           driverName: textDriverNameController.text,
    //           driverCreditCard: textDriverCreditCardsNumberController.text,
    //           amount: iban,
    //           // date: textUpdateAmountController.text
    //         );
    //         _driverBox.put(item);
    //         itemList.add(item);
    //         onUpdate();
    //         textDriverNameController.clear();
    //         textDriverCreditCardsNumberController.clear();
    //         textAmountController.clear();
    //       } else {
    //         _creditCardsFieldError.value = true;
    //         _amountFieldError.value = true;
    //       }
    //     } else {
    //       _nameFieldError.value = true;
    //     }
    //   } else {
    //     _amountFieldError.value = true;
    //   }
    // } else {
    //   _creditCardsFieldError.value = true;
    // }
  }

  void btnUpdate(int id) {
    //   final index = itemList.indexWhere((element) => element.id == id);
    //   var iban = fixIBAN(textUpdateCreditCardsIBANController.text);
    //   if (validateTextCreditCardsNumber(textDateController.text)) {
    //     if (validateTextCreditCardsIBAN(iban)) {
    //       iban = fixIBAN('IR');
    //       if (textUpdateCreditCardsNameController.text.length >= 3) {
    //         if (validateTextCreditCardsNumber(textDateController.text) ||
    //             validateTextCreditCardsIBAN(iban)) {
    //           _creditCardsFieldError.value = false;
    //           _ibanFieldError.value = false;
    //           _nameFieldError.value = false;
    //           itemList[index].creditCardName =
    //               textUpdateCreditCardsNameController.text;
    //           itemList[index].creditCardNumber = textDateController.text;
    //           itemList[index].creditCardIBAN = iban;
    //           _creditCardBox.put(itemList[index]);
    //           Get.back();
    //           onUpdate();
    //           textUpdateCreditCardsNameController.clear();
    //           textDateController.clear();
    //           textUpdateCreditCardsIBANController.clear();
    //         } else {
    //           _creditCardsFieldError.value = true;
    //           _ibanFieldError.value = true;
    //         }
    //       } else {
    //         _nameFieldError.value = true;
    //       }
    //     } else {
    //       _ibanFieldError.value = true;
    //     }
    //   } else {
    //     _creditCardsFieldError.value = true;
    //   }
    // }
  }
}
