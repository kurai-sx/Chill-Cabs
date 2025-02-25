import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart';

class ExcelHelper {
  static Future<String> _getFilePath() async {
    final directory = Directory('/storage/emulated/0/Download/Booking_Data'); // Save in Downloads folder
    if (!(await directory.exists())) {
      await directory.create(recursive: true);
    }
    return '${directory.path}/mobile_numbers.xlsx';
  }

  static Future<void> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.request().isGranted ||
          await Permission.storage.request().isGranted) {
        print("✅ Storage permission granted.");
      } else {
        print("❌ Storage permission denied.");
      }
    }
  }

  static Future<void> saveMobileNumber(String mobileNumber) async {
    await requestStoragePermission();

    final filePath = await _getFilePath();
    File file = File(filePath);
    Excel excel;
    String sheetName = "Mobile Numbers";

    if (await file.exists()) {
      var bytes = await file.readAsBytes();
      excel = Excel.decodeBytes(bytes);
    } else {
      excel = Excel.createExcel();
      excel.rename("Sheet1", sheetName);
      Sheet sheet = excel[sheetName];
      sheet.appendRow([TextCellValue("ID"), TextCellValue("Mobile")]);
    }

    Sheet sheet = excel[sheetName];
    int nextId = sheet.rows.length; // Generate ID dynamically
    sheet.appendRow([TextCellValue(nextId.toString()), TextCellValue(mobileNumber)]);

    try {
      List<int> encodedData = excel.encode() ?? [];
      if (encodedData.isNotEmpty) {
        await file.writeAsBytes(encodedData, flush: true);
        print("✅ Mobile number saved in Excel: ID: $nextId, Mobile: $mobileNumber at $filePath");
      } else {
        print("❌ Failed to encode Excel data properly.");
      }
    } catch (e) {
      print("❌ Error saving Excel file: $e");
    }
  }
}
