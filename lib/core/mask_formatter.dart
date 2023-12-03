import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputMasker {
  // static String maskA = "S.####";
  // static String maskB = "S.######";

  var phoneMask = MaskTextInputFormatter(
      mask: '##########',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var ghanaPostGpsMask = new MaskTextInputFormatter(
      mask: '##-########',
      //filter: {"#": RegExp(r'[a-zA-Z0-9]')},
      filter: {"#": RegExp(r'^[a-zA-Z0-9]*$|^[0-9]*$')},
      type: MaskAutoCompletionType.lazy);
}
