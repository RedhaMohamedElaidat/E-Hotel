import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({Key? key}) : super(key: key);

  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  // List of booleans to track the visibility of each answer
  final List<bool> _isAnswerVisible = [false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "HELP & SUPPORT",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Frequently Asked Questions",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              buildFAQList(),
            ],
          ),
        ),
      ),
    );
  }

  // Function to build the list of FAQs
  Widget buildFAQList() {
    return Column(
      children: [
        buildFAQItem(
          index: 0,
          question: "🔐 How do I reset my password?",
          answer: "1. Go to the login page.\n"
              "2. Click 'Forgot Password'.\n"
              "3. Enter your email address.\n"
              "4. You'll receive an email with a password reset link.\n"
              "5. Click the link and follow the instructions to set a new password.",
        ),
        buildFAQItem(
          index: 1,
          question: "👤 How can I update my profile?",
          answer: "1. Go to your profile page.\n"
              "2. Click 'Edit Profile'.\n"
              "3. Change the details you want to update (name, email, etc.).\n"
              "4. Once you're done, click 'Save'.",
        ),
        buildFAQItem(
          index: 2,
          question: "📞 How do I contact support?",
          answer: "1. You can contact our support team via email at support@ehotel.com.\n"
              "2. Alternatively, you can call +123 456 789 for immediate assistance.",
        ),
        buildFAQItem(
          index: 3,
          question: "💳 How can I update my payment information?",
          answer: "1. Go to the 'Payment' section in the app.\n"
              "2. Select 'Update Payment Information'.\n"
              "3. Enter the new credit card or bank account details.\n"
              "4. Confirm the changes by clicking 'Save'.",
        ),
        buildFAQItem(
          index: 4,
          question: "🛎 What should I do if my hotel booking is canceled?",
          answer: "1. Check your email for any cancellation notifications.\n"
              "2. If your booking was canceled by the hotel, contact customer support for a refund or to rebook.\n"
              "3. You can also check the cancellation policy under 'Reservations' in the app.",
        ),
        buildFAQItem(
          index: 5,
          question: "🔒 Is my personal information secure?",
          answer: "Yes, we use advanced encryption technology to ensure that your personal and financial information is secure. "
              "You can read our privacy policy for more details.",
        ),
      ],
    );
  }

  // Function to build each FAQ item
  Widget buildFAQItem({required int index, required String question, required String answer}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question clickable widget
        InkWell(
          onTap: () {
            setState(() {
              _isAnswerVisible[index] = !_isAnswerVisible[index];
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  _isAnswerVisible[index] ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ),
        // Answer visibility control
        _isAnswerVisible[index]
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  answer,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              )
            : Container(), // Empty container if the answer is not visible
        const Divider(),
      ],
    );
  }
}
