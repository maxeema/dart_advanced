
import 'dart:io';

import 'package:archive/archive.dart';
import 'package:path/path.dart' as path;

main(args) {
  final filesToZip = Directory.current.listSync()
      .where((entry) => FileSystemEntity.isFileSync(entry.path))
      .map((e) => e.path)
      .toList();
  final archiveFile = 'archive.zip';
  zip(filesToZip, archiveFile);
  unzip(archiveFile, 'unzipped');
}

zip(List<String> files, String saveAs) {
  final archive = Archive();

  files.forEach((entry) {
    final file = File(entry);
    archive.addFile(ArchiveFile(
        path.basename(file.path), file.lengthSync(), file.readAsBytesSync()));
  });

  File(saveAs).writeAsBytesSync(ZipEncoder().encode(archive));
  
  print("Zipped: $saveAs");
}

unzip(String file, String unzipToPath) {
  Archive arch = ZipDecoder().decodeBytes(File(file).readAsBytesSync());
  arch.forEach((element) {
    final file = File(unzipToPath + "/" + element.name);
    file.createSync(recursive: true);
    file.writeAsBytesSync(element.content);
  });

  print("Unzipped to: $unzipToPath");
}