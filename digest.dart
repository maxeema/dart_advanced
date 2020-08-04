
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'extensions.dart';

main() {
  final str = "Okay, Dart";
  Uint8List data = str.encodeAsUtf8().toUint8tList();

  final digest = SHA256Digest();
  final hash = digest.process(data);

  print(hash);
  print(hash.asBase64String);
}
