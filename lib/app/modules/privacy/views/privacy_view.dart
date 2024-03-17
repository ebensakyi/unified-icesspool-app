import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/privacy_controller.dart';

class PrivacyView extends GetView<PrivacyController> {
  const PrivacyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Effective Date: 1st January 2024',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'This Privacy Policy outlines how ICESSPOOL (`we,` `us,` or `our``) collects, uses, discloses, and secures personal and sensitive user data. By using ICESSPOOL, you agree to the terms described in this policy.',
            ),
            SizedBox(height: 16),
            Text(
              '1. Types of Personal and Sensitive User Data Collected',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - Contact Information: Such as name, email address, and phone number.',
            ),
            Text(
              '   - Device Information: Including device type, operating system, and unique device identifiers.',
            ),
            Text(
              '   - Usage Data: Information about how you interact with the app, including features used and time spent.',
            ),
            Text(
              '   - Location Data: If you grant us permission, we may collect your precise or approximate location.',
            ),
            SizedBox(height: 16),
            Text(
              '2. How We Collect User Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - Information you provide during account registration or app usage.',
            ),
            Text(
              '   - Automatic data collection technologies like cookies and analytics tools.',
            ),
            SizedBox(height: 16),
            Text(
              '3. How We Use and Share User Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - We use the collected data for various purposes including providing and improving app functionality, personalizing user experience, sending relevant notifications and updates, and analyzing app usage to enhance performance and features.',
            ),
            Text(
              '   - We may share user data with service providers assisting in app operations and when required by law or to protect our rights.',
            ),
            SizedBox(height: 16),
            Text(
              '4. Secure Data Handling Procedures',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - We implement reasonable security measures to protect user data including encryption of data in transit and at rest, access controls to limit data access to authorized personnel, and regular security assessments and updates. However, no method of transmission or storage is 100% secure.',
            ),
            Text(
              '   - While we strive to protect your data, we cannot guarantee absolute security.',
            ),
            SizedBox(height: 16),
            Text(
              '5. Data Retention and Deletion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - We retain user data for as long as necessary to fulfill the purposes outlined in this policy. Users have the right to request access to their data and its deletion. Please contact us at esicapp2022@gmail.com for such requests.',
            ),
            SizedBox(height: 16),
            Text(
              '6. Children\'s Privacy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - Our app is not intended for children under the age of 13. We do not knowingly collect personal information from children. If you believe your child has provided us with personal information, please contact us to have it removed.',
            ),
            SizedBox(height: 16),
            Text(
              '7. Changes to Privacy Policy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - We reserve the right to update this Privacy Policy. Any changes will be posted on our website or within the app. Please review this policy periodically for updates.',
            ),
            SizedBox(height: 16),
            Text(
              '8. Contact Us',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '   - If you have questions or concerns about this Privacy Policy, please contact us at esicapp2022@gmail.com.',
            ),
          ],
        ),
      ),
    );
  }
}
