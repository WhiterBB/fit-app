import 'package:flutter/material.dart';
//import 'package:flutter/gestures.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/utils.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage (
            image: AssetImage (
              'assets/page-1/images/image-1-bg-cb3.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
      
      child: Container(
        // loginJp9 (104:27)
        padding: EdgeInsets.fromLTRB(25*fem, 94*fem, 25*fem, 38*fem),
        width: double.infinity,
        decoration: BoxDecoration (
          color: Color(0xffffffff),
          gradient: LinearGradient (
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
              margin: EdgeInsets.fromLTRB(48*fem, 0*fem, 28*fem, 144*fem),
              padding: EdgeInsets.fromLTRB(51*fem, 0*fem, 69*fem, 0*fem),
              width: double.infinity,
              child: Center(
                // rectangle2pvu (104:33)
                child: SizedBox(
                  width: 114*fem,
                  height: 108*fem,
                  child: Image.asset(
                    'assets/page-1/images/rectangle-2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              // formxXK (104:36)
              padding: EdgeInsets.fromLTRB(35*fem, 97*fem, 37*fem, 30.23*fem),
              width: double.infinity,
              decoration: BoxDecoration (
                color: Color(0xff796988),
                borderRadius: BorderRadius.circular(40*fem),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // bienvenidoafitappef3 (104:37)
                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 72*fem),
                    child: Text(
                      'Bienvenido a FitAPP',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 24*ffem,
                        fontWeight: FontWeight.w900,
                        height: 1.3625*ffem/fem,
                        color: Color(0xff1e1e1e),
                      ),
                    ),
                  ),
                  Container(
                    // group1MJZ (104:44)
                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 2.74*fem, 45.91*fem),
                    width: double.infinity,
                    height: 23.09*fem,
                    child: Text(
                      'E-mail',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3625*ffem/fem,
                        color: Color(0xffcccccc),
                      ),
                    ),
                  ),
                  Container(
                    // group22fb (104:45)
                    margin: EdgeInsets.fromLTRB(5*fem, 0*fem, 2.74*fem, 46.33*fem),
                    width: double.infinity,
                    height: 23.09*fem,
                    child: Text(
                      'Contraseña',
                      style: SafeGoogleFont (
                        'Nunito',
                        fontSize: 14*ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.3625*ffem/fem,
                        color: Color(0xffcccccc),
                      ),
                    ),
                  ),
                  Container(
                    // loginbtnJt1 (104:28)
                    margin: EdgeInsets.fromLTRB(27.23*fem, 0*fem, 26.15*fem, 0*fem),
                    width: double.infinity,
                    height: 45.34*fem,
                    decoration: BoxDecoration (
                      color: Color(0xffb1acc5),
                      borderRadius: BorderRadius.circular(40*fem),
                    ),
                    child: Center(
                      child: Text(
                        'Login',
                        style: SafeGoogleFont (
                          'Nunito',
                          fontSize: 18*ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3625*ffem/fem,
                          color: Color(0xff796988),
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
      
          );
  }
}