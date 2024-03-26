import 'package:flutter/material.dart';

class SmallTextBox extends StatelessWidget {
  final String label;
  final validator;
  final keyboardType;
  final TextEditingController controller;

  SmallTextBox(
      {required this.label,
      required this.controller,
      required this.validator,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            SizedBox(
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(border: OutlineInputBorder()),
                validator: validator,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
