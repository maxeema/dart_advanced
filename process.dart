import 'dart:convert';
import 'dart:io';

main() {
  Process.run("ls", ["-la"], workingDirectory: '/home').then((result) {
    print("");
    print(result.stdout);
    print(result.exitCode);
  }, onError: (err) {
    print('caught error ${err}');
  });
  //
  Process.start('cat', []).then((process) {
    //transform the output
    process.stdout.transform(utf8.decoder).listen((data) {
      print(data);
    });
    //send to the process
    process.stdin.writeln('Okay, Dart');
    //stop the process
    Process.killPid(process.pid);
    //get the exit code
    process.exitCode.then((value) {
      print(value);
      exit(0);
    });
  });
}
