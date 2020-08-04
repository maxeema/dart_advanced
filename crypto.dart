
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/export.dart';

import 'extensions.dart';

main() {

  final pass = "super password";
  final salt = 'super salt'.encodeAsUtf8().toUint8tList();
  final pkcs = KeyDerivator('SHA-1/HMAC/PBKDF2');
  final params = Pbkdf2Parameters(salt, 100, 16);

  pkcs.init(params);

  final key = pkcs.process(pass.encodeAsUtf8().toUint8tList());

  display('Key value', key);

}

display(String title, Uint8List value) {
  print(title);
  print(value);
  print(value.asBase64String);
  print('');
}
