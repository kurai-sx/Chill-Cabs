import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class VintageBookingPage extends StatefulWidget {
  final String carType;
  final String category;

  VintageBookingPage({required this.carType, required this.category});

  @override
  _VintageBookingPageState createState() => _VintageBookingPageState();
}

class _VintageBookingPageState extends State<VintageBookingPage> {
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  String? _selectedCar;
  List<String> availableCars = ["Mustang 1969", "Corvetta", "Honda Civic", "Ambassador", "Ferrari"];
  int _bookingId = 1;

  void _bookRide() async {
    if (_pickupController.text.isEmpty || _dropoffController.text.isEmpty || _selectedCar == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please enter all details"))
      );
      return;
    }

    await _saveToExcel(_pickupController.text, _dropoffController.text, _selectedCar!, "Successful");

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("🚗 Ride booked for ${widget.carType} from ${_pickupController.text} to ${_dropoffController.text}!"))
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  Future<void> _saveToExcel(String pickup, String dropoff, String car, String status) async {
    var statusPermission = await Permission.manageExternalStorage.request();

    if (statusPermission.isGranted) {
      print("✅ Storage permission granted!");

      Directory directory = Directory("/storage/emulated/0/Download/Booking_Data");
      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      String filePath = "${directory.path}/MV_Bookings.xlsx";
      File file = File(filePath);
      Excel excel;
      Sheet sheetObject;

      if (file.existsSync()) {
        List<int> bytes = file.readAsBytesSync();
        excel = Excel.decodeBytes(bytes);
        print("📂 Loaded existing Excel file.");
        sheetObject = excel['Bookings'];

        // Get the last booking ID and increment it
        if (sheetObject.rows.length > 1) {
          var lastRow = sheetObject.rows.last;
          var lastIdCell = lastRow[0];

          if (lastIdCell != null && lastIdCell.value != null) {
            try {
              _bookingId = int.parse(lastIdCell.value.toString()) + 1;
            } catch (e) {
              print("❌ Error parsing booking ID: $e. Resetting to 1.");
              _bookingId = 1;
            }
          } else {
            print("⚠️ No valid last ID found. Starting from 1.");
            _bookingId = 1;
          }
        }
      } else {
        excel = Excel.createExcel();
        print("🆕 Creating new Excel file.");
        sheetObject = excel['Bookings'];
        sheetObject.appendRow([
          TextCellValue("ID"),
          TextCellValue("Pickup Location"),
          TextCellValue("Drop-off Location"),
          TextCellValue("Car Selected"),
          TextCellValue("Status")
        ]);
      }

      sheetObject.appendRow([
        TextCellValue(_bookingId.toString()),
        TextCellValue(pickup),
        TextCellValue(dropoff),
        TextCellValue(car),
        TextCellValue(status)
      ]);

      file.writeAsBytesSync(excel.encode()!);
      print("✅ Excel file saved in: $filePath");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Booking saved in Downloads folder!")),
      );
    } else {
      print("❌ Storage permission denied! Redirecting to settings...");
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout ${widget.carType}"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField("From", "Enter Pickup Location", _pickupController),
            _buildInputField("To", "Enter Destination", _dropoffController),
            _buildPaymentMethod(),
            _buildCarSelection(),
            _buildConfirmButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _bookRide,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text("Confirm Booking", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[100],
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return ListTile(
      title: Text("PAYMENT", style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text("Debit card, Credit Card, UPI"),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {},
    );
  }

  Widget _buildCarSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Select Car Type", style: TextStyle(fontWeight: FontWeight.bold)),
        Wrap(
          spacing: 10,
          children: availableCars.map((car) => ChoiceChip(
            label: Text(car),
            selected: _selectedCar == car,
            onSelected: (selected) {
              setState(() {
                _selectedCar = selected ? car : null;
              });
            },
          )).toList(),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
