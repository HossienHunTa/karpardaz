import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'SUPABASEURL', obfuscate: true)
  static String supabaseURL = _Env.supabaseURL;
  @EnviedField(varName: 'SUPABASEKEY', obfuscate: true)
  static String supabaseKEY = _Env.supabaseKEY;
}
