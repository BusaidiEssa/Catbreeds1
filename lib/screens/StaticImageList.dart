import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../reuseable/ImageDecoration.dart';
class StaticImageList extends StatelessWidget {
  const StaticImageList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: ,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ImageDecoration(imagePath: "Maine_Coon_cat_breed.jpg"),
              const SizedBox(height: 25),
              ImageDecoration(imagePath: "norwegian_forest_cat__1_.jpg"),
              const SizedBox(height: 25),
              ImageDecoration(imagePath: "persian_cat__1_.jpg"),
              const SizedBox(height: 25),
              ImageDecoration(imagePath: "ragamuffin-cat.jpg"),
              const SizedBox(height: 25),
              ImageDecoration(imagePath: "ragdoll_cat.jpg"),
              const SizedBox(height: 25),
              ImageDecoration(imagePath: "siberian_cat.jpg"),
              const SizedBox(height: 25),

            ],
          ),
        ),
      ),
      //bottomNavigationBar: ,
    );
  }
}
