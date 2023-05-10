import 'package:flutter/material.dart';

class TextItem extends StatelessWidget {
  TextItem(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.obscureText});
  final String labelText;
  TextEditingController controller;
  bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(
              fontSize: 17,
              color: Colors.white,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1.5,
                color: Colors.amber,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.amber,
              ),
            )),
      ),
    );
  }
}
