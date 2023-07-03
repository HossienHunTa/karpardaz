import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:karpardaz/app/data/model/repository.dart';
import 'package:karpardaz/app/data/services/repository.dart';
import 'package:karpardaz/objectbox.g.dart';

class DriverController extends GetxController {
  late TextEditingController textDriverNameController,
      textAmountController,
      textDateController,
      textUpdateDriverNameController,
      textUpdateAmountController,
      textUpdateDateController;
  late Box<DriverModel> _driverBox;
  RxList<DriverModel> itemList = <DriverModel>[].obs;
  final ObjectBoxService _objectBoxService = Get.find();
  final DriverBackupService driverBackupService = Get.find();
  final RxBool _amountFieldError = false.obs;
  final RxBool _nameFieldError = false.obs;
  final RxBool _isLoadingVertical = false.obs;
  final RxString e = ''.obs;
  final textDriverCreditCardsNumber = ''.obs;
  final textDriverName = ''.obs;
  final textAmount = ''.obs;

  bool get amountFieldError => _amountFieldError.value;

  bool get nameFieldError => _nameFieldError.value;

  bool get isLoadingVertical => _isLoadingVertical.value;

  @override
  void onInit() async {
    super.onInit();
    textDriverNameController = TextEditingController();
    textAmountController = TextEditingController();
    textDateController = TextEditingController();
    textUpdateDriverNameController = TextEditingController();
    textUpdateAmountController = TextEditingController();
    textUpdateDateController = TextEditingController();
    _driverBox = _objectBoxService.driverBox;
    onUpdate();
  }

  @override
  void onClose() {
    textDriverNameController.dispose();
    textAmountController.dispose();
    textDateController.dispose();
    textUpdateDriverNameController.dispose();
    textUpdateAmountController.dispose();
    textUpdateDateController.dispose();
    super.onClose();
  }

  Future loadMore() async {
    _isLoadingVertical.value = true;
  }

  bool onBackup() {
    try {
      driverBackupService.driverBackup(_driverBox.getAll());
      return true;
    } catch (E) {
      e.value = E.toString();
      return false;
    }
  }

  Future<bool> onRestore() async {
    try {
      final list = await driverBackupService.driverRestore();
      if (list == [] || list.isEmpty) {
        onBackup();
      } else {
        _driverBox.removeAll();
        _driverBox.putMany(list);
        onUpdate();
        return true;
      }
    } catch (E) {
      e.value = E.toString();
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
    final alphanumeric = RegExp(r'^\d{1,3}(,\d{3})*(\.\d+)?$');
    final result = alphanumeric.hasMatch(textAmountController.text);
    if (result) {
      _amountFieldError.value = false;
      if (textDriverNameController.text.length >= 3) {
        _nameFieldError.value = false;
        print(textDateController.text);
        final item = DriverModel(
          driverName: textDriverNameController.text,
          date: textDateController.text,
          amount: textAmountController.text,
        );
        _driverBox.put(item);
        itemList.add(item);
        onUpdate();
        textDriverNameController.clear();
        textAmountController.clear();
      } else {
        _nameFieldError.value = true;
      }
    } else {
      _amountFieldError.value = true;
    }
  }

  void btnUpdate(int id) {
    final index = itemList.indexWhere((element) => element.id == id);
    final alphanumeric = RegExp(r'^\d{1,3}(,\d{3})*(\.\d+)?$');
    final result = alphanumeric.hasMatch(textUpdateAmountController.text);
    if (result) {
      _amountFieldError.value = false;
      if (textUpdateDriverNameController.text.length >= 3) {
        _nameFieldError.value = false;
        itemList[index].driverName = textUpdateDriverNameController.text;
        itemList[index].amount = textUpdateAmountController.text;
        itemList[index].date = textUpdateDateController.text;
        _driverBox.put(itemList[index]);
        Get.back();
        onUpdate();
        textUpdateDriverNameController.clear();
        textUpdateAmountController.clear();
      } else {
        _nameFieldError.value = true;
      }
    } else {
      _amountFieldError.value = true;
    }
  }
}
