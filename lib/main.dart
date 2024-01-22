import 'package:flutter/material.dart';
//import 'package:myapp/page-1/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/rootpage.dart';
import 'firebase_options.dart';
//import 'package:myapp/page-1/information.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FitApp',
      debugShowCheckedModeBanner: false,
      //scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootPage(),
        );
      
    
  }
}
