// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, camel_case_types
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karpardaz/core/values/values.dart';

class myTextField extends StatelessWidget {
  String? hintText;
  FaIcon? icon;
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
