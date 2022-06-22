// import 'dart:io';

// import 'package:filesize/filesize.dart';
// ///
// ///
// ///
// /// oldingi holatdagi ishlatganlarim
// /// 
// /// 
// /// 
//   start() {
//     var startPath = Directory.current.path.split("/");
//     startPath.removeAt(0);
//     startPath.removeLast();
//     drawer(startPath);
//     stdout.write("Select directory : ");
//     int choice = int.parse(stdin.readLineSync()!);
//     if (choice > startPath.length - 1 || choice < 0) {
//       print("Error: You have selected unavailable number");
//       exit(0);
//     }
//     String selectedPath = startPath.sublist(0, choice + 1).join("/");
//     showFolders("/$selectedPath");
//   }

//   void showFolders(String path) async {
//     try {
//       var dir = Directory(path);
//       List<FileSystemEntity> contents = dir.listSync();
//       var contLength = contents.length;
//       for (var i = 0; i < contLength; i++) {
//         var fileSize = filesize(contents[i].statSync().size);
//         var icon = "🔖";
//         if (contents[i].statSync().type.toString() == "directory") {
//           icon = "📁";
//           print("$i $icon - ${contents[i].path.split("/").last}");
//         } else {
//           print("$i $icon - ${contents[i].path.split("/").last} - $fileSize");
//         }
//       }
//       print("$contLength - ⬅️ BACK");
//       stdout.write("Select directory : ");
//       int choice = int.parse(stdin.readLineSync()!);
//       if (choice > contLength || choice < 0) {
//         print("Error: You have selected unavailable number");
//         exit(0);
//       }
//       if (choice == contLength) {
//         clear();
//         var backPath = contents[choice - 1].path.split("/");
//         backPath.removeLast();
//         backPath.removeLast();
//         showFolders(backPath.join("/"));
//       }
//       if (choice != contLength && File(contents[choice].path).existsSync()) {
//         clear();
//         fileReader(contents[choice].path);
//         exit(0);
//       } else {
//         clear();
//         print(contents[choice].path);
//         showFolders(contents[choice].path);
//       }
//     } on FileSystemException {
//       print("Error: Directory listing failed. Not a directory");
//     } catch (e) {
//       print("Error: $e");
//     }
//   }

//     // String cross = " ├─";
//   // String corner = " └─";
//   // String vertical = " │ ";
//   // String space = "   ";
//   drawer(List<String> dirs) {
//     for (var i = 0; i < dirs.length; i++) {
//       if (dirs[i][0] == ".") continue;
//       String lines = "";
//       String spaces = "";
//       for (var j = 0; j < i; j++) {
//         lines = "$lines-";
//         spaces = "$spaces  ";
//       }
//       var icon = "📁";
//       print("$i$spaces└─$lines $icon${dirs[i]}");
//     }
//   }

//   fileReader(String path) {
//     var file = File(path);
//     Colorize output = Colorize(file.readAsStringSync());
//     print(output.green());
//   }
