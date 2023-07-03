// ignore_for_file: must_be_immutable, avoid_returning_null_for_void, avoid_print, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:karpardaz/core/values/credit_card.dart';

import 'widget.dart';

class MyItem extends StatelessWidget {
  MyItem({
    super.key,
    this.icon = const FaIcon(FontAwesomeIcons.info),
    this.text = 'test',
    this.desc = 'null',
    this.onTap,
  });

  FaIcon icon;
  String text;
  String desc;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              gradient: LinearGradient(
                colors: [Color(0xffFFBB29), Color(0xffFE8910)],
                tileMode: TileMode.decal,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                )
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 15, 5),
                      child: icon)),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 0, 5),
                child: SizedBox(
                  width: 250.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MyText(text: text.tr),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: Text(
                          desc.tr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "iransans",
                            fontSize: 12,
                            height: 1.8,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreditCardItem extends StatelessWidget {
  CreditCardItem({
    super.key,
    required this.creditCardsName,
    this.creditCardsNumber,
    this.creditCardsIBAN,
    this.onDelete,
    this.onUpdate,
  }) {
    if (creditCardsNumber!.length == 16) {
      _bankLogo = creditCardBankLogo[creditCardsNumber!.substring(0, 6)]!;
    } else if (creditCardsIBAN!.length == 28 &&
        creditCardsIBAN != 'IR00000000000000000000000000') {
      _bankLogo = creditCardBankLogo[creditCardsIBAN!.substring(4, 7)]!;
    } else {
      _bankLogo = 'assets/images/resizekarpardazlogo.png';
    }
  }

  final String creditCardsName;
  final String? creditCardsNumber;
  final String? creditCardsIBAN;
  late String _bankLogo;
  final onDelete;
  final onUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 5.0, 2, 5),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [Color(0xffFFBB29), Color(0xffFE8910)],
              tileMode: TileMode.decal,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            _bankLogo,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: onDelete,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.white,
                                  )),
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: onUpdate,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.edit,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )
                      ],
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 250.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(text: creditCardsName),
                    (creditCardsNumber!.isNotEmpty)
                        ? InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(text: creditCardsNumber!),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("copyText".tr),
                              ));
                            },
                            child: MyText(
                              text:
                                  "${creditCardsNumber!.substring(0, 4)}-${creditCardsNumber!.substring(4, 8)}-${creditCardsNumber!.substring(8, 12)}-${creditCardsNumber!.substring(12, 16)}",
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(text: creditCardsNumber!),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("copyText".tr),
                            ));
                          },
                          child: Text(
                            creditCardsIBAN!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "iransans",
                              fontSize: 12,
                              height: 1.8,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DriverItem extends StatelessWidget {
  const DriverItem({
    super.key,
    required this.name,
    this.amount,
    required this.date,
    this.onDelete,
    this.onUpdate,
  });

  final String name;
  final String? amount;
  final String? date;
  final onDelete;
  final onUpdate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(2, 5.0, 2, 5),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            gradient: LinearGradient(
              colors: [Color(0xffFFBB29), Color(0xffFE8910)],
              tileMode: TileMode.decal,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 2.0,
              )
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 5, 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(
                            'assets/images/resizekarpardazlogo.png',
                            width: 80,
                            height: 80,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: IconButton(
                                  onPressed: onDelete,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.trash,
                                    color: Colors.white,
                                  )),
                            ),
                            Expanded(
                              child: IconButton(
                                  onPressed: onUpdate,
                                  icon: const FaIcon(
                                    FontAwesomeIcons.edit,
                                    color: Colors.white,
                                  )),
                            )
                          ],
                        )
                      ],
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                width: 250.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MyText(text: name),
                    (amount!.isNotEmpty)
                        ? InkWell(
                            onTap: () {
                              Clipboard.setData(
                                ClipboardData(
                                    text: 'driverCopy'.trParams({
                                  'amount': amount!,
                                  'date': date!,
                                  'name': name
                                })),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("copyText".tr),
                              ));
                            },
                            child: MyText(
                              text: (amount!.isNotEmpty)
                                  ? '$amount ریال'
                                  : 'notAmount'.tr,
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                        ),
                        child: InkWell(
                          onTap: () {
                            Clipboard.setData(
                              ClipboardData(
                                  text: 'driverCopy'.trParams({
                                'amount': amount!,
                                'date': date!,
                                'name': name
                              })),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("copyText".tr),
                            ));
                          },
                          child: Text(
                            date!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "iransans",
                              fontSize: 18,
                              height: 1.8,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
