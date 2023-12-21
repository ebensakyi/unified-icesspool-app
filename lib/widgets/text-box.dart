// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../themes/colors.dart';

// class TextBox extends StatefulWidget {
//   final String labelText;
//   final IconData? icon;
//   final dynamic fieldType;
//   final dynamic controller;
//   final dynamic maxLength;
//   final dynamic errorText;
//   TextBox(
//       {Key? key,
//       required this.labelText,
//       this.errorText,
//       this.icon,
//       this.fieldType,
//       this.controller,
//       this.maxLength})
//       : super(key: key);

//   @override
//   State<TextBox> createState() => _TextBoxState();
// }

// class _TextBoxState extends State<TextBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextField(
//         controller: widget.controller,
//         keyboardType: widget.fieldType,
//         maxLengthEnforcement: MaxLengthEnforcement.enforced,
//         maxLength: widget.maxLength,
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//           errorText: widget.errorText,

//           labelText: widget.labelText,
//           filled: true,
//           fillColor: MyColors.White,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(5),
//             // borderSide: BorderSide.none,
//           ),
//           // prefixIcon: Icon(widget.icon),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/colors.dart';

class TextBox extends StatefulWidget {
  final String labelText;
  final IconData? icon;
  final dynamic fieldType;
  final dynamic controller;
  final dynamic maxLength;
  final dynamic errorText;
  final dynamic onSaved;
  final dynamic validator;
  final dynamic keyboardType;
  final dynamic maxLines;
  TextBox(
      {Key? key,
      required this.labelText,
      this.errorText,
      this.icon,
      this.fieldType,
      this.controller,
      this.maxLength,
      this.onSaved,
      this.keyboardType,
      this.validator,
      this.maxLines})
      : super(key: key);

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.fieldType,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          errorText: widget.errorText,

          labelText: widget.labelText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide.none,
          ),
          // prefixIcon: Icon(widget.icon),
        ),
        onSaved: widget.onSaved,
        validator: widget.validator,
      ),
    );
  }
}

class TextBox2 extends StatefulWidget {
  final String labelText;
  final IconData? icon;
  final dynamic fieldType;
  final dynamic controller;
  final dynamic maxLength;
  final dynamic errorText;
  final dynamic onSaved;
  final dynamic validator;
  TextBox2(
      {Key? key,
      required this.labelText,
      this.errorText,
      this.icon,
      this.fieldType,
      this.controller,
      this.maxLength,
      this.onSaved,
      this.validator})
      : super(key: key);

  @override
  State<TextBox2> createState() => _TextBoxState2();
}

class _TextBoxState2 extends State<TextBox2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.fieldType,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLength: widget.maxLength,
        enabled: false,
        style: TextStyle(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          errorText: widget.errorText,

          labelText: widget.labelText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            // borderSide: BorderSide.none,
          ),
          // prefixIcon: Icon(widget.icon),
        ),
        onSaved: widget.onSaved,
        validator: widget.validator,
      ),
    );
  }
}
