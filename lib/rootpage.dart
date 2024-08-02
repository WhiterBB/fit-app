import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/page-1/home.dart';
//import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/welcome.dart';
import 'auth.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

enum AuthStatus {
  notDetermined,
  signedIn,
  notSignedIn,
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;

  @override
  void initState() {
    super.initState();
    final User? user = Auth().currentUser;
    setState(() {
      authStatus = user == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
    });
  }


  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.signedIn:
        return Home();
      case AuthStatus.notSignedIn:
        return const Welcome();
      default:
        return _buildWaitingScreen();
    }
  }

  Widget _buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}
