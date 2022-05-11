import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants.dart' as _constants;

class AuthButton extends StatelessWidget {
  final Function() callBack;
  final String buttonText;

  const AuthButton({
    Key? key,
    required this.callBack,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: callBack,
        style: _constants.mainBtnStyle,
        child: Center(
            child: Text(
          buttonText,
          style: GoogleFonts.robotoCondensed(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        )));
  }
}
