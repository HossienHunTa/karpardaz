// ignore_for_file: constant_identifier_names

part of 'pages.dart';

abstract class Routes {
  Routes._();

  static const UNKNOWN = _Paths.UNKNOWN;
  static const Splash = _Paths.Splash;
  static const HOME = _Paths.HOME;
  static const WELCOME = _Paths.WELCOME;
  static const creditCards = _Paths.creditCards;
  static const driver = _Paths.driver;
}

abstract class _Paths {
  _Paths._();

  static const UNKNOWN = '/unknown';
  static const Splash = '/splash';
  static const HOME = '/home';
  static const WELCOME = '/welcome';
  static const creditCards = '/creditCards';
  static const driver = '/driver';
}
