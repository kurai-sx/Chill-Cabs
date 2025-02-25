import 'package:flutter/material.dart';
import 'excel_helper.dart'; // Import Excel storage helper

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String mobileNumber = _phoneController.text.trim();

      // Save the mobile number in the Excel file
      ExcelHelper.saveMobileNumber(mobileNumber);

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Mobile number saved!"))
      );

      // Navigate to OTP Page
      Navigator.pushReplacementNamed(context, '/otp');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 100),
              Center(
                child: Text(
                  "Welcome to Chill Cabs",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'images/logo.png',
                    fit: BoxFit.cover,
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  "Create an account or sign in",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
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
                          return "Number must be 10 digits long";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 125),
                        backgroundColor: Colors.black,
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
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "By clicking Continue, you agree to our ",
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextSpan(
                            text: "Terms of Service and Privacy Policy",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
