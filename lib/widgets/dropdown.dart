import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// class Dropdown extends StatefulWidget {
//   final IconData? icon;
//   final Function onChangedCallback;
//   final String hintText;
//     final String value;

//   final Iterable<String> values;

//   Dropdown({
//     Key? key,
//     required this.icon,
//     required this.onChangedCallback, required this.values, required this.value, required this.hintText,
//   }) : super(key: key);

//   @override
//   State<Dropdown> createState() => _DropdownState();
// }

// class _DropdownState extends State<Dropdown> {
//   var _currentSelectedValue;

//   void x(context) {
//     (String? newValue) async {
//       setState(() {
//         _currentSelectedValue = newValue;
//         context.state.didChange(newValue);
//       });
//     };
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: FormField<String>(builder: (FormFieldState<String> state) {
//         return InputDecorator(
//           decoration: InputDecoration(
//               //labelStyle: textStyle,
//               errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//               hintText: widget.labelText,
//               labelText: widget.labelText,
//               prefixIcon: Icon(widget.icon),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(0.0))),
//           isEmpty: _currentSelectedValue == '',
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//                 value: _currentSelectedValue,
//                 isDense: true,
//                 onChanged: widget.onChanged,
//                 items: widget.dropdownItems),
//           ),
//         );
//       }),
//     );
//   }
// }

// class Dropdown extends StatelessWidget {
//   final IconData? icon;
//   final Function onChangedCallback;
//   final String hintText;
//   final String labelText;

//   final String value;

//   // final Iterable<String> values;

//   final dynamic dropdownItems;
//   const Dropdown(
//       {Key? key,
//       this.icon,
//       required this.onChangedCallback,
//       required this.hintText,
//       required this.value,
//       required this.labelText,
//       this.dropdownItems})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: FormField<String>(builder: (FormFieldState<String> state) {
//         return InputDecorator(
//           decoration: InputDecoration(
//             //labelStyle: textStyle,
//             errorStyle: TextStyle(color: Colors.redAccent, fontSize: 16.0),
//             hintText: this.hintText,
//             labelText: this.labelText,
//             // prefixIcon: Icon(this.icon),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(5.0),
//             ),
//             contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
//           ),
//           isEmpty: this.value == '',
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<String>(
//                 value: this.value,
//                 items: dropdownItems,
//                 //     this.values.map<DropdownMenuItem<String>>((String value) {
//                 //   return DropdownMenuItem<String>(
//                 //     value: value,
//                 //     child: Text(value),
//                 //   );
//                 // }).toList(),
//                 isDense: true,
//                 onChanged: (newValue) {
//                   this.onChangedCallback(newValue);
//                 }),
//           ),
//         );
//       }),
//     );
//   }
// }

class Dropdown extends StatelessWidget {
  final IconData? icon;
  final Function onChangedCallback;
  final String hintText;
  final String labelText;
  final dynamic dropdownItems;
  final String value;
  final initialValue;
  final dynamic validator;
  final dynamic autovalidateMode;

  const Dropdown(
      {Key? key,
      this.icon,
      required this.onChangedCallback,
      required this.hintText,
      required this.value,
      required this.labelText,
      this.dropdownItems,
      this.initialValue,
      this.autovalidateMode,
      this.validator})
      : super(key: key);

  final bool hasError = false;

  // var genderOptions = ['Male', 'Female', 'Other'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilderDropdown<String>(
          key: UniqueKey(),
          // autovalidate: true,
          name: '',
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),

            labelText: labelText,
            //suffix: hasError ? const Icon(Icons.error) : const Icon(Icons.check),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          initialValue: initialValue,
          // allowClear: true,
          // hint: Text(this.hintText),
          // validator:
          //     FormBuilderValidators.compose([FormBuilderValidators.required()]),
          items: dropdownItems,
          isDense: true,
          onChanged: (val) {
            this.onChangedCallback(val);
            // setState(() {
            //   _genderHasError =
            //       !(_formKey.currentState?.fields['gender']?.validate() ?? false);
            // });
          },
          valueTransformer: (val) => val?.toString(),
          validator: this.validator,
          autovalidateMode: this.autovalidateMode),
    );
  }
}

class Dropdown2 extends StatelessWidget {
  final IconData? icon;
  final Function onChangedCallback;
  final String hintText;
  final String labelText;
  final dynamic dropdownItems;
  final String value;
  final initialValue;
  final dynamic validator;

  const Dropdown2(
      {Key? key,
      this.icon,
      required this.onChangedCallback,
      required this.hintText,
      required this.value,
      required this.labelText,
      this.dropdownItems,
      this.initialValue,
      this.validator})
      : super(key: key);

  final bool hasError = false;

  // var genderOptions = ['Male', 'Female', 'Other'];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBuilderDropdown<String>(
        key: UniqueKey(),
        // autovalidate: true,
        name: '',
        decoration: InputDecoration(
          labelText: labelText,
          //suffix: hasError ? const Icon(Icons.error) : const Icon(Icons.check),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        initialValue: initialValue,
        // allowClear: true,
        // hint: Text(this.hintText),
        enabled: false,
        // validator:
        //     FormBuilderValidators.compose([FormBuilderValidators.required()]),
        items: dropdownItems,
        isDense: true,
        onChanged: (val) {
          this.onChangedCallback(val);
          // setState(() {
          //   _genderHasError =
          //       !(_formKey.currentState?.fields['gender']?.validate() ?? false);
          // });
        },
        valueTransformer: (val) => val?.toString(),
        validator: this.validator,
      ),
    );
  }
}
