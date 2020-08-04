
import 'dart:convert';
import 'dart:io';

main() async {

  final socket = await ServerSocket.bind('127.0.0.1', 6666);
  print("Listening...");

  try {
    await for (var s in socket) {
      s.listen((values) {
        print('Got data: ${s.remoteAddress}:${s.remotePort} => ${utf8.decode(values)}');
      });
    }
  } finally {
    socket.close();
    print("Closed");
  }

}