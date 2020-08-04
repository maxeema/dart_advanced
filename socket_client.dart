
import 'dart:io';

main() async {

  final socket = await Socket.connect('127.0.0.1', 6666);
  try {
    print("Connected to "
        "${socket.remoteAddress}:${socket.remotePort}");

    socket.write("${DateTime.now()}: Dart is super awesome!");
    print("Sent data");
  } finally {
    await socket.close();
    print("Client closed");
  }

}