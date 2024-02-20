import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String labelText;
  final IconData? icon;
  final dynamic fieldType;
  final TextEditingController controller;
  final dynamic maxLength;
  final dynamic errorText;
  final dynamic onSaved;
  final dynamic validator;
  final dynamic keyboardType;
  final dynamic maxLines;
  final dynamic initialValue;

  TextBox({
    Key? key,
    required this.labelText,
    this.errorText,
    this.icon,
    this.fieldType,
    required this.controller,
    this.maxLength,
    this.onSaved,
    this.keyboardType,
    this.validator,
    this.maxLines,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        keyboardType: fieldType,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        maxLength: maxLength,
        maxLines: maxLines,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          errorText: errorText,
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            // borderSide: BorderSide.none,
          ),
          // prefixIcon: Icon(icon),
        ),
        onSaved: onSaved,
        validator: validator,
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
