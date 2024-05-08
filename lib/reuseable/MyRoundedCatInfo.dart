import 'package:flutter/material.dart';

import '../data/cat_model.dart';
import '../screens/CatDetailScreen.dart';
import 'AppStyles.dart';

class MyRoundedCatInfo extends StatelessWidget {
  final Cat? cat;

  const MyRoundedCatInfo({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (cat != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CatDetailScreen(cat: cat!),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          height: 450,
          width: 0.75 * MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.lightBlueAccent,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "images/${cat?.catData?.imagePath ?? ''}",
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Stack(
                  children: [
                    Container(
                      height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name:",
                                  style: AppStyles.headlineStyle1,
                                ),
                                Text(
                                  "Breed:",
                                  style: AppStyles.headlineStyle1,
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  cat?.catData?.name.toString() ?? '',
                                  style: AppStyles.headlineStyle1,
                                ),
                                Text(
                                  cat?.catData?.breed.toString() ?? '',
                                  style: AppStyles.headlineStyle1,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
