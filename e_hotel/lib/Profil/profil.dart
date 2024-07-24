import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedAvatar = 'assets/avataaars men.svg'; // Default avatar
  String? fullName;
  String? email;
  String? phoneNumber;

  final List<String> _avatars = [
    'assets/avataaars men.svg',
    'assets/avataaars men 02.svg',
    'assets/avataaars men 03.svg',
    'assets/avataaars men 04.svg',
    'assets/avataaars men 05.svg',
    'assets/avataaars men 06.svg',
    'assets/avataaars Women .svg',
    'assets/avataaars Women 02.svg',
    'assets/avataaars Women 03.svg',
    'assets/avataaars Women 05.svg',
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final storage = FlutterSecureStorage();
    fullName = await storage.read(key: 'full_name');
    email = await storage.read(key: 'email');
    phoneNumber = await storage.read(key: 'phone_number');
    setState(() {});
  }

  void _chooseAvatar() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _avatars.length,
              itemBuilder: (context, index) {
                String avatar = _avatars[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAvatar = avatar;
                    });
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset(
                    avatar,
                    fit: BoxFit.cover,
                    placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAvatar() {
    try {
      return SvgPicture.asset(
        _selectedAvatar,
        fit: BoxFit.cover,
      );
    } catch (e) {
      return Icon(Icons.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: fullName == null || email == null || phoneNumber == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: _chooseAvatar,
                            child: Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  //color: Colors.black,
                                  width: 1.5,
                                ),
                              ),
                              child: ClipOval(
                                child: _buildAvatar(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            fullName ?? 'Name not available',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "$email | $phoneNumber",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              // Add functionality for editing profile information
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Edit Profile Information",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add functionality for showing notifications
                            },
                            icon: const Icon(
                              Icons.notifications,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Notification",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add functionality for changing language
                            },
                            icon: const Icon(
                              Icons.language_outlined,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Language",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Card(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              // Add functionality for managing security settings
                            },
                            icon: const Icon(
                              Icons.security,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Security",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add functionality for accessing help & support
                            },
                            icon: const Icon(
                              Icons.help,
                              color: Colors.black,
                            ),
                            label: const Text(
                              "Help & Support",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              // Add functionality for contacting support
                            },
                            icon: const Icon(Icons.contact_support,
                                color: Colors.black),
                            label: const Text(
                              "Contact us",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80,
                  ),
                ],
              ),
            ),
    );
  }
}
