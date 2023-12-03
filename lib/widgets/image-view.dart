import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String path;
  const ImageView({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.file(File(this.path));
  }
}
