import 'dart:collection';
import 'dart:io';

import 'package:colorize/colorize.dart';
import 'package:filesize/filesize.dart';

import 'app.dart';

mixin Utils {
  Map<String, FileStat> openedFiles = {};

  Map<String, FileStat> openDirectory(String path) {
    Directory dir = Directory(path);
    List<FileSystemEntity> contents = dir.listSync();
    var contLength = contents.length;
    for (var i = 0; i < contLength; i++) {
      if (contents[i].statSync().type.toString() == "directory") {
        openDirectory(contents[i].path);
      } else {
        openedFiles[contents[i].path] = contents[i].statSync();
      }
    }
    return openedFiles;
  }

  showTable() {
    print(Colorize('''
-----------------------------------------------------------------------------------------------------------------------------
File Name                                     Modified Date                 Size
-----------------------------------------------------------------------------------------------------------------------------
''').bold().italic().lightBlue());
  }

  showFiles(Map<String, FileStat> files) {
    showTable();
    files.forEach((key, value) {
      var fileName = key.split("/").last;
      if (fileName.length > 38) {
        fileName = "${fileName.substring(0, 36)}..";
      } else {
        var difference = 38 - fileName.length;
        String temp = List.filled(difference, " ").join("");
        fileName = "$fileName$temp";
      }

      var modifiedDate = value.modified;
      var fileSize = filesize(value.size);
      print(Colorize("$fileName   -    $modifiedDate  --   $fileSize").green());
    });
    chooseOptions(files);
  }

  chooseOptions(Map<String, FileStat> files) {
    print(Colorize('''
1) Sort by name
2) Sort by date
3) Sort by size

4) Enter new path
5) Exit
''').blue());
    stdout.write(Colorize("Choose type of sort: ").green());
    var sortType = stdin.readLineSync()!;
    showSortedFiles(sortType, files);
  }

  showSortedFiles(String sortType, Map<String, FileStat> files) {
    switch (sortType) {
      case "1":
        clear();
        print(Colorize("Sorted by name").yellow());
        showTable();
        sortByName(files);
        chooseOptions(files);
        break;
      case "2":
        clear();
        print(Colorize("Sorted by time").yellow());
        showTable();
        sortByDate(files);
        chooseOptions(files);
        break;
      case "3":
        clear();
        print(Colorize("Sorted by size").yellow());
        showTable();
        sortBySize(files);
        chooseOptions(files);
        break;
      case "4":
        clear();
        openedFiles = {};
        App().begin();
        break;
      case "5":
        clear();
        exit(0);
      default:
        print(Colorize("I don't know this command").red());
        chooseOptions(files);
    }
  }

  sortBySize(Map<String, FileStat> files) {
    // sorting map by value
    var sortByValue = SplayTreeMap<String, FileStat>.from(
        files, (key1, key2) => files[key1]!.size.compareTo(files[key2]!.size));
    sortByValue.forEach((key, value) {
      var fileName = key.split("/").last;
      if (fileName.length > 38) {
        fileName = "${fileName.substring(0, 36)}..";
      } else {
        var difference = 38 - fileName.length;
        String temp = List.filled(difference, " ").join("");
        fileName = "$fileName$temp";
      }
      var fileSize = filesize(value.size);
      var modifiedDate = value.modified;
      print(Colorize("$fileName   -    $modifiedDate  --   $fileSize").green());
    });
  }

  sortByDate(Map<String, FileStat> files) {
    // sorting map by date
    var sortByValue = SplayTreeMap<String, FileStat>.from(files,
        (key1, key2) => files[key1]!.modified.compareTo(files[key2]!.modified));
    sortByValue.forEach((key, value) {
      var fileName = key.split("/").last;
      if (fileName.length > 38) {
        fileName = "${fileName.substring(0, 36)}..";
      } else {
        var difference = 38 - fileName.length;
        String temp = List.filled(difference, " ").join("");
        fileName = "$fileName$temp";
      }

      var modifiedDate = value.modified;
      var fileSize = filesize(value.size);
      print(Colorize("$fileName   -    $modifiedDate  --   $fileSize").green());
    });
  }

  sortByName(Map<String, FileStat> files) {
    // sorting map by filename
    var sortByValue = SplayTreeMap<String, FileStat>.from(
        files,
        (key1, key2) => key1
            .split("/")
            .last
            .toLowerCase()
            .compareTo(key2.split("/").last.toLowerCase()));
    sortByValue.forEach((key, value) {
      var fileName = key.split("/").last;
      if (fileName.length > 38) {
        fileName = "${fileName.substring(0, 36)}..";
      } else {
        var difference = 38 - fileName.length;
        String temp = List.filled(difference, " ").join("");
        fileName = "$fileName$temp";
      }

      var modifiedDate = value.modified;
      var fileSize = filesize(value.size);
      print(Colorize("$fileName   -    $modifiedDate  --   $fileSize").green());
    });
  }

  clear() {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
