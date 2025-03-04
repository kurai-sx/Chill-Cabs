import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      "title": "New Message",
      "description": "You have received a new message from John.",
      "time": "2 min ago",
      "icon": Icons.message,
      "iconColor": Colors.blue,
    },
    {
      "title": "Driver Assigned",
      "description": "Your driver MH 03 SL 0129 has been assigned.",
      "time": "15 min ago",
      "icon": Icons.local_shipping,
      "iconColor": Colors.green,
    },
    {
      "title": "Reminder",
      "description": "Driver arriving soon!",
      "time": "3 mins ago",
      "icon": Icons.alarm,
      "iconColor": Colors.orange,
    },
    {
      "title": "Promotion",
      "description": "50% off on 20+kms travel",
      "time": "5 hours ago",
      "icon": Icons.local_offer,
      "iconColor": Colors.pink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: notifications.isEmpty
          ? Center(
        child: Text(
          'No Notifications',
          style: TextStyle(fontSize: 18.0, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return buildNotificationCard(notifications[index]);
        },
      ),
    );
  }

  Widget buildNotificationCard(Map<String, dynamic> notification) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification['iconColor'],
          child: Icon(
            notification['icon'],
            color: Colors.white,
          ),
        ),
        title: Text(
          notification['title'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        subtitle: Text(notification['description']),
        trailing: Text(
          notification['time'],
          style: TextStyle(fontSize: 12.0, color: Colors.grey),
        ),
      ),
    );
  }
}
