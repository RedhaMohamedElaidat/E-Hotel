import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Add functionality for navigating back to the home screen
            Navigator.pop(context);
          },
          child: Text('Back to Home'),
        ),
      ),
    );
  }
}