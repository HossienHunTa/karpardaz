import 'package:objectbox/objectbox.dart';

@Entity()
class DriverModel {
  @Id()
  int id = 0;
  String driverName;
  String? amount;
  String date;

  DriverModel({
    required this.driverName,
    this.amount,
    required this.date,
  });

  DriverModel.fromJson(Map<String, dynamic> json)
      : driverName = json['driverName'],
        amount = json['amount'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'driverName': driverName,
        'amount': amount,
        'date': date,
      };

  @override
  String toString() {
    return 'Item{id: $id, name: $driverName, creditCardShaba: $amount, date: $date}';
  }
}
