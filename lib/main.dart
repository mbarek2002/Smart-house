import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:smarthouse/firebase_options.dart';
import 'package:smarthouse/home.dart';
import 'package:smarthouse/splashScreen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final databaseReference = FirebaseDatabase.instance.ref();

  void createRecord() {
    databaseReference.child("users").child("1").set({
      'name': 'John',
      'age': 30
    }).then((_) {
      print('Record created successfully.');
    }).catchError((error) {
      print('Error creating record: $error');
    });
  }

  void readData() {
    databaseReference.child("users").child("1").get().then((DataSnapshot snapshot) {
      if (snapshot.exists) {
        print('Data : ${snapshot.value}');
      } else {
        print('No data available');
      }
    }).catchError((error) {
      print('Error getting data: $error');
    });
  }

  void updateData() {
    databaseReference.child("led").update({
      'brightness': 2,
      'state': 1
    }).then((_) {
      print('Record updated successfully.');
    }).catchError((error) {
      print('Error updating record: $error');
    });
  }

  void deleteData() {
    databaseReference.child("users").child("1").remove().then((_) {
      print('Record deleted successfully.');
    }).catchError((error) {
      print('Error deleting record: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: createRecord,
              child: Text('Create Record'),
            ),
            ElevatedButton(
              onPressed: readData,
              child: Text('Read Data'),
            ),
            ElevatedButton(
              onPressed: updateData,
              child: Text('Update Data'),
            ),
            ElevatedButton(
              onPressed: deleteData,
              child: Text('Delete Data'),
            ),
          ],
        ),
      ),
    );
  }
}
