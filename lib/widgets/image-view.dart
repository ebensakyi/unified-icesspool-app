import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final String path;
  final double size;

  const ImageView({Key? key, required this.path, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage(path);
    Image image = Image(
      image: assetImage,
      width: size,
      height: size,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(2),
    );
  }
}
