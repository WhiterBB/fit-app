import 'package:flutter/material.dart';
import 'package:myapp/page-1/home.dart';
import 'package:myapp/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/auth.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? errorMessage = '';
  bool isLogin = false;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _messageKey = GlobalKey<ScaffoldMessengerState>();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      setState(() {
        isLogin = true;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
      _messageKey.currentState!.showSnackBar(SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: errorMessage.toString(),
          contentType: ContentType.failure,
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return MaterialApp(
      scaffoldMessengerKey: _messageKey,
      home: Scaffold(
          body: SingleChildScrollView(
              child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/page-1/images/image-1-bg-cb3.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // loginJp9 (104:27)
          padding: EdgeInsets.fromLTRB(25 * fem, 94 * fem, 25 * fem, 38 * fem),
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
                // autogroupfkbwhrH (SWyXuvoBoz4ToNBjT2fKBw)
                margin:
                    EdgeInsets.fromLTRB(48 * fem, 0 * fem, 28 * fem, 144 * fem),
                padding:
                    EdgeInsets.fromLTRB(51 * fem, 0 * fem, 69 * fem, 0 * fem),
                width: double.infinity,
                child: Center(
                  // rectangle2pvu (104:33)
                  child: SizedBox(
                    width: 114 * fem,
                    height: 108 * fem,
                    child: Image.asset(
                      'assets/page-1/images/rectangle-2.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                // formxXK (104:36)
                padding: EdgeInsets.fromLTRB(
                    35 * fem, 50 * fem, 37 * fem, 30.23 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff796988),
                  borderRadius: BorderRadius.circular(40 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // bienvenidoafitappef3 (104:37)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 50 * fem),
                      child: Text(
                        'Bienvenido a FitAPP',
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
                      // group1MJZ (104:44)
                      margin: EdgeInsets.fromLTRB(
                          5 * fem, 0 * fem, 2.74 * fem, 45.91 * fem),
                      width: double.infinity,
                      height: 50 * fem,
                      child: TextField(
                        controller: _controllerEmail,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          hintText: 'Correo Electrónico',
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(6),
                              ),
                        ),
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
                      // group22fb (104:45)
                      margin: EdgeInsets.fromLTRB(
                          5 * fem, 0 * fem, 2.74 * fem, 46.33 * fem),
                      width: double.infinity,
                      height: 50 * fem,
                      child: TextField(
                        controller: _controllerPassword,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration:
                            InputDecoration(
                              hintText: "Contraseña",
                              enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(6),
                              ),
                              ),
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
                      // loginbtnJt1 (104:28)
                      margin: EdgeInsets.fromLTRB(
                          27.23 * fem, 0 * fem, 26.15 * fem, 0 * fem),
                      width: double.infinity,
                      height: 45.34 * fem,
                      child: InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffb1acc5),
                              borderRadius: BorderRadius.circular(40 * fem),
                            ),
                            child: Center(
                              child: Text(
                                'Iniciar Sesión',
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
                          onTap: () => signInWithEmailAndPassword().then(
                                (value) {
                                  FirebaseAuth.instance
                                      .authStateChanges()
                                      .listen((user) {
                                    if (user != null) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Home()));
                                    } else {
                                    }
                                  });
                                },
                              )),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ))),
    );
  }
}
