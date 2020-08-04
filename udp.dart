
import 'dart:convert';
import 'dart:io';

import 'extensions.dart';

main() async {

  final data = 'Dart is a super dev lang!';

  // server
  RawDatagramSocket.bind(InternetAddress.loopbackIPv4, 6666).then((RawDatagramSocket udpSocket) {
    udpSocket.listen((RawSocketEvent event) {
      if (event == RawSocketEvent.read) {
        final dg = udpSocket.receive();
        print('got data on socket: ${utf8.decode(dg.data)}');
      }
    });
    
    // client
    udpSocket.send(data.encodeAsUtf8(), udpSocket.address, udpSocket.port);
  });

}