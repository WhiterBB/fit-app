import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/auth.dart';
import 'package:myapp/page-1/calories.dart';
import 'package:myapp/page-1/information.dart';
import 'package:myapp/page-1/welcome.dart';
import 'package:myapp/rootpage.dart';
import 'package:myapp/utils.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:io';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:jiffy/jiffy.dart';

String formatDate(DateTime d) => d.toString().substring(0, 19);

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  final User? user = Auth().currentUser;
  late Stream<StepCount> _stepCountStream;
  String _steps = '0';
  final db = FirebaseFirestore.instance;
  int savedStepsCount = 0;
  int lastdaySaved = 0;
  int todaySteps = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    print('====> $event');
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onStepCountError(error) {
    print('onStepCountError $error');
    setState(() {
      //_steps = 'Step Count not available';
    });
  }

  Future<Permission> getMotionPermission() async {
    if (Platform.isAndroid && await getAndroidSdk() >= 29) {
      return Permission.activityRecognition;
    } else {
      return Permission.sensors;
    }
  }

  Future<void> initPlatformState() async {
    Permission motionPermission = await getMotionPermission();
    if (!await motionPermission.isGranted) {
      var newStatus = await motionPermission.request();
      if (!newStatus.isGranted) return Future.error('Permission not granted');
    }

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  Future<int> getAndroidSdk() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      return sdkInt;
    }
    return 0;
  }

  Future<void> signOut() async {
    await Auth().signOut();
    setState(() {
      AuthStatus.notSignedIn;
    });
  }

  Future<int> getTodaySteps(int value) async {
    String uid = user!.uid;

    db
        .collection("users")
        .doc("${uid}")
        .collection("col")
        .doc("activityinfo")
        .get()
        .then((DocumentSnapshot ds) async {
      savedStepsCount = ds['totalsteps'];
    });

    int todayDayNo = Jiffy.now().dayOfYear;
    if (value < savedStepsCount) {
      savedStepsCount = 0;
      db
          .collection("users")
          .doc("${uid}")
          .collection("col")
          .doc("activityinfo")
          .update({
        'totalsteps': savedStepsCount,
      });
    }

    db
        .collection("users")
        .doc("${uid}")
        .collection("col")
        .doc("activityinfo")
        .get()
        .then((DocumentSnapshot ds) async {
      lastdaySaved = ds['lastdaysaved'];
    });

    if(lastdaySaved < todayDayNo){
      lastdaySaved = todayDayNo;
      savedStepsCount = value;

      db
          .collection("users")
          .doc("${uid}")
          .collection("col")
          .doc("activityinfo")
          .update({
        'lastdaysaved': lastdaySaved,
        'totalsteps': savedStepsCount,
      });

      setState(() {
        todaySteps = value - savedStepsCount;
      });
    }
    db
          .collection("users")
          .doc("${uid}")
          .collection("col")
          .doc("activityinfo")
          .collection("todaysteps")
          .doc()
          .update({
        'todayDayNo': todayDayNo,
        'todaySteps': todaySteps,
      });
    return todaySteps;
  }

  void _navigateBottomBar(int index){
    setState(() {
      _selectedIndex = index;
    });
    if(_selectedIndex == 0){
     
    }else if(_selectedIndex == 1){
      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CaloriesActivity()));
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              // homeKjo (105:66)
              padding: EdgeInsets.fromLTRB(1 * fem, 50 * fem, 0 * fem, 0 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xff000000),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // rectangle2qy3 (105:82)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 0 * fem, 49 * fem),
                    width: 89 * fem,
                    height: 84 * fem,
                    child: Image.asset(
                      'assets/page-1/images/rectangle-2-7yj.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    // actividadBGD (105:85)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 0 * fem, 180 * fem, 13 * fem),
                    child: Text(
                      'Actividad',
                      textAlign: TextAlign.center,
                      style: SafeGoogleFont(
                        'Nunito',
                        fontSize: 24 * ffem,
                        fontWeight: FontWeight.w900,
                        height: 1.3625 * ffem / fem,
                        color: const Color(0xffcccccc),
                      ),
                    ),
                  ),
                  Container(
                    // group3V21 (106:88)
                    margin: EdgeInsets.fromLTRB(
                        25 * fem, 0 * fem, 26 * fem, 40 * fem),
                    padding: EdgeInsets.fromLTRB(
                        22 * fem, 20 * fem, 22 * fem, 10 * fem),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xff796988),
                      borderRadius: BorderRadius.circular(20 * fem),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // pasoshoyTsw (105:86)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          child: Text(
                            'Pasos hoy',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 40 * fem),
                          width: double.infinity,
                          child: Text(
                            //getTodaySteps(int.parse(_steps)).toString(),
                            //'uwu',
                            _steps,
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        SizedBox(
                          // distanciarecorridamtd (105:87)
                          width: double.infinity,
                          child: Text(
                            'Distancia Recorrida',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 40 * fem),
                          width: double.infinity,
                          child: Text(
                            'Distancia',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          // pasoshoyTsw (105:86)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          child: Text(
                            'Calorías quemadas',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w700,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          child: Text(
                            'Calorías',
                            textAlign: TextAlign.left,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 20 * ffem,
                              fontWeight: FontWeight.w300,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // group42ef (170:4)
                    margin: EdgeInsets.fromLTRB(
                        90 * fem, 0 * fem, 90 * fem, 20 * fem),
                    width: double.infinity,
                    height: 35 * fem,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff796988),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Actualizar Información',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UpdateInformation())),
                    ),
                  ),
                  Container(
                    // group42ef (170:4)
                    margin: EdgeInsets.fromLTRB(
                        126 * fem, 0 * fem, 126 * fem, 50 * fem),
                    width: double.infinity,
                    height: 35 * fem,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff796988),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Salir',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                      onTap: () => signOut().then(
                        (value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Welcome())),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: //BottomNavigationBar(
        //   currentIndex: _selectedIndex,
        //   //backgroundColor: Colors.blueAccent,
        //   backgroundColor: Color.fromRGBO(9, 9, 9, 1),
        //   unselectedItemColor: Colors.white70,
        //   //selectedIconTheme: IconThemeData(color: Colors.white),
        //   selectedItemColor: Colors.white,
        //   iconSize: 30,
        //   type: BottomNavigationBarType.fixed,
        //   onTap: _navigateBottomBar,
        //   items: [
        //     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        //     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        //     BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calories'),
        //   ],
        // )
        GNav(
          backgroundColor: Color.fromRGBO(9, 9, 9, 1),
          color: Colors.white70,
          activeColor: Colors.white,
          tabBackgroundColor: Color.fromRGBO(66, 66, 66, 1),
          iconSize: 30,
          textSize: 30,
          gap: 20,
          padding: EdgeInsets.fromLTRB(30, 25, 30, 25),
          selectedIndex: _selectedIndex,
          onTabChange: (index){
            setState(() {
              _selectedIndex = index;
              print(_selectedIndex);
              if(_selectedIndex == 2){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CaloriesActivity()));
              }else if(_selectedIndex == 0){
                print("Same Page");
              }
            });
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
            GButton(
              icon: Icons.calculate,
              text: 'Calories',
            ),
          ],
        ),
      ),
    );
  }
}
