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

Container button1(
    {required String text, double? width, required void Function() onPress}) {
  return Container(
    height: 44.0,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.pinkAccent.shade100],
      ),
    ),
    child: ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent, elevation: 0),
      child: Text(
        text,
        style: textStyle1.copyWith(fontWeight: FontWeight.normal),
      ),
    ),
  );
}

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
