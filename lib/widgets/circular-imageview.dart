import 'package:flutter/material.dart';

class CircularImageView extends StatelessWidget {
  final String imageUrl;

  CircularImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imageUrl,
        width: 100.0, // Adjust the width and height as needed
        height: 100.0,
        fit: BoxFit.cover,
      ),
    );
  }
}
