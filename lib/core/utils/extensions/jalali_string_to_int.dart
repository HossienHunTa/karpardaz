import 'package:persian_datetime_picker/persian_datetime_picker.dart';

Jalali jalaliStringToInt(String date) {
  final rex = RegExp(r'^(\d+)\/(\d+)\/(\d+)$');
  final res = rex.firstMatch(date);
  if (res!.groupCount > 0) {
    int y = int.parse(res.group(1)!);
    int m = int.parse(res.group(2)!);
    int d = int.parse(res.group(3)!);
    return Jalali(y, m, d);
  } else {
    return Jalali.now();
  }
}
