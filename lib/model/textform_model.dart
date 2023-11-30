import 'package:flutter/material.dart';

class customtextfield extends StatelessWidget {
  customtextfield(
      {required this.hinttext,
      required this.prefixicon,
      required this.onChanged,
      required this.obscuretext});
  String? hinttext;
  Icon? prefixicon;
  Function(String)? onChanged;
  bool obscuretext = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        obscureText: obscuretext,
        validator: (value) {
          if (value!.length <= 5) {
            return "field is required";
          }
        },
        onChanged: onChanged,
        cursorColor: const Color.fromARGB(255, 223, 191, 191),
        decoration: InputDecoration(
            prefixIcon: prefixicon,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.white),
            border: OutlineInputBorder(
                borderSide: BorderSide(
              width: 3,
              color: Colors.white,
            ))),
      ),
    );
  }
}
