
import 'dart:math';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:pointycastle/api.dart';
import 'extensions.dart';

main() {

//  print(randomBytes(8));
  final keyBytes = randomBytes(16);
  final key = KeyParameter(keyBytes);
  final iv = randomBytes(8);
  final params = ParametersWithIV(key, iv);

  final cipher = StreamCipher("Salsa20");
  cipher.init(true, params);

  final plainText = 'Hello world';
  final plainData = plainText.encodeAsUtf8().toUint8tList();

  final encrypted = cipher.process(plainData);

  // Decrypt
  cipher.reset();
  cipher.init(false, params);

  final decrypted = cipher.process(encrypted);

  displayUint8List("Plain text", plainData);
  displayUint8List("Encrypted", encrypted);
  displayUint8List("Decrypted", decrypted);

  final equals = ListEquality().equals;
  assert (equals(plainData, decrypted), "Data and decrypted data should be same");

}

displayUint8List(String title, Uint8List value) {
  print(title);
  print(value);
  print(value.asBase64String);
  print('');
}


Uint8List randomBytes(int length) {

  final rnd = SecureRandom("AES/CTR/AUTO-SEED-PRNG");

  final key = Uint8List(16);
  final keyParam = KeyParameter(key);
  final params = ParametersWithIV(keyParam, Uint8List(16));

  rnd.seed(params);

  final random = Random();

  for (int i=0; i<random.nextInt(255); i++) {
    rnd.nextUint8();
  }

  final bytes = rnd.nextBytes(length);
  return bytes;

}