import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/auth.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/posts.dart';
import 'package:myapp/utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class CaloriesActivity extends StatefulWidget {
  const CaloriesActivity({super.key});

  @override
  State<CaloriesActivity> createState() => _CaloriesActivityState();
}

class _CaloriesActivityState extends State<CaloriesActivity> {
  int _selectedIndex = 2;
  int walkingMinutes = 0;
  int runningMinutes = 0;
  int cyclingMinutes = 0;
  int weightliftingMinutes = 0;
  int jumpingMinutes = 0;
  int dancingMinutes = 0;
  int age = 0;
  int weight = 0;
  int height = 0;
  double totalMinutesCalories = 0;
  String gender = '';
  double firstCalories = 0;
  double totalCalories = 0;
  int dias = 2;

  final TextEditingController _controllerWalking = TextEditingController();
  final TextEditingController _controllerRunning = TextEditingController();
  final TextEditingController _controllerCycling = TextEditingController();
  final TextEditingController _controllerWeightlifting = TextEditingController();
  final TextEditingController _controllerJumping = TextEditingController();
  final TextEditingController _controllerDancing = TextEditingController();
  final db = FirebaseFirestore.instance;

  void submit() {
    Navigator.of(context).pop();
  }

  double calculateCalories() {
    String uid = Auth().currentUser!.uid;

    db
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot ds) async {
      age = ds['age'];
      weight = ds['weight'];
      gender = ds['gender'];
      height = ds['height'];
    });

    firstCalories = 66.47 + (13.75* weight) + (5*height) - (6.7* age);
    print(firstCalories);

    totalMinutesCalories = (walkingMinutes*8)+(runningMinutes*6)+(cyclingMinutes*7.5)+(jumpingMinutes*11)+(weightliftingMinutes*5)+(dancingMinutes*8);
    totalCalories = firstCalories + (totalMinutesCalories/dias);
    return totalCalories;
  }

  Future openDialogWalking() => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Minutos Caminando'),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Minutos'),
              controller: _controllerWalking,
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  submit();
                  setState(() {
                    walkingMinutes = int.parse(_controllerWalking.text);
                    print(walkingMinutes);
                  });
                },
              ),
            ],
          )));

  Future openDialogRunning() => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Minutos Corriendo'),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Corriendo'),
              controller: _controllerRunning,
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  submit();
                  setState(() {
                    runningMinutes = int.parse(_controllerRunning.text);
                    print(runningMinutes);
                  });
                },
              ),
            ],
          )));

  Future openDialogCycling() => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Minutos en Bicicleta'),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Bicicleta'),
              controller: _controllerCycling,
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  submit();
                  setState(() {
                    cyclingMinutes = int.parse(_controllerCycling.text);
                    print(cyclingMinutes);
                  });
                },
              ),
            ],
          )));

  Future openDialogWeightlifting() => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Minutos Pesas'),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Pesas'),
              controller: _controllerWeightlifting,
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  submit();
                  setState(() {
                    weightliftingMinutes =
                        int.parse(_controllerWeightlifting.text);
                    print(weightliftingMinutes);
                  });
                },
              ),
            ],
          )));

  Future openDialogJumping() => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Minutos saltando'),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Saltando'),
              controller: _controllerJumping,
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  submit();
                  setState(() {
                    jumpingMinutes = int.parse(_controllerJumping.text);
                    print(jumpingMinutes);
                  });
                },
              ),
            ],
          )));

  Future openDialogDancing() => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: const Text('Minutos Bailando'),
            content: TextField(
              keyboardType: TextInputType.number,
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Bailar'),
              controller: _controllerDancing,
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  submit();
                  setState(() {
                    dancingMinutes = int.parse(_controllerDancing.text);
                    print(dancingMinutes);
                  });
                },
              ),
            ],
          )));

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            // homezmq (192:2)
            padding:
                EdgeInsets.fromLTRB(23 * fem, 11 * fem, 21 * fem, 134 * fem),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xff000000),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // rectangle2gPm (192:3)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 1 * fem, 6 * fem),
                  width: 89 * fem,
                  height: 84 * fem,
                  child: Image.asset(
                    'assets/page-1/images/rectangle-2-7yj.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  // calculodecaloriasC7D (192:9)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 6 * fem),
                  child: Text(
                    'Calculo de Calorias',
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
                  // group5tEw (192:13)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 32 * fem),
                  padding: EdgeInsets.fromLTRB(
                      23 * fem, 22 * fem, 23 * fem, 38 * fem),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff796988),
                    borderRadius: BorderRadius.circular(20 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // caloriasBE3 (192:15)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        child: Text(
                          'Calorias',
                          style: SafeGoogleFont(
                            'Nunito',
                            fontSize: 20 * ffem,
                            fontWeight: FontWeight.w700,
                            height: 1.3625 * ffem / fem,
                            color: const Color(0xffffffff),
                          ),
                        ),
                      ),
                      Text(
                        // totalcaloriasHns (192:16)
                        calculateCalories().toStringAsFixed(1),
                        style: SafeGoogleFont(
                          'Nunito',
                          fontSize: 20 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3625 * ffem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // autogroupzdsrDwR (QL7e2HYUBLbpKvLAD8ZDsR)
                  margin: EdgeInsets.fromLTRB(
                      27 * fem, 0 * fem, 28 * fem, 18 * fem),
                  width: double.infinity,
                  height: 79 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // group7wcX (195:36)
                        child: InkWell(
                          onTap: openDialogWalking,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 47 * fem, 0 * fem),
                            padding: EdgeInsets.fromLTRB(
                                24 * fem, 9 * fem, 23 * fem, 10 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff796988),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Center(
                              // caminar1FNK (195:35)
                              child: SizedBox(
                                width: 60 * fem,
                                height: 60 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/caminar-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: openDialogRunning,
                          child: Container(
                            // group8zUK (195:40)
                            padding: EdgeInsets.fromLTRB(
                                24 * fem, 9 * fem, 23 * fem, 10 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff796988),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Center(
                              // correrremovebgpreview1urB (195:38)
                              child: SizedBox(
                                width: 60 * fem,
                                height: 60 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/correr-removebg-preview-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                      25 * fem, 0 * fem, 28 * fem, 18 * fem),
                  width: double.infinity,
                  height: 79 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: openDialogCycling,
                          child: Container(
                            // group9AXD (195:41)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 49 * fem, 0 * fem),
                            padding: EdgeInsets.fromLTRB(
                                22 * fem, 10 * fem, 25 * fem, 9 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff796988),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Center(
                              // ciclismo1FYf (195:39)
                              child: SizedBox(
                                width: 60 * fem,
                                height: 60 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/ciclismo-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: openDialogWeightlifting,
                          child: Container(
                            // group10yzT (195:43)
                            padding: EdgeInsets.fromLTRB(
                                24 * fem, 10 * fem, 23 * fem, 9 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff796988),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Center(
                              // gimnasio1Jmq (195:42)
                              child: SizedBox(
                                width: 60 * fem,
                                height: 60 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/gimnasio-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // autogroupyexdq15 (QL7eL2Xud5eDhrg9r2YEXd)
                  margin: EdgeInsets.fromLTRB(
                      25 * fem, 0 * fem, 28 * fem, 54 * fem),
                  width: double.infinity,
                  height: 79 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: InkWell(
                          onTap: openDialogJumping,
                          child: Container(
                            // group11wZu (195:45)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 49 * fem, 0 * fem),
                            padding: EdgeInsets.fromLTRB(
                                22 * fem, 10 * fem, 25 * fem, 9 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff796988),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Center(
                              // saltar1ez7 (195:44)
                              child: SizedBox(
                                width: 60 * fem,
                                height: 60 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/saltar-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          onTap: openDialogDancing,
                          child: Container(
                            // group12b8f (195:47)
                            padding: EdgeInsets.fromLTRB(
                                24 * fem, 10 * fem, 23 * fem, 9 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff796988),
                              borderRadius: BorderRadius.circular(20 * fem),
                            ),
                            child: Center(
                              // bailarremovebgpreview1WWX (195:46)
                              child: SizedBox(
                                width: 60 * fem,
                                height: 60 * fem,
                                child: Image.asset(
                                  'assets/page-1/images/bailar-removebg-preview-1.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // autogroupums93WT (QL7eSwW4BAhsx88jUBuMs9)
                  margin:
                      EdgeInsets.fromLTRB(27 * fem, 0 * fem, 28 * fem, 0 * fem),
                  width: double.infinity,
                  height: 35 * fem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // group6Aqy (192:17)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 47 * fem, 0 * fem),
                        width: 107 * fem,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xff796988),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Calcular',
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
                      Container(
                        // group4bwH (192:4)
                        width: 107 * fem,
                        height: double.infinity,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GNav(
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
              if (_selectedIndex == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Home()));
              } else if (_selectedIndex == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const PostsPage()));
              }else if (_selectedIndex == 2) {
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
