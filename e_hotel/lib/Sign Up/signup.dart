import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert'; // For encoding to JSON
import 'package:http/http.dart' as http; // For making HTTP requests

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _selectedDay;
  String? _selectedMonth;
  String? _selectedYear;

  bool doYouHaveVehicle = false;

  List<String> days = List<String>.generate(31, (i) => (i + 1).toString());
  List<String> months = List<String>.generate(12, (i) => (i + 1).toString());

  List<String> years = List<String>.generate(DateTime.now().year - 1950 + 1, (i) => (1950 + i).toString());
  List<String> colors = ['Red', 'Green', 'Blue', 'Yellow', 'Black', 'White'];

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _idController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    // Retrieve input values
    final fullName = _fullNameController.text;
    final email = _emailController.text;
    final phoneNumber = _phoneNumberController.text;
    final id = _idController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // Validate passwords
    if (password.isEmpty || confirmPassword.isEmpty) {
      _showErrorDialog('Invalid Password', 'Password fields cannot be empty.');
      return;
    }

    if (password != confirmPassword) {
      _showErrorDialog('Invalid Password', 'Passwords do not match.');
      return;
    }

    // Validate phone number
    if (!validatePhoneNumber(phoneNumber)) {
      _showErrorDialog('Invalid Phone Number',
          'Please enter a valid phone number.');
      return;
    }

    // Validate ID length
    if (id.length > 9) {
      _showErrorDialog('Invalid ID', 'ID cannot exceed 9 characters.');
      return;
    }

    // Validate Full Name
    if (!isAlphabetOnly(fullName)) {
      _showErrorDialog('Invalid Full Name', 'Full Name should only contain alphabets.');
      return;
    }

    // Prepare signup data
    Map<String, dynamic> signupData = {
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'day_of_birth': _selectedDay,
      'month_of_birth': _selectedMonth,
      'year_of_birth': _selectedYear,
      'id_number': id,
      'password': password,
    };

    // Send signup data to backend
    const String signupUrl = 'http://127.0.0.1:8000/signup/'; // Update with your Django API endpoint
    try {
      final response = await http.post(
        Uri.parse(signupUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(signupData),
      );

      if (response.statusCode == 201) {
        // Successfully signed up
        print('Signup successful');
        // Navigate to another screen or show success message
      } else {
        // Handle signup error
        print('Signup failed: ${response.body}');
        _showErrorDialog('Signup Failed', response.body);
      }
    } catch (e) {
      // Handle connection error
      print('Connection error: $e');
      _showErrorDialog('Connection Error', 'Failed to connect to the server. Please try again.');
    }
  }

  bool validatePhoneNumber(String phone) {
    // Regular expression to match numbers starting with 06 or 05 or 07 and exactly 10 digits
    RegExp regex = RegExp(r'^(05|06|07)\d{8}$');
    return regex.hasMatch(phone);
  }

  bool isAlphabetOnly(String value) {
    // Regular expression to match only alphabets (no special characters or numbers)
    RegExp regex = RegExp(r'^[a-zA-Z ]+$');
    return regex.hasMatch(value);
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/Sign_Up.svg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 25),
                          Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            "Create a new account",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 50),
                    TextField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _phoneNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Day',
                              border: OutlineInputBorder(),
                            ),
                            items: days.map((String day) {
                              return DropdownMenuItem<String>(
                                value: day,
                                child: Text(day),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedDay = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child:  DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Month',
                              border: OutlineInputBorder(),
                            ),
                            items: months.map((String month) {
                              return DropdownMenuItem<String>(
                                value: month,
                                child: Text(month),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedMonth = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'Year',
                              border: OutlineInputBorder(),
                            ),
                            items: years.map((String year) {
                              return DropdownMenuItem<String>(
                                value: year,
                                child: Text(year),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedYear = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // To hide the password input
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _confirmPasswordController,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true, // To hide the password input
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          value: doYouHaveVehicle,
                          onChanged: (bool? value) {
                            setState(() {
                              doYouHaveVehicle = value ?? false;
                            });
                          },
                        ),
                        const Text('Do you have a vehicle?'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: MaterialButton(
                        onPressed: _signUp,
                        minWidth: double.infinity,
                        height: 60,
                        color: Colors.brown,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
