import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatelessWidget {
  CustomFormTextField(
      {Key? key, required this.hint, this.onChanged, this.isPassword = false})
      : super(key: key);
  final String hint;
  Function(String)? onChanged;
  bool? isPassword;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword!,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $hint';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        suffixIcon: isPassword!
            ? Image.asset(
                'assets/images/tabler_eye-closed.png',
                color: Colors.black.withOpacity(.5),
              )
            : null,
        hintText: hint,
        hintStyle: GoogleFonts.poppins(
            color: Color(0xff191E21).withOpacity(.7),
            fontSize: 16,
            fontWeight: FontWeight.w500),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.white),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
    );
  }
}
