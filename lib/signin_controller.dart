
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview1/authentication_screen.dart';
import 'package:interview1/homeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController{
  FirebaseAuth auth = FirebaseAuth.instance;

  ///Storing _googlesignin from Google sign in constructor

  final _googlesignin = GoogleSignIn();
  SharedPreferences? prefs;
  late GoogleSignInAccount? googleSignUser;
  googleSignIn (BuildContext context)async {
  

    
         googleSignUser = await _googlesignin.signIn();

    if (googleSignUser != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignUser!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    prefs = await SharedPreferences.getInstance();
    prefs!.setString(
        "name", googleSignUser!.displayName.toString());
    prefs!.setString("mailID", googleSignUser!.email);
    prefs!.setString("ProfileURL", googleSignUser!.photoUrl.toString());
    prefs!.setString("UniqueId", googleSignUser!.id);
    //added id code
    ///Calls user setup function after signing in and sets up the user in the database
    

    ///Checks if user is null or not
    ///
    try {
      if (googleSignUser == null) {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => const AuthenticationScreen() )));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: ((context) => const HomeScreen() )));
      }
    } catch (e) {
      // print(e);
    }
  }
}