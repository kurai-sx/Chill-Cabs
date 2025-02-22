import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0; // Track the current index for the bottom navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Ensures UI resizes when keyboard is shown
      appBar: AppBar(
        automaticallyImplyLeading: false, // Hide the leading icon if you don't need it
        toolbarHeight: 60.0, // Adjust AppBar height
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search for a ride',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(  // Wrap the entire body in a scroll view
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0), // Add vertical padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image below the search bar
              Container(
                margin: EdgeInsets.all(10.0),
                width: 335,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: AssetImage('images/main page.png'), // Update to your image path
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center, // Align text to the center
                  children: [
                    Positioned(
                      top: -5.0, // Position the text at the bottom of the image
                      left: 10.0,
                      right: 10.0,
                      child: Text(
                        'Welcome to Chill Cabs', // Add your desired text
                        style: TextStyle(
                          color: Colors.amber, // White text for visibility
                          fontSize: 25.0, // Set the font size
                          fontWeight: FontWeight.bold, // Optional: Make the text bold
                        ),
                        textAlign: TextAlign.center, // Optional: Center align the text
                      ),
                    ),
                  ],
                ),
              ),
              // Row with "Available" text and arrow icon
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 2.0),
                    Text(
                      "Available",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              // ListView for horizontal scrollable circle buttons
              Container(
                height: 110.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildCircleButton('images/luxury.jpg', 'Luxury', () {
                      print('Luxury button clicked!');
                    }),
                    buildCircleButton('images/vintage.jpg', 'Vintage', () {
                      print('Vintage button clicked!');
                    }),
                    buildCircleButton('images/suv.jpg', 'SUV', () {
                      print('SUV button clicked!');
                    }),
                    buildCircleButton('images/sedan.jpg', 'Sedan', () {
                      print('Sedan button clicked!');
                    }),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 2.0),
                    Text(
                      "Nearby taxis",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 14.0,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              // ListView for horizontal scrollable square buttons
              Container(
                height: 205,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    buildSquareButton('images/man1.jpg', 'Prakash Sharma', () {
                      print('Prakash Sharma Viewed!');
                    }),
                    buildSquareButton('images/man2.jpg', 'Pankaj Rao', () {
                      print('Pankaj Rao Viewed!');
                    }),
                    buildSquareButton('images/man3.jpg', 'Laxman Rathod', () {
                      print('Laxman Rathod Viewed!');
                    }),
                    buildSquareButton('images/man4.jpg', 'Anthony Patil', () {
                      print('Anthony Patil Viewed!');
                    }),
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

// Helper widget for circular buttons
Widget buildCircleButton(String imagePath, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              imagePath,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            label,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    ),
  );
}

// Helper widget for square buttons
Widget buildSquareButton(String imagePath, String label, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 150.0,
              height: 175.0,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            label,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
