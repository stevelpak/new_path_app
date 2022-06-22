import 'dart:io';
import 'util.dart';

class App with Utils {
  begin() {
    stdout.write("Please, enter new path: ");
    String chosenPath = stdin.readLineSync()!;
    Map<String, FileStat> files = openDirectory(chosenPath);
    showFiles(files);
  }
}
