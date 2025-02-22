import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart'; // Import the package

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // After validation, navigate to the Home page
      Navigator.pushReplacementNamed(context, '/otp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Full white background
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
              // "Welcome to Chill Cabs" Title
              Center(
                child: Text(
                  "Welcome to Chill Cabs",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red, // Black color for title
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Logo
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white, // White background for logo
                  child: Image.asset(
                    'images/logo.png', // Your logo image
                    fit: BoxFit.cover,
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // "Create an account or sign in"
              Center(
                child: Text(
                  "Create an account or sign in",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Gray text for subtitle
                  ),
                ),
              ),
              SizedBox(height: 30),
              // Phone Number Input Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10, // OTP length (6 digits)
                      decoration: InputDecoration(
                        labelText: "Enter mobile number",
                        prefixIcon: Icon(Icons.phone, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter mobile number";
                        }
                        if (value.length != 10) {
                          return "OTP must be 10 digits long";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    // Continue Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 125), backgroundColor: Colors.black, // Blue button background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Continue",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Terms of Service and Privacy Policy Text with RichText
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 12, color: Colors.black), // Default text style (black color)
                        children: [
                          TextSpan(
                            text: "By clicking Continue, you agree to our ",
                            style: TextStyle(color: Colors.grey), // Light color for the first part
                          ),
                          TextSpan(
                            text: "Terms of Service and Privacy Policy",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Bold and black
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
