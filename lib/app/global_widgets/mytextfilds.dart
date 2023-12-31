// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karpardaz/core/values/values.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';

import '../modules/drivers/repository.dart';
import 'mytexts.dart';

class myTextField extends StatelessWidget {
  String? hintText;
  FaIcon? icon;
  TextEditingController? controller;
  TextInputType keyboardType;
  bool enabled;
  int maxLength;
  bool isPassword;
  bool isError;
  List<TextInputFormatter>? inputFormatters;
  final onChanged;
  final onSaved;
  final onTap;
  final onEditingComplete;
  final onTapOutside;
  final onFieldSubmitted;

  myTextField({
    super.key,
    this.isPassword = false,
    this.isError = false,
    this.hintText,
    this.icon,
    this.maxLength = 64,
    this.controller,
    this.enabled = true,
    this.keyboardType = TextInputType.name,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenWidth / 7,
      decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.white60,
          borderRadius: const BorderRadius.all(Radius.circular(40)),
          boxShadow: enabled
              ? [
                  isError
                      ? const BoxShadow(
                          color: Colors.red,
                          blurRadius: 3,
                          spreadRadius: 2,
                          offset: Offset(0, 0))
                      : const BoxShadow(
                          color: Colors.black,
                          blurRadius: 2,
                          spreadRadius: 0.5,
                          offset: Offset(0, 1)),
                ]
              : []),
      child: Stack(
        children: [
          (icon != null)
              ? Container(
                  width: screenWidth / 7,
                  height: screenWidth / 7,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: Languages.isPersian
                        ? const BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          )
                        : const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(0),
                            bottomRight: Radius.circular(0),
                          ),
                  ),
                  child: icon,
                )
              : const SizedBox(),
          TextFormField(
            textAlign: TextAlign.start,
            obscureText: isPassword,
            controller: controller,
            enabled: enabled,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSaved: onSaved,
            onTap: onTap,
            onEditingComplete: onEditingComplete,
            onTapOutside: onTapOutside,
            onFieldSubmitted: onFieldSubmitted,
            inputFormatters: inputFormatters,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'vazir',
              fontSize: 18,
            ),
            decoration: InputDecoration(
              contentPadding: Languages.isPersian
                  ? const EdgeInsets.fromLTRB(10, 0, 60, 0)
                  : const EdgeInsets.fromLTRB(60, 0, 10, 0),
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Colors.black38,
                fontFamily: 'vazir',
                fontSize: 16,
              ),
              filled: false,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

class creditCardsField extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  TextInputType keyboardType;
  bool enabled;
  bool isPassword;
  bool isError;
  final onChanged;
  final onSaved;
  final onTap;
  final onEditingComplete;
  final onTapOutside;
  final onFieldSubmitted;

  creditCardsField({
    super.key,
    this.isPassword = false,
    this.hintText = 'creditCards_hintText',
    this.controller,
    this.enabled = true,
    this.keyboardType = TextInputType.number,
    this.isError = false,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
  });

  final RxString _bankID = ''.obs;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: screenWidth / 7,
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.white60,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            boxShadow: enabled
                ? [
                    isError
                        ? const BoxShadow(
                            color: Colors.red,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: Offset(0, 0))
                        : const BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            spreadRadius: 0.5,
                            offset: Offset(0, 1)),
                  ]
                : []),
        child: Stack(
          children: [
            Container(
              width: screenWidth / 7,
              height: screenWidth / 7,
              alignment: Alignment.centerRight,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Obx(
                () => Image.asset(
                  creditCardBankLogo[_bankID.value] ??
                      'assets/images/resizekarpardazlogo.png',
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                ),
              ),
            ),
            TextFormField(
              textAlign: TextAlign.start,
              obscureText: isPassword,
              controller: controller,
              enabled: enabled,
              keyboardType: keyboardType,
              onChanged: (q) {
                if (q.length >= 6) {
                  _bankID.value = q.substring(0, 6);
                } else if (q.length < 6) {
                  _bankID.value = '';
                }
              },
              onSaved: (q) {
                if (q!.length >= 6) {
                  _bankID.value = q.substring(0, 6);
                } else if (q.length < 6) {
                  _bankID.value = '';
                }
              },
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              onTapOutside: onTapOutside,
              onFieldSubmitted: (q) {
                if (q.length >= 6) {
                  _bankID.value = q.substring(0, 6);
                } else if (q.length < 6) {
                  _bankID.value = '';
                }
              },
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'vazir',
                fontSize: 18,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(60, 0, 10, 0),
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Colors.black38,
                  fontFamily: 'vazir',
                  fontSize: 16,
                ),
                filled: false,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IBANField extends StatelessWidget {
  String hintText;
  TextEditingController? controller;
  TextInputType keyboardType;
  bool enabled;
  int maxLength;
  bool isPassword;
  bool isError;
  final onChanged;
  final onSaved;
  final onTap;
  final onEditingComplete;
  final onTapOutside;
  final onFieldSubmitted;

  IBANField({
    super.key,
    this.isPassword = false,
    this.hintText = 'creditCards_hintText',
    this.maxLength = 16,
    this.controller,
    this.enabled = true,
    this.isError = false,
    this.keyboardType = TextInputType.number,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onTap,
    this.onTapOutside,
  });

  final RxString _bankID = ''.obs;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height: screenWidth / 7,
        decoration: BoxDecoration(
            color: enabled ? Colors.white : Colors.white60,
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            boxShadow: enabled
                ? [
                    isError
                        ? const BoxShadow(
                            color: Colors.red,
                            blurRadius: 3,
                            spreadRadius: 2,
                            offset: Offset(0, 0))
                        : const BoxShadow(
                            color: Colors.black,
                            blurRadius: 2,
                            spreadRadius: 0.5,
                            offset: Offset(0, 1)),
                  ]
                : []),
        child: Stack(
          children: [
            Container(
              width: screenWidth / 7,
              height: screenWidth / 7,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Obx(
                () => Image.asset(
                  creditCardIBANBankLogo[_bankID.value] ??
                      'assets/images/resizekarpardazlogo.png',
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                ),
              ),
            ),
            TextFormField(
              textAlign: TextAlign.start,
              obscureText: isPassword,
              controller: controller,
              enabled: enabled,
              keyboardType: keyboardType,
              onChanged: (q) {
                if (q.length >= 7 || q.length >= 5) {
                  if (q.substring(0, 2) != 'IR') {
                    _bankID.value = q.substring(2, 5);
                  } else {
                    _bankID.value = q.substring(4, 7);
                  }
                } else if (q.length < 7 || q.length < 5) {
                  _bankID.value = '';
                }
              },
              onSaved: (q) {
                if (q!.length >= 7 || q.length >= 5) {
                  if (q.substring(0, 2) != 'IR') {
                    _bankID.value = q.substring(2, 5);
                  } else {
                    _bankID.value = q.substring(4, 7);
                  }
                } else if (q.length < 7 || q.length < 5) {
                  _bankID.value = '';
                }
              },
              onTap: onTap,
              onEditingComplete: onEditingComplete,
              onTapOutside: onTapOutside,
              onFieldSubmitted: (q) {
                if (q.length >= 7 || q.length >= 5) {
                  if (q.substring(0, 2) != 'IR') {
                    _bankID.value = q.substring(2, 5);
                  } else {
                    _bankID.value = q.substring(4, 7);
                  }
                } else if (q.length < 7 || q.length < 5) {
                  _bankID.value = '';
                }
              },
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'vazir',
                fontSize: 18,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(60, 0, 10, 0),
                hintText: hintText,
                hintStyle: const TextStyle(
                  color: Colors.black38,
                  fontFamily: 'vazir',
                  fontSize: 16,
                ),
                filled: false,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DatePicker extends StatelessWidget {
  TextEditingController? controller;
  TextInputType keyboardType;
  bool enabled;
  bool isError;
  final RxString _selectedDate =
      '${Jalali.now().year}/${Jalali.now().month}/${Jalali.now().day}'.obs;
  DriverController getController = Get.find();
  final RxString _textDate =
      '${Jalali.now().year}/${Jalali.now().month}/${Jalali.now().day}'.obs;

  Jalali initialDate;
  String? y;
  String? m;
  String? d;

  String get selectedDate => _selectedDate.value;

  DatePicker({
    super.key,
    this.isError = false,
    this.enabled = true,
    this.keyboardType = TextInputType.datetime,
    required this.initialDate,
    required this.controller,
  }) {
    _textDate.value =
        '${initialDate.year}/${initialDate.month}/${initialDate.day}';
  }

  Future<void> _selectDate(BuildContext context) async {
    final Jalali? pickedDate = await showPersianDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: Jalali(1400, 1),
        lastDate: Jalali(1410, 12),
        initialEntryMode: PDatePickerEntryMode.calendarOnly,
        initialDatePickerMode: PDatePickerMode.day,
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              dialogTheme: const DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
              ),
            ),
            child: child!,
          );
        });
    if (pickedDate != null && pickedDate != selectedDate) {
      _textDate.value =
          '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}';
      _selectedDate.value =
          '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}';
      controller!.text = selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
        onTap: () => _selectDate(context),
        child: Container(
            height: screenWidth / 7,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.calendar),
                Obx(() => MyText(
                      text: _textDate.value,
                      color: Colors.black,
                    )),
              ],
            )));
  }
}
