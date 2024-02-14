import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/auth.dart';
import 'package:myapp/page-1/calories.dart';
import 'package:myapp/page-1/information.dart';
import 'package:myapp/page-1/posts.dart';
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
  int weight = 0;
  //String _distance = '0';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getDistance(_steps);
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
      _steps = 'Step Count not available';
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
    String uid = user!.uid;
    await db
        .collection("users")
        .doc("${uid}")
        .collection("col")
        .doc("activityinfo")
        .update({
      'totalsteps': savedStepsCount,
    });

    await Auth().signOut();
    setState(() {
      AuthStatus.notSignedIn;
    });
  }

  void postMessage() {
    String finalmessage = "Hoy he dado $todaySteps pasos.";
    db.collection("usersPosts").add({
      'UserEmail': user!.email,
      'Message': finalmessage,
      'TimeStamp': Timestamp.now(),
    });
  }

  getDistance(String steps) async {
    int stepsEnter = int.parse(steps);
    double distance = stepsEnter * 0.000762;

    // setState(() {
    //   _distance = distance.toString();
    // });
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 40),
      width: double.infinity,
      child: Text(
        distance.toStringAsFixed(3),
        textAlign: TextAlign.left,
        style: SafeGoogleFont(
          'Nunito',
          fontSize: 20,
          fontWeight: FontWeight.w300,
          height: 1.3625,
          color: const Color(0xffffffff),
        ),
      ),
    );
  }

  getCaloriesBurnt(String steps) async {
    String uid = user!.uid;
    int stepEnter = int.parse(steps);
    double distance = stepEnter * 0.000762;
    double caloriesburnt = 0;

    await db
        .collection("users")
        .doc("${uid}")
        .get()
        .then((DocumentSnapshot ds) async {
      weight = ds['weight'];
    });
    print('W> $weight');

    caloriesburnt = weight * distance * 1.03;

    print('CB > $caloriesburnt');

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      width: double.infinity,
      child: Text(
        caloriesburnt.toStringAsFixed(1),
        textAlign: TextAlign.left,
        style: SafeGoogleFont(
          'Nunito',
          fontSize: 20,
          fontWeight: FontWeight.w300,
          height: 1.3625,
          color: const Color(0xffffffff),
        ),
      ),
    );
  }

  getTodaySteps(int value) async {
    String uid = user!.uid;
    //print(value);

    await db
        .collection("users")
        .doc("${uid}")
        .collection("col")
        .doc("activityinfo")
        .get()
        .then((DocumentSnapshot ds) async {
      savedStepsCount = ds['totalsteps'];
    });
    //print(savedStepsCount);

    int todayDayNo = Jiffy.now().dayOfYear;
    if (value < savedStepsCount) {
      savedStepsCount = 0;
      await db
          .collection("users")
          .doc("${uid}")
          .collection("col")
          .doc("activityinfo")
          .update({
        'totalsteps': savedStepsCount,
      });
    }
    print('Value after $value');

    await db
        .collection("users")
        .doc("${uid}")
        .collection("col")
        .doc("activityinfo")
        .get()
        .then((DocumentSnapshot ds) async {
      lastdaySaved = ds['lastdaysaved'];
    });

    if (lastdaySaved < todayDayNo) {
      lastdaySaved = todayDayNo;
      savedStepsCount = value;

      await db
          .collection("users")
          .doc("${uid}")
          .collection("col")
          .doc("activityinfo")
          .update({
        'lastdaysaved': lastdaySaved,
        'totalsteps': savedStepsCount,
      });
    }
    todaySteps = value - savedStepsCount;

    db
        .collection("users")
        .doc("${uid}")
        .collection("col")
        .doc("activityinfo")
        .collection("todaysteps")
        .doc('$todayDayNo')
        .set({
      'todayDayNo': todayDayNo,
      'todaySteps': todaySteps,
    });

    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      width: double.infinity,
      child: Text(
        todaySteps.toString(),
        textAlign: TextAlign.left,
        style: SafeGoogleFont(
          'Nunito',
          fontSize: 20,
          fontWeight: FontWeight.w300,
          height: 1.3625,
          color: const Color(0xffffffff),
        ),
      ),
    );
  }

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 0) {
    } else if (_selectedIndex == 1) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CaloriesActivity()));
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
                        0 * fem, 0 * fem, 0 * fem, 10 * fem),
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
                        25 * fem, 0 * fem, 26 * fem, 20 * fem),
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

                        FutureBuilder(
                            future: getTodaySteps(int.parse(_steps)),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!;
                                //if(snapshot.connectionState == ConnectionState.waiting){
                                //  return snapshot.data!;
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 40 * fem),
                          width: double.infinity,
                          // child: Text(
                          //   //getTodaySteps(int.parse(_steps)).toString(),
                          //   //'uwu',
                          //   _steps,
                          //   textAlign: TextAlign.left,
                          //   style: SafeGoogleFont(
                          //     'Nunito',
                          //     fontSize: 20 * ffem,
                          //     fontWeight: FontWeight.w300,
                          //     height: 1.3625 * ffem / fem,
                          //     color: const Color(0xffffffff),
                          //   ),
                          // ),
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
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(
                        //       0 * fem, 10 * fem, 0 * fem, 40 * fem),
                        //   width: double.infinity,

                        FutureBuilder(
                            future: getDistance(todaySteps.toString()),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!;
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                        //'Distancia',
                        //     textAlign: TextAlign.left,
                        //     style: SafeGoogleFont(
                        //       'Nunito',
                        //       fontSize: 20 * ffem,
                        //       fontWeight: FontWeight.w300,
                        //       height: 1.3625 * ffem / fem,
                        //       color: const Color(0xffffffff),
                        //     ),
                        //   ),
                        // ),
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
                        // Container(
                        //   margin: EdgeInsets.fromLTRB(
                        //       0 * fem, 0 * fem, 0 * fem, 20 * fem),
                        //   width: double.infinity,
                        //   child: Text(
                        //     'Calorías',
                        //     textAlign: TextAlign.left,
                        //     style: SafeGoogleFont(
                        //       'Nunito',
                        //       fontSize: 20 * ffem,
                        //       fontWeight: FontWeight.w300,
                        //       height: 1.3625 * ffem / fem,
                        //       color: const Color(0xffffffff),
                        //     ),
                        //   ),
                        // ),
                        FutureBuilder(
                            future: getCaloriesBurnt(todaySteps.toString()),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!;
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
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
                            'Compartir',
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
                      onTap: () => postMessage(),
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
                  ),
                  // Container(
                  //   // group4bwH (192:4)
                  //   margin: EdgeInsets.fromLTRB(
                  //       126 * fem, 0 * fem, 126 * fem, 20 * fem),
                  //   width: 107 * fem,
                  //   height: double.infinity,
                  //   child: InkWell(
                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         color: const Color(0xff796988),
                  //         borderRadius: BorderRadius.circular(20 * fem),
                  //       ),
                  //       child: Center(
                  //         child: Text(
                  //           'Compartir',
                  //           textAlign: TextAlign.center,
                  //           style: SafeGoogleFont(
                  //             'Nunito',
                  //             fontSize: 14 * ffem,
                  //             fontWeight: FontWeight.w600,
                  //             height: 1.3625 * ffem / fem,
                  //             color: const Color(0xffffffff),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //     onTap: () => postMessage(),
                  //   ),
                  // ),
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
          backgroundColor: const Color.fromRGBO(9, 9, 9, 1),
          color: Colors.white70,
          activeColor: Colors.white,
          tabBackgroundColor: const Color.fromRGBO(66, 66, 66, 1),
          iconSize: 30,
          textSize: 30,
          gap: 20,
          padding: const EdgeInsets.fromLTRB(30, 25, 30, 25),
          selectedIndex: _selectedIndex,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
              print(_selectedIndex);
              if (_selectedIndex == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CaloriesActivity()));
              } else if (_selectedIndex == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PostsPage()));
              } else if (_selectedIndex == 0) {
                print("Same Page");
              }
            });
          },
          tabs: const [
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
