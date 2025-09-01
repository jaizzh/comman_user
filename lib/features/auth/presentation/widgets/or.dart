import 'package:flutter/material.dart';

Widget or() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 150,
        height: 1,
        color: Colors.black,
      ),
      const SizedBox(
        width: 10,
      ),
      Image.asset(
        "assets/png/pookie.png",
        width: 25,
      ),
      const SizedBox(
        width: 10,
      ),
      Container(
        width: 150,
        height: 1,
        color: Colors.black,
      ),
    ],
  );
}
