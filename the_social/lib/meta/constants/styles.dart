import 'package:flutter/material.dart';

const textStyle1 = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

const textStyleTitle = TextStyle(
  color: Colors.white,
  fontSize: 35,
  // fontWeight: FontWeight.bold,
);

const sBox10 = SizedBox(
  height: 10,
);

InputDecoration textFieldStyle1({required String hintText}) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey.shade900,
    hintText: hintText,
    border: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(15)),
    ),
    hintStyle: const TextStyle(
      color: Colors.white,
    ),
  );
}
