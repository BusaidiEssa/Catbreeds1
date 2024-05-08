import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'data/DatabaseHelper.dart';
import 'data/breed_list.dart';
import 'screens/MyDynamicImageListScreen.dart';
import 'screens/StaticImageList.dart';
import 'screens/CatCreationScreen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // DatabaseHelper.createFirebaseRealtimeDBWithUniqueIDs("Cats", breedList);
  //  final DatabaseReference database =
  //  FirebaseDatabase.instance.ref();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Essa Albusaidi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int selectedIndex = 0;
  static List<Widget> widgetOptions = <Widget>[
    const Text("Home"),
    const MyDynamicImageListScreen(),
    const StaticImageList(),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurpleAccent,
        onTap: onTapPressed,
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Images",
            icon: Icon(Icons.school),
          ),
          BottomNavigationBarItem(
            label: "Business",
            icon: Icon(Icons.business),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewCat,
        tooltip: 'Add New Cat',
        child: const Icon(Icons.add),
      ),
    );
  }

  void onTapPressed(int value) {
    setState(() {
      selectedIndex = value;
    });
  }

  void _addNewCat() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CatCreationScreen()),
    );
  }
}
