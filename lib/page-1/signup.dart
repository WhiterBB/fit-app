import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/page-1/login.dart';
//import 'package:flutter/gestures.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? errorMessage = '';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerSurname = TextEditingController();
  final TextEditingController _controllerGender = TextEditingController();
  final _messageKey = GlobalKey<ScaffoldMessengerState>();
  final db = FirebaseFirestore.instance;

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
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
    }
  }

  void createdSuccesfull(){
    _messageKey.currentState!.showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'OK', 
        message: 'Cuenta creada correctamente, procede con el inicio de sesión', 
        contentType: ContentType.success
      ),
      ));
  }

  Future<void> firstUserAdd() async {
    String email = Auth().currentUser!.email.toString();
    String uid = Auth().currentUser!.uid;
    String name = _controllerName.text.trim();
    String surname = _controllerSurname.text.trim();
    String gender = _controllerGender.text.trim();
    int dailysteps = 0;
    int calories = 0;
    int lastdaysavedDB = 0;

    print("UID: $uid");
    print("Email: $email");

    db.collection("users").doc("${uid}").set({
      'email': email,
      'accountCreated': Timestamp.now(),
      'name' : name,
      'surname' : surname,
      'gender' : gender,
      'height' : 0,
    }).onError((e, _) => print("Error writing document: $e"));
    print("Created new account");
    
    db.collection("users").doc("${uid}").collection("col").doc("activityinfo").set({
      'dailysteps': dailysteps,
      'calories' : calories,
      'lastdaysaved' : lastdaysavedDB,
    }).onError((error, stackTrace) => null);

    db.collection("users").doc("${uid}").collection("col").doc("activityinfo").collection("todaysteps").doc("todaysteps").set({
      'todayDayNo': 0,
      'todaySteps' : 0,
    }).onError((error, stackTrace) => null);

  }

  // Widget _errorMessage() {
  //   return Text(errorMessage == '' ? '' : 'Error: $errorMessage');
  // }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return MaterialApp(
      scaffoldMessengerKey: _messageKey,
        home: Scaffold(
            //resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/page-1/images/image-1-bg-KWH.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  // signupjnH (104:48)
                  padding: EdgeInsets.fromLTRB(
                      25 * fem, 50 * fem, 25 * fem, 38 * fem),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    gradient: LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(0, 1),
                      colors: <Color>[Color(0xcc000000), Color(0xcc000000)],
                      stops: <double>[0, 1],
                    ),
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // autogroup6f9kYUq (SWyYKzwQpbrkGgNXFH6f9K)
                          margin: EdgeInsets.fromLTRB(
                              48 * fem, 25 * fem, 28 * fem, 50 * fem),
                          padding: EdgeInsets.fromLTRB(
                              51 * fem, 0 * fem, 69 * fem, 0 * fem),
                          width: double.infinity,
                          child: Center(
                            // rectangle24xy (104:64)
                            child: SizedBox(
                              width: 114 * fem,
                              height: 108 * fem,
                              child: Image.asset(
                                'assets/page-1/images/rectangle-2-273.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // formoff (104:52)
                          padding: EdgeInsets.fromLTRB(
                              40 * fem, 25 * fem, 39.74 * fem, 30.23 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff796988),
                            borderRadius: BorderRadius.circular(40 * fem),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // registroWa5 (104:57)
                                  margin: EdgeInsets.fromLTRB(
                                      0.74 * fem, 0 * fem, 0 * fem, 50 * fem),
                                  child: Text(
                                    'Registro',
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 24 * ffem,
                                      fontWeight: FontWeight.w900,
                                      height: 1.3625 * ffem / fem,
                                      color: const Color(0xff1e1e1e),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group1ct1 (104:61)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 45.91 * fem),
                                  width: double.infinity,
                                  height: 23.09 * fem,
                                  child: TextField(
                                    controller: _controllerEmail,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                        hintText: 'E-mail'),
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3625 * ffem / fem,
                                      color: const Color(0xffcccccc),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group2K1j (104:58)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 46.33 * fem),
                                  width: double.infinity,
                                  height: 23.09 * fem,
                                  child: TextField(
                                    controller: _controllerPassword,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                        hintText: 'Contraseña'),
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3625 * ffem / fem,
                                      color: const Color(0xffcccccc),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group1ct1 (104:61)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 45.91 * fem),
                                  width: double.infinity,
                                  height: 23.09 * fem,
                                  child: TextField(
                                    controller: _controllerName,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                        hintText: 'Nombre'),
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3625 * ffem / fem,
                                      color: const Color(0xffcccccc),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group1ct1 (104:61)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 45.91 * fem),
                                  width: double.infinity,
                                  height: 23.09 * fem,
                                  child: TextField(
                                    controller: _controllerSurname,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                        hintText: 'Apellido'),
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3625 * ffem / fem,
                                      color: const Color(0xffcccccc),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group1ct1 (104:61)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 45.91 * fem),
                                  width: double.infinity,
                                  height: 23.09 * fem,
                                  child: TextField(
                                    controller: _controllerGender,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: const InputDecoration(
                                        hintText: 'Género'),
                                    style: SafeGoogleFont(
                                      'Nunito',
                                      fontSize: 14 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3625 * ffem / fem,
                                      color: const Color(0xffcccccc),
                                    ),
                                  ),
                                ),
                                Container(
                                  // loginbtn1fF (104:54)
                                  margin: EdgeInsets.fromLTRB(22.23 * fem,
                                      0 * fem, 23.4 * fem, 0 * fem),
                                  width: double.infinity,
                                  height: 45.34 * fem,
                                  child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xffb1acc5),
                                        borderRadius:
                                            BorderRadius.circular(40 * fem),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Sign Up',
                                          style: SafeGoogleFont(
                                            'Nunito',
                                            fontSize: 18 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3625 * ffem / fem,
                                            color: const Color(0xff796988),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () =>
                                        createUserWithEmailAndPassword().then((value) {
                                          FirebaseAuth.instance
                                          .authStateChanges()
                                          .listen((user) {
                                        if (user != null) {
                                          firstUserAdd();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Login()));
                                          // _messageKey.currentState!.showSnackBar(
                                          //   const SnackBar(content: Text('Ingreso correctamente')),
                                          // );
                                        } else {
                                          // _messageKey.currentState!.showSnackBar(
                                          //   const SnackBar(content: Text('No ingreso xd')),
                                          // );
                                        }
                                      });
                                        })
                                  ),
                                ),
                              ]),
                        ),
                      ]),
                ),
              ),
            )));
  }
}
