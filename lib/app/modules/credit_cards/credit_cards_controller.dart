import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:karpardaz/app/data/services/repository.dart';
import 'package:karpardaz/core/utils/utils.dart';
import 'package:karpardaz/objectbox.g.dart';

class CreditCardsController extends GetxController {
  late TextEditingController textCreditCardsNumberController,
      textCreditCardsNameController,
      textCreditCardsIBANController,
      textUpdateCreditCardsNumberController,
      textUpdateCreditCardsNameController,
      textUpdateCreditCardsIBANController;
  late Box<CreditCardModel> _creditCardBox;
  RxList<CreditCardModel> itemList = <CreditCardModel>[].obs;
  final ObjectBoxService _objectBoxService = Get.find();
  final CreditCardBackupService creditCardBackupService = Get.find();
  final RxBool _creditCardsFieldError = false.obs;
  final RxBool _ibanFieldError = false.obs;
  final RxBool _nameFieldError = false.obs;
  final RxBool _isLoadingVertical = false.obs;
  final textCreditCardsNumber = ''.obs;
  final textCreditCardsName = ''.obs;
  final textCreditCardsShaba = ''.obs;

  bool get creditCardsFieldError => _creditCardsFieldError.value;

  bool get ibanFieldError => _ibanFieldError.value;

  bool get nameFieldError => _nameFieldError.value;

  bool get isLoadingVertical => _isLoadingVertical.value;

  @override
  void onInit() async {
    super.onInit();
    textCreditCardsNumberController = TextEditingController();
    textCreditCardsNameController = TextEditingController();
    textCreditCardsIBANController = TextEditingController();
    textUpdateCreditCardsNumberController = TextEditingController();
    textUpdateCreditCardsNameController = TextEditingController();
    textUpdateCreditCardsIBANController = TextEditingController();
    textCreditCardsIBANController.text = 'IR';
    _creditCardBox = _objectBoxService.creditCardBox;
    itemList.assignAll(_creditCardBox.getAll());
  }

  @override
  void onClose() {
    textCreditCardsNumberController.dispose();
    textCreditCardsNameController.dispose();
    textCreditCardsIBANController.dispose();
    textUpdateCreditCardsNumberController.dispose();
    textUpdateCreditCardsNameController.dispose();
    textUpdateCreditCardsIBANController.dispose();
    creditCardBackupService.onClose();
    super.onClose();
  }

  Future loadMore() async {
    _isLoadingVertical.value = true;
  }

  void onBackup() {
    creditCardBackupService.creditCardsBackup(_creditCardBox.getAll());
  }

  void onRestore() async {
    final list = await creditCardBackupService.creditCardsRestore();
    if (list == [] || list.isEmpty) {
      onBackup();
    } else {
      _creditCardBox.removeAll();
      _creditCardBox.putMany(list);
      itemList.assignAll(_creditCardBox.getAll());
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
    itemList.assignAll(_creditCardBox.getAll());
  }

  void btnDelete(int id) async {
    final index = itemList.indexWhere((element) => element.id == id);
    _creditCardBox.remove(id);
    itemList.removeAt(index);
    onUpdate();
  }

  void btnSubmit() async {
    var iban = fixIBAN(textCreditCardsIBANController.text);
    if (validateTextCreditCardsNumber(textCreditCardsNumberController.text)) {
      if (validateTextCreditCardsIBAN(iban)) {
        iban = fixIBAN('IR');
        if (textCreditCardsNameController.text.length >= 3) {
          if (validateTextCreditCardsNumber(
                  textCreditCardsNumberController.text) ||
              validateTextCreditCardsIBAN(iban)) {
            _creditCardsFieldError.value = false;
            _ibanFieldError.value = false;
            _nameFieldError.value = false;
            final item = CreditCardModel(
              creditCardName: textCreditCardsNameController.text,
              creditCardNumber: textCreditCardsNumberController.text,
              creditCardIBAN: iban,
            );
            _creditCardBox.put(item);
            itemList.add(item);
            onUpdate();
            textCreditCardsNameController.clear();
            textCreditCardsNumberController.clear();
            textCreditCardsIBANController.clear();
            textCreditCardsIBANController.text = 'IR';
          } else {
            _creditCardsFieldError.value = true;
            _ibanFieldError.value = true;
          }
        } else {
          _nameFieldError.value = true;
        }
      } else {
        _ibanFieldError.value = true;
      }
    } else {
      _creditCardsFieldError.value = true;
    }
  }

  void btnUpdate(int id) {
    final index = itemList.indexWhere((element) => element.id == id);
    var iban = fixIBAN(textUpdateCreditCardsIBANController.text);
    if (validateTextCreditCardsNumber(
        textUpdateCreditCardsNumberController.text)) {
      if (validateTextCreditCardsIBAN(iban)) {
        iban = fixIBAN('IR');
        if (textUpdateCreditCardsNameController.text.length >= 3) {
          if (validateTextCreditCardsNumber(
                  textUpdateCreditCardsNumberController.text) ||
              validateTextCreditCardsIBAN(iban)) {
            _creditCardsFieldError.value = false;
            _ibanFieldError.value = false;
            _nameFieldError.value = false;
            itemList[index].creditCardName =
                textUpdateCreditCardsNameController.text;
            itemList[index].creditCardNumber =
                textUpdateCreditCardsNumberController.text;
            itemList[index].creditCardIBAN = iban;
            _creditCardBox.put(itemList[index]);
            Get.back();
            onUpdate();
            textUpdateCreditCardsNameController.clear();
            textUpdateCreditCardsNumberController.clear();
            textUpdateCreditCardsIBANController.clear();
          } else {
            _creditCardsFieldError.value = true;
            _ibanFieldError.value = true;
          }
        } else {
          _nameFieldError.value = true;
        }
      } else {
        _ibanFieldError.value = true;
      }
    } else {
      _creditCardsFieldError.value = true;
    }
  }
}
