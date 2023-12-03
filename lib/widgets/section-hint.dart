import 'package:flutter/material.dart';

import '../themes/colors.dart';

class SectionHint extends StatelessWidget {
  final labelText;
  const SectionHint({Key? key, this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: MyColors.lightColor,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(Icons.info_outline),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(labelText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
