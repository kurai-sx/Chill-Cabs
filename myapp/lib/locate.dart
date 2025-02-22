import 'dart:ffi';

import 'package:flutter/material.dart';

class Locate extends StatelessWidget {
  final List<String> shopNames = [
    'Lucky Plaza',
    'The Book Haven',
    'Tech World',
    'Gourmet Treats',
    'Fashion Hub'
  ];
  final List<String> ShopDescriptions = [
    'Clothing Store',
    'Branded clothes available',
    'All you need is here!',
    'Get your favourite fashion clothes',
    'Korean clothes available'
  ];
  final List<double> shopRatings = [
    4.3,
    4.6,
    4.7,
    4.9,
    3.9,

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Live Location'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          // Map image covering more than half of the screen
          Expanded(
            flex: 4, // Adjust this for the proportion (7/10 of the screen height)
            child: Stack(
              children: [
                // Static map image (replace with your map image)
                Image.asset(
                  'images/maps.png', // Replace with the path to your map image
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Add markers (simulate with Positioned widgets)
                Positioned(
                  top: 150, // Y position of the marker on the map (adjust as per your image)
                  left: 120, // X position of the marker on the map (adjust as per your image)
                  child: Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30.0,
                  ),
                ),
                Positioned(
                  top: 100, // Y position of the second marker
                  left: 250, // X position of the second marker
                  child: Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 30.0,
                  ),
                ),
              ],
            ),
          ),
          // Scrollable list of nearby shops and Popular Places text inside the same container
          Expanded(
            flex: 3, // Adjust this for the proportion (3/10 of the screen height)
            child: Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  // Popular places text
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                    child: Text(
                      'Popular places on the way! 😊',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Scrollable list of shops
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.all(10.0),
                      itemCount: 5, // Number of items in the list
                      itemBuilder: (context, index) {
                        return buildShopCard(index);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget to build individual shop cards
  Widget buildShopCard(int index) {
    return Container(
      width: 250.0, // Width of each shop card
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Shop image - large size
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
            child: Image.asset(
              'images/shop1.jpg', // Replace with actual shop images
              height: 100.0, // Large image size
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shopNames[index], // Dynamic shop name
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 5.0),
                // Ratings
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20.0,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      '${shopRatings[index].toStringAsFixed(1)}',// Example rating
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.0),
                // Shop details (distance, etc.)
                Text(
                  '${(index + 1) * 0.5} km away', // Example distance
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                SizedBox(height: 10.0),
                // Description (optional)
                Text(
                  ShopDescriptions[index], // Example description
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
