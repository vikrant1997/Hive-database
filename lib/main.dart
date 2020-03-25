import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_database_practice/models/contact.dart';
import 'contact_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storageDirectory =
      await path_provider.getApplicationDocumentsDirectory();

  Hive.init(storageDirectory.path);
  Hive.registerAdapter(ContactAdapter());
  runApp(MyApp());
  // final contactsBox = await Hive.openBox('contacts');
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tutorial',
      home: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('${snapshot.error.toString()}');
            } else
              return ContactPage();
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('contacts').close();
    super.dispose();
  }
}
