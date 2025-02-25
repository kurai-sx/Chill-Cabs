import 'dart:math';
import 'package:flutter/material.dart';

class DriverBookingPage extends StatefulWidget {
  final String driverName;
  final String driverImage;

  DriverBookingPage({required this.driverName, required this.driverImage, required String carModel});

  @override
  _DriverBookingPageState createState() => _DriverBookingPageState();
}

class _DriverBookingPageState extends State<DriverBookingPage> {
  final _pickupController = TextEditingController();
  final _dropoffController = TextEditingController();
  String? _selectedPaymentMethod;
  double? _farePrice;
  List<String> paymentMethods = ["Cash", "UPI", "Credit Card", "Debit Card"];
  List<String> carModels = ["Toyota Innova", "Honda City", "Hyundai Creta", "Ford Endeavour", "Maruti Swift"];
  late String _selectedCarModel;

  @override
  void initState() {
    super.initState();
    _selectedCarModel = carModels[Random().nextInt(carModels.length)];
  }

  void _calculateFare() {
    if (_pickupController.text.isEmpty || _dropoffController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter pickup and dropoff locations first")),
      );
      return;
    }
    setState(() {
      _farePrice = Random().nextDouble() * 50 + 100; // Generates fare between 100 and 150
    });
  }

  void _confirmBooking() {
    if (_pickupController.text.isEmpty || _dropoffController.text.isEmpty || _selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter all details")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("🚖 Taxi booked with ${widget.driverName} ($_selectedCarModel) from ${_pickupController.text} to ${_dropoffController.text}! Fare: \$${_farePrice!.toStringAsFixed(2)}")),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Book a Ride"),
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            Center(
            child: Column(
            children: [
                CircleAvatar(
                backgroundImage: AssetImage(widget.driverImage),
            radius: 50,
          ),
          SizedBox(height: 10),
          Text(widget.driverName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              "Car: $_selectedCarModel",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
      ],
    ),
    ),
    SizedBox(height: 20),
    _buildInputField("Pickup Location", "Enter Pickup Location", _pickupController),
    _buildInputField("Dropoff Location", "Enter Destination", _dropoffController),
    _buildPaymentMethod(),
    _buildFareDisplay(),
    SizedBox(height: 20),
    Center(
    child: ElevatedButton(
    onPressed: (_pickupController.text.isEmpty || _dropoffController.text.isEmpty) ? null : (_farePrice == null ? _calculateFare : _confirmBooking),
    style: ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    child: Text(_farePrice == null ? "Calculate Fare" : "Confirm Booking", style: TextStyle(fontSize: 18, color: Colors.white)),
    ),
    ),
    ],
    ),
    ),
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
          onChanged: (_) {
            setState(() {});
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return DropdownButtonFormField<String>(
      value: _selectedPaymentMethod,
      items: paymentMethods.map((method) => DropdownMenuItem(value: method, child: Text(method))).toList(),
      onChanged: (value) {
        setState(() {
          _selectedPaymentMethod = value;
        });
      },
      decoration: InputDecoration(labelText: "Select Payment Method", border: OutlineInputBorder()),
    );
  }

  Widget _buildFareDisplay() {
    return Center(
      child: Text(
        _farePrice == null ? "Tap Calculate Fare" : "Estimated Fare: \$${_farePrice!.toStringAsFixed(2)}",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }
}
