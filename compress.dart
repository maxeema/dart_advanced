
import 'dart:convert';
import 'dart:io';

main() {
//  var rand = Random.secure();
  var str = "";
  for (var i =0; i<10000; i++) {
//    final nextInt = rand.nextInt(1<<32);
    str += "test text $i";// + nextInt.toString();
  }
  print('orig length: ${str.length}');
  //
  compress(ZLibCodec(), str);
  compress(GZipCodec(), str);
  //
}

compress(Codec<List<int>, List<int>> codec, String data) {
  final enc = codec.encoder.convert(utf8.encode(data));
  print('${codec.runtimeType}, enc length: ${enc.length}');
  final dec = codec.decode(enc);
  print('${codec.runtimeType}, dec length: ${dec.length}');
  //
  print("${codec.runtimeType}, orig == enc -> dec: ${data == utf8.decode(dec)}");
}