import 'package:objectbox/objectbox.dart';

@Entity()
class CreditCardModel {
  @Id()
  int id = 0;
  String creditCardName;
  String? creditCardNumber;
  String? creditCardIBAN;

  CreditCardModel({
    required this.creditCardName,
    this.creditCardNumber,
    this.creditCardIBAN,
  });

  CreditCardModel.fromJson(Map<String, dynamic> json)
      : creditCardName = json['creditCardName'],
        creditCardNumber = json['creditCardNumber'],
        creditCardIBAN = json['creditCardIBAN'];

  Map<String, dynamic> toJson() => {
        'creditCardName': creditCardName,
        'creditCardNumber': creditCardNumber,
        'creditCardIBAN': creditCardIBAN,
      };

  @override
  String toString() {
    return 'Item{id: $id, name: $creditCardName, creditCardNumber: $creditCardNumber, creditCardShaba: $creditCardIBAN}';
  }
}
