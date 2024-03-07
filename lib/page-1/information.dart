import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/page-1/posts.dart';
import 'package:myapp/page-1/welcome.dart';
import 'package:myapp/utils.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/rootpage.dart';

class UpdateInformation extends StatefulWidget {
  const UpdateInformation({super.key});

  @override
  State<UpdateInformation> createState() => _UpdateInformationState();
}

class _UpdateInformationState extends State<UpdateInformation> {
  @override
  void initState() {
    //readCurrentUserInfo();
    print("got data");
    super.initState();
  }

  String? errorMessage = '';
  final TextEditingController _controllerAge = TextEditingController();
  final TextEditingController _controllerWeight = TextEditingController();
  final TextEditingController _controllerHeight = TextEditingController();
  final TextEditingController _controllerWeeklyActivity =
      TextEditingController();
  final _messageKey = GlobalKey<ScaffoldMessengerState>();
  final db = FirebaseFirestore.instance;
  final User? user = Auth().currentUser;
  String? currentName;
  String? currentSurname;
  String? currentGender;
  bool enabledForm = true;
  int _selectedIndex = 0;

  // Future<void> test() async{
  //   String uid = Auth().currentUser!.uid;
  //   String addSome = _controllerName.text.trim();

  //   db.collection("users").doc("${uid}").collection("col").doc("activityinfo").update({
  //     'some' : addSome,
  //     'uwu' : "uwu",
  //   }).onError((error, stackTrace) => null);
  // }

  // Future<void> readCurrentUserInfo() async{
  //   String uid = Auth().currentUser!.uid;

  //   print("getting data");

  //   db.collection("users").doc("${uid}").get().then((DocumentSnapshot ds) async{
  //     currentName = ds['name'];
  //     currentSurname = ds['surname'];
  //     currentGender = ds['gender'];
  //   });

  // }

  Future<void> updateUserInfo() async {
    String uid = Auth().currentUser!.uid;
    // String name = _controllerName.text.trim();
    // String surname = _controllerSurname.text.trim();
    // String gender = _controllerGender.text.trim();
    int age = int.parse(_controllerAge.text.trim());
    int weight = int.parse(_controllerWeight.text.trim());
    int height = int.parse(_controllerHeight.text.trim());
    String weeklyactivity = _controllerWeeklyActivity.text.trim();

    // print("fill current");
    // if(currentName!= '' || currentSurname!= '' || currentGender!= ''){
    //   name = currentName!;
    //   surname = currentSurname!;
    //   gender = currentGender!;
    //   setState(() {
    //     enabledForm = false;
    //   });
    // }

    db.collection("users").doc("${uid}").update({
      'age': age,
      'weight': weight,
      'height': height,
      'weeklyactivity': weeklyactivity,
    }).onError((e, _) {
      setState(() {
        errorMessage = e.toString();
      });
      _messageKey.currentState!.showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        //forceActionsBelow: true,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: errorMessage.toString(),
          contentType: ContentType.failure,
          //inMaterialBanner: true,
        ),
        //actions: const [SizedBox.shrink()],
      ));
    });
  }

  void updatedSuccesfull() {
    _messageKey.currentState!.showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
          title: 'OK',
          message: 'Se ha guardado los datos correctamente',
          contentType: ContentType.success),
    ));
  }

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
        backgroundColor: const Color(0xff000000),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              // homeKjo (105:66)
              padding: EdgeInsets.fromLTRB(1 * fem, 20 * fem, 0 * fem, 0 * fem),
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
                        0 * fem, 50 * fem, 0 * fem, 20 * fem),
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
                        0 * fem, 0 * fem, 0 * fem, 13 * fem),
                    child: Text(
                      'Actualizar Información',
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
                        25 * fem, 0 * fem, 26 * fem, 30 * fem),
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
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          child: TextField(
                            controller: _controllerAge,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Edad',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              //fillColor: Colors.grey[400],
                              //filled: true,
                            ),
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          child: TextField(
                            controller: _controllerWeight,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Peso en KG',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              //fillColor: Colors.grey[400],
                              //filled: true,
                            ),
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          child: TextField(
                            controller: _controllerHeight,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Altura',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              //fillColor: Colors.grey[400],
                              //filled: true,
                            ),
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          child: TextField(
                            controller: _controllerWeeklyActivity,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: 'Horas de actividad física a la semana',
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              //fillColor: Colors.grey[400],
                              //filled: true,
                            ),
                            style: SafeGoogleFont(
                              'Nunito',
                              fontSize: 14 * ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.3625 * ffem / fem,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(
                  //       0 * fem, 0 * fem, 0 * fem, 0 * fem),
                  //   width: double.infinity,
                  //   height: 35 * fem,
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  Container(
                    // group42ef (170:4)
                    margin: EdgeInsets.fromLTRB(
                        100 * fem, 0 * fem, 100 * fem, 20 * fem),
                    width: double.infinity,
                    height: 30 * fem,
                    child: InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff796988),
                          borderRadius: BorderRadius.circular(20 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Guardar',
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
                      onTap: () => updateUserInfo().then(
                        (value) {
                          //test();
                          FirebaseAuth.instance
                              .authStateChanges()
                              .listen((user) {
                            if (user != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()));
                            }
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    // group42ef (170:4)
                    margin: EdgeInsets.fromLTRB(
                        100 * fem, 0 * fem, 100 * fem, 20 * fem),
                    width: double.infinity,
                    height: 30 * fem,
                    child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xff796988),
                            borderRadius: BorderRadius.circular(20 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Cerrar Sesión',
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
                      ),),
                  ),
                ],
              ),
              //   ),
              // ]),
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
              } else if (_selectedIndex == 2) {
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
