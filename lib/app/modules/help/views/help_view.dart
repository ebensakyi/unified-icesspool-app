import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/help_controller.dart';

class HelpView extends GetView<HelpController> {
  const HelpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Help',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Welcome to the Help section of our app. If you have any questions or need assistance, please refer to the following information:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              _buildHelpItem(
                context,
                'FAQs',
                'Find answers to frequently asked questions.',
              ),
              _buildHelpItem(
                context,
                'Contact Us',
                'Get in touch with our support team.',
              ),
              _buildHelpItem(
                context,
                'Feedback',
                'Share your feedback and suggestions with us.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHelpItem(
      BuildContext context, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            description,
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Handle button press according to the help item
              if (title == 'FAQs') {
                // Navigate to FAQs screen
              } else if (title == 'Contact Us') {
                // Navigate to Contact Us screen
              } else if (title == 'Feedback') {
                // Navigate to Feedback screen
              }
            },
            child: Text('Learn More'),
          ),
        ],
      ),
    );
  }
}
