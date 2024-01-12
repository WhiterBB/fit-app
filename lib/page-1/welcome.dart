import 'package:flutter/material.dart';
import 'package:myapp/page-1/login.dart';
import 'package:myapp/page-1/signup.dart';
//import 'package:flutter/gestures.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

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
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/page-1/images/image-1-bg.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              // welcomeXVK (101:3)
              padding:
                  EdgeInsets.fromLTRB(30 * fem, 106 * fem, 30 * fem, 60 * fem),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xffffffff),
                gradient: LinearGradient(
                  begin: Alignment(0, -1),
                  end: Alignment(0, 1),
                  colors: <Color>[Color(0x00000000), Color(0xcc000000)],
                  stops: <double>[0, 1],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // autogroupuu8dye9 (SWyXcX8XW5Uno5d3WJuu8D)
                    margin: EdgeInsets.fromLTRB(
                        37 * fem, 0 * fem, 23 * fem, 312 * fem),
                    padding:
                        EdgeInsets.fromLTRB(0 * fem, 8 * fem, 0 * fem, 0 * fem),
                    width: double.infinity,
                    child: Align(
                      // rectangle2sjX (103:25)
                      alignment: Alignment.bottomLeft,
                      child: SizedBox(
                        width: 225 * fem,
                        height: 213 * fem,
                        child: Image.asset(
                          'assets/page-1/images/rectangle-2-hj7.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      // loginbtnyGm (103:12)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 23 * fem),
                      width: double.infinity,
                      height: 58 * fem,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffb1acc5),
                            borderRadius: BorderRadius.circular(20 * fem),
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 24 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.3625 * ffem / fem,
                                color: const Color(0xff796988),
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                      )),
                  Container(
                    // notienesunacuentaregstrateC9X (103:13)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 7 * fem, 0 * fem),
                    child: InkWell(
                      child: RichText(
                        text: TextSpan(
                          style: SafeGoogleFont(
                            'Nunito',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3625 * ffem / fem,
                            color: const Color(0xffaabdcc),
                          ),
                          children: [
                            const TextSpan(
                              text: '¿No tienes una cuenta? ',
                            ),
                            TextSpan(
                              text: 'Regístrate',
                              style: SafeGoogleFont(
                                'Nunito',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w800,
                                height: 1.3625 * ffem / fem,
                                decoration: TextDecoration.underline,
                                color: const Color(0xffffffff),
                                decorationColor: const Color(0xffffffff),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => const SignUp())));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
