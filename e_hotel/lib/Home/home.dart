import 'package:e_hotel/Notification/NotificationScreen.dart';
import 'package:e_hotel/Profil/profil.dart';
import 'package:e_hotel/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Pour les images SVG
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? fullName;
  String? email;
  String? phoneNumber;
  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final storage = const FlutterSecureStorage();
    fullName = await storage.read(key: 'full_name');
    email = await storage.read(key: 'email');
    phoneNumber = await storage.read(key: 'phone_number');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                "Hi...👋🏻  $fullName",
                style: const TextStyle(fontWeight: FontWeight.bold),
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
            style: TextButton.styleFrom(
              backgroundColor: Colors.red, // Button background color
              foregroundColor: Colors.white, // Text color
            ),
            
            child: Text(
              'Logout',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10), // Add some spacing between buttons
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Profile'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
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
          const SizedBox(width: 10), // Add some spacing between buttons
        ],
        leading: const SizedBox.shrink(), // Remove the leading back button
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context)
              .size
              .height, // Prendre toute la hauteur de l'écran
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, // Espace uniformément entre les éléments
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Faire prendre tout l'écran en largeur
            children: [
              const SizedBox(height: 30), // Espacement avant les boîtes
              _buildBox(context, Colors.blue, "Boîte bleue",
                  "Détails de la boîte bleue"),
              const SizedBox(height: 20), // Espacement entre les boîtes
              _buildBox(context, Colors.red, "Boîte rouge",
                  "Détails de la boîte rouge"),
              const SizedBox(height: 20), // Espacement entre les boîtes
              _buildBox(context, Colors.green, "Boîte verte",
                  "Détails de la boîte verte"),
              const SizedBox(height: 30), // Espacement après les boîtes
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBox(
      BuildContext context, Color color, String title, String details) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _showBoxDetails(context, title, details),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20), // Espacement latéral
          color: color,
          child: Row(
            children: [
              // Image ou icône à gauche
              Container(
                padding: const EdgeInsets.all(10),
                child: SvgPicture.asset(
                  'assets/icon.svg', // Le chemin de votre image SVG
                  width: 150,
                  height: 150,
                ),
              ),
              // Le texte ou autre contenu à droite
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBoxDetails(BuildContext context, String title, String details) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(details),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logout() async {
    final storage = const FlutterSecureStorage();
    await storage.deleteAll(); // Clear all secure storage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => MAIN()), // Navigate to the main screen
    );
  }
}
