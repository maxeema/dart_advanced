import 'dart:io';

main() {
  print("okay Dart");
  print(Platform.script.path);
  print(Platform.executable);
  print(Platform.version);
  print(Platform.operatingSystemVersion);
  print(Directory.current);
  print(Platform.environment['PATH']);
//  Platform.environment.keys.forEach((key) {
//    print("${key} = ${Platform.environment[key]}");
//  });
}
