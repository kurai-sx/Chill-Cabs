import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final List<Map<String, dynamic>> driverDetails = [
    {
      'name': 'Prakash Sharma',
      'distance': '1.2 km away',
      'charges': '\$15/hr',
      'rating': '4.5',
      'image': 'images/man1.jpg',
    },
    {
      'name': 'Pankaj Rao',
      'distance': '2.0 km away',
      'charges': '\$18/hr',
      'rating': '4.8',
      'image': 'images/man2.jpg',
    },
    {
      'name': 'Laxman Rathod',
      'distance': '1.8 km away',
      'charges': '\$12/hr',
      'rating': '4.3',
      'image': 'images/man3.jpg',
    },
    {
      'name': 'Anthony Patil',
      'distance': '2.5 km away',
      'charges': '\$20/hr',
      'rating': '4.9',
      'image': 'images/man4.jpg',
    },
    {
      'name': 'Vivek Tiwari',
      'distance': '0.9 km away',
      'charges': '\$10/hr',
      'rating': '4.2',
      'image': 'images/man1.jpg',
    },
    {
      'name': 'Kiran Roy',
      'distance': '3.1 km away',
      'charges': '\$25/hr',
      'rating': '4.7',
      'image': 'images/man2.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nearby Drivers'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            crossAxisSpacing: 13.0,
            mainAxisSpacing: 13.0,
            childAspectRatio: 5 / 2,
          ),
          itemCount: driverDetails.length,
          itemBuilder: (context, index) {
            final driver = driverDetails[index];
            return GestureDetector(
              onTap: () {
                print('${driver['name']} tapped!');
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Background color for each container
                  borderRadius: BorderRadius.circular(20.0),// Curved edges
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      offset: Offset(0, 2),
                      blurRadius: 6.0, // Subtle shadow for effect
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Driver Image
                    // Driver Image
                    Padding(
                      padding: const EdgeInsets.all(8.0), // Adjust the padding to move inward
                      child: ClipOval(
                        child: Image.asset(
                          driver['image'],
                          width: 80.0, // Size of the circular image
                          height: 80.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),


                    SizedBox(width: 10.0),
                    // Driver Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            driver['name'],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            driver['distance'],
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16.0),
                              SizedBox(width: 4.0),
                              Text(
                                driver['rating'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Charges
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        driver['charges'],
                        style: TextStyle(
                          fontSize: 22.0, // Bigger font for charges
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
