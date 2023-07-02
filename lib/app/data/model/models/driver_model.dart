import 'package:objectbox/objectbox.dart';

@Entity()
class DriverModel {
  @Id()
  int id = 0;
  final String driverName;
  final String? driverCreditCard;
  final String? amount;
  @Property(type: PropertyType.date)
  final DateTime date;

  DriverModel({
    required this.driverName,
    this.driverCreditCard,
    this.amount,
    required this.date,
  });

  DriverModel.fromJson(Map<String, dynamic> json)
      : driverName = json['driverName'],
        driverCreditCard = json['driverCreditCard'],
        amount = json['amount'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'driverName': driverName,
        'driverCreditCard': driverCreditCard,
        'amount': amount,
        'date': date,
      };

  @override
  String toString() {
    return 'Item{id: $id, name: $driverName, creditCardNumber: $driverCreditCard, creditCardShaba: $amount, date: $date}';
  }
}
