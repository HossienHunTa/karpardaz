import 'package:karpardaz/core/values/values.dart';

bool testCreditCardNumber(String creditCard) {
  int sum = 0;
  for (var i = 0; i < creditCard.length; i++) {
    if ((i == 0) || (i % 2 == 0)) {
      int x = int.parse(creditCard[i]) * 2;
      if (x > 9) {
        sum += x - 9;
      } else {
        sum += x;
      }
    } else {
      int x = int.parse(creditCard[i]) * 1;
      sum += x;
    }
  }
  if (sum % 10 == 0) {
    return true;
  }
  return false;
}

bool testCreditCardBank(String str) {
  if (str.length == 16 && creditCardListBank.contains(str.substring(0, 6))) {
    return true;
  }
  return false;
}

bool testCreditCardIBANBank(String str) {
  if (str.length == 26 &&
      creditCardIBANListBank.contains(str.substring(4, 7))) {
    return true;
  }
  return false;
}

bool testCreditCardIBAN(String creditCardIBAN) {
  if (creditCardIBAN == 'IR000000000000000000000000') {
    return true;
  } else {
    String newShaba =
        '${creditCardIBAN.substring(4, 26)}1827${creditCardIBAN.substring(2, 4)}';
    if (newShaba.length == 26) {
      BigInt x = BigInt.parse(newShaba);
      BigInt y = BigInt.parse('97');
      BigInt result = x % y;
      BigInt expectedAnswer = BigInt.parse('1');
      if (result == expectedAnswer) {
        return true;
      }
    }
    return false;
  }
}

String fixIBAN(String str) {
  if (str.length <= 2) {
    str = 'IR000000000000000000000000';
    if (str.length == 24 && str.substring(0, 2) != 'IR') {
      str = 'IR${str.substring(0, 24)}';
    } else if (str.length == 26 &&
        (str.substring(0, 2) == str.substring(2, 4))) {
      str = 'IR${str.substring(4, 24)}';
    }
  }
  return str;
}
