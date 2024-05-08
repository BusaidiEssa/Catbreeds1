import 'package:flutter/material.dart';
import '../data/DatabaseHelper.dart';
import '../data/cat_model.dart';
import '../reuseable/MyRoundedCatInfo.dart';

class MyDynamicImageListScreen extends StatefulWidget {
  const MyDynamicImageListScreen({Key? key}) : super(key: key);

  @override
  State<MyDynamicImageListScreen> createState() =>
      _MyDynamicImageListScreenState();
}

class _MyDynamicImageListScreenState extends State<MyDynamicImageListScreen> {
  List<Cat> catList = [];

  @override
  void initState() {
    super.initState();
    DatabaseHelper.readFirebaseRealtimeDBMain((catList) {
      setState(() {
        this.catList = catList;
        print(this.catList.first.catData?.name);
        print(this.catList);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    for (int i = 0; i < catList.length; i++) ...{
                      MyRoundedCatInfo(cat: catList[i]),
                      const SizedBox(height: 20,),
                    }
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
