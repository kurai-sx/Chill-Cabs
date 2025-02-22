import 'package:flutter/material.dart';
class OtpVerificationPage extends StatefulWidget {
  @override
  _OtpVerificationPageState createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Show success message in Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.green, // Background color of the box
              borderRadius: BorderRadius.circular(50), // Create the oval shape
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline, color: Colors.white), // Check mark icon
                SizedBox(width: 8),
                Text("You're successfully registered!",
                style: TextStyle(color: Colors.white),),
                // Success text
              ],
            ),
          ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        elevation: 1,
      ),
      );
      // Navigate to the Home page after showing the Snackbar
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacementNamed(context, '/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
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
                    color: Colors.red, // Red color for title
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
              // "Enter OTP" text
              Center(
                child: Text(
                  "Enter the OTP sent to your phone",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black text for subtitle
                  ),
                ),
              ),
              SizedBox(height: 30),
              // OTP Input Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      maxLength: 6, // OTP length (6 digits)
                      decoration: InputDecoration(
                        labelText: "Enter OTP",
                        prefixIcon: Icon(Icons.lock, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter the OTP";
                        }
                        if (value.length != 6) {
                          return "OTP must be 6 digits long";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    // Verify Button
                    ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 122), backgroundColor: Colors.black, // Black button background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        "Verify OTP",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Terms and Conditions text with RichText (optional)
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(fontSize: 12, color: Colors.black), // Default text style (black color)
                        children: [
                          TextSpan(
                            text: "By clicking Verify OTP, you agree to our ",
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
