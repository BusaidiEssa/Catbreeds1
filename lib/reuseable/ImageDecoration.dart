import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDecoration extends StatelessWidget {
  String imagePath;

  ImageDecoration({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 0.8 * MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("images/$imagePath"),
          ),
          border: Border.all(width: 8, color: Colors.black),
          boxShadow: const [
            BoxShadow(
              color: Colors.purple,
              blurRadius: 4,
              spreadRadius: 4.5,
              blurStyle: BlurStyle.solid,
            )
          ]),
    );
  }
}
