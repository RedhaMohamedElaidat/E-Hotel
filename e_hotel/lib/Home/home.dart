import 'dart:convert';
import 'package:e_hotel/Notification/NotificationScreen.dart';
import 'package:e_hotel/Profil/profil.dart';
import 'package:e_hotel/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                "Hi...👋🏻",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          // Red logout button
          TextButton(
            onPressed: () {
              _logout();
            },
            child: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red, // Button background color
              foregroundColor: Colors.white, // Text color
            ),
          ),
          SizedBox(width: 10), // Add some spacing between buttons
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'notification',
                child: Row(
                  children: [
                    Icon(Icons.notifications, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Notifications'),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              } else if (value == 'notification') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationScreen()),
                );
              }
            },
          ),
          SizedBox(width: 10), // Add some spacing between buttons
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          ),
        ],
        leading: SizedBox.shrink(), // Remove the leading back button
      ),
      // Rest of the Home widget's body or other properties
    );
  }

  Future<void> _logout() async {
    final storage = FlutterSecureStorage();
    await storage.deleteAll(); // Clear all secure storage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MAIN()), // Navigate to the main screen
    );
  }
}
