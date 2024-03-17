import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/safety_controller.dart';

class SafetyView extends GetView<SafetyController> {
  const SafetyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Safety Statement',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'At ICESSPOOL, we take the safety and security of our users very seriously. We are committed to providing a safe and secure environment for all users of our mobile application.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Data Security',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'We employ industry-standard security measures to protect your personal information from unauthorized access, disclosure, alteration, or destruction. All data transmitted between our app and our servers is encrypted to ensure its confidentiality.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'User Safety',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'While using our app, we prioritize the safety of our users. We do not tolerate any form of harassment, abuse, or harmful behavior within our app. Any user found violating our community guidelines will be promptly dealt with, including suspension or termination of their account.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'In-App Purchases',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If our app includes in-app purchases, we ensure that these transactions are conducted securely and transparently. Users will always be informed of the costs associated with any in-app purchases, and they have the option to opt out or confirm their purchase before any transaction is finalized.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Reporting Safety Concerns',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you encounter any safety concerns while using our app, including inappropriate content, suspicious behavior, or security vulnerabilities, please report them to us immediately. We take all reports seriously and will investigate and take appropriate action as necessary.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'If you have any questions, concerns, or feedback regarding the safety and security of our app, please don\'t hesitate to contact us at [contact email/phone number].',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 20.0),
              Text(
                'Thank you for choosing ICESSPOOL. We are committed to providing you with a safe and enjoyable user experience.',
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
