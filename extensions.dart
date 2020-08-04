
import 'dart:convert';
import 'dart:typed_data';

extension StringExt on String {
  List<int> encodeAsUtf8() => utf8.encode(this);
}
extension ListExtOfInt on List<int> {
  Uint8List toUint8tList() => Uint8List.fromList(this);
}

extension Uint8ListExt on Uint8List {
  String get asBase64String => base64.encode(this);
}