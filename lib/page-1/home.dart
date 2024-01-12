import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/auth.dart';
import 'package:myapp/page-1/welcome.dart';
import 'package:myapp/rootpage.dart';
//import 'package:flutter/gestures.dart';
//import 'dart:ui';
//import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    setState(() {
      AuthStatus.notSignedIn;
    });
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
                        25 * fem, 0 * fem, 26 * fem, 128 * fem),
                    padding: EdgeInsets.fromLTRB(
                        22 * fem, 44 * fem, 22 * fem, 102 * fem),
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
                              0 * fem, 0 * fem, 0 * fem, 69 * fem),
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
                      ],
                    ),
                  ),
                  Container(
                    // group42ef (170:4)
                    margin: EdgeInsets.fromLTRB(
                        126 * fem, 0 * fem, 126 * fem, 63 * fem),
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
                    // Container(
                    //   // autogroupclem6g1 (SWyYqz5SyoLVsJfybACLem)
                    //   padding: EdgeInsets.fromLTRB(
                    //       79 * fem, 15 * fem, 91 * fem, 50 * fem),
                    //   width: double.infinity,
                    //   height: 74 * fem,
                    //   decoration: const BoxDecoration(
                    //     color: Color(0xff080808),
                    //   ),
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         // Cj3 (108:5)
                    //         margin: EdgeInsets.fromLTRB(
                    //             0 * fem, 0 * fem, 147 * fem, 2 * fem),
                    //         child: Icon(
                    //           FontAwesomeIcons.home,
                    //           size: 34 * ffem,
                    //           color: Colors.white,
                    //         ),
                    //       ),
                    //       Container(
                    //         margin: EdgeInsets.fromLTRB(
                    //             0 * fem, 0 * fem, 2 * fem, 2 * fem),
                    //         child: Icon(
                    //           FontAwesomeIcons.user,
                    //           size: 34 * ffem,
                    //           color: Colors.white,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const GNav(
          backgroundColor: Color.fromRGBO(9, 9, 9, 1),
          color: Colors.white70,
          activeColor: Colors.white,
          tabBackgroundColor: Color.fromRGBO(66, 66, 66, 1),
          iconSize: 30,
          textSize: 30,
          gap: 20,
          padding: EdgeInsets.fromLTRB(60, 25, 60, 25),
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.person,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
