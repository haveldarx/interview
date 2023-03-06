import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview1/signin_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  

  TextButton getButton(bool isAndroid, BuildContext context) {
    return TextButton(
      onPressed: () async {
      SignInController controller = SignInController();
     await  controller.googleSignIn(context);
     

      },
      style: TextButton.styleFrom(
        backgroundColor: Color(0xff6c63ff),
        maximumSize: Size(MediaQuery.of(context).size.width * 0.635, 55),
      ),
      child: Container(
        child: Row(children: [
          Container(
            height: 35,
            width: 35,
            margin: const EdgeInsets.only(left: 10),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
            child: Container(
              height: 20,
              margin: EdgeInsets.all(2),
              child: SvgPicture.asset(
                'assets/images/google.svg',
              ),
            ),
          ),
          if (isAndroid)
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Text('Continue with Google',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
          if (!isAndroid)
            Container(
              margin: const EdgeInsets.only(left: 8),
              child: const Text('Continue with Apple',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500)),
            ),
        ]),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Center(child: getButton(true, context))
      ]),
    );
  }
}