import 'package:firebase_database/firebase_database.dart';

import 'cat_model.dart';

class DatabaseHelper {
  static Future<void> deleteCat(String key) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference.child("Cats").child(key).remove();
  }

  static Future<void> updateCatData(
      String key, CatData catData) async {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    await databaseReference
        .child("Cat")
        .child(key)
        .update(catData.toJson());
  }
  static Future<void> addNewCat(CatData catData) async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
      await databaseReference.child('Cats').push().set(catData.toJson());
      print("New cat added successfully!");
    } catch (error) {
      print("Failed to save cat data: $error");
    }
  }


  static void readFirebaseRealtimeDBMain(
      Function(List<Cat>) catListCallback) {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref();
    databaseReference.child("Cats").onValue.listen((catDataJson) {
      if (catDataJson.snapshot.exists) {
        CatData catData;
        Cat cat;
        List<Cat> catList = [];
        catDataJson.snapshot.children.forEach((element) {
//print("Element Key: ${element.key}");
//print("Element: ${element.value}");
          catData = CatData.fromJson(element.value as Map);
          cat = Cat(element.key, catData);
          catList.add(cat);
        });
        catListCallback(catList);
      } else {
        print("The data snapshot does not exist!");
      }
    });
  }

  static void createFirebaseRealtimeDBWithUniqueIDs(
      String mainNodeName, List<Map<String, dynamic>> breedList) {
    DatabaseReference databaseReference =
        FirebaseDatabase.instance.ref(mainNodeName);
    if (breedList.isNotEmpty) {
      breedList.forEach((breed) {
        databaseReference
            .push()
            .set(breed)
            .then((value) => print("breedList data successfully saved!"))
            .catchError((error) => print("Failed to write message: $error"));
      });
    } else {
      print("breedlist is empty!");
    }
  }

  static void writeMessageToFirebase() {
    final databaseReference = FirebaseDatabase.instance.ref();
    databaseReference
        .child('messages')
        .set({'message': 'HelloWorld'})
        .then((value) => print("Message written successfully"))
        .catchError((error) => print("Failed to write message: $error"));
  }
}
