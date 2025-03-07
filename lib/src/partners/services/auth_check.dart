import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/src/screens/home_screen.dart';
import 'package:evently/src/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  //function to check if user data exists in Firestore
  Future<bool> _checkUserDataExists(String uid) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(uid).get();

      //If the user document does't exists, return false;

      return userDoc.exists;
    } catch (e) {
      print("Error checking user data $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }

        //If the user is signed in
        if(snapshot.hasData){
          String uid = snapshot.data!.uid;

        //check if the user data exists in Firestore
        return FutureBuilder<bool>(
          future: _checkUserDataExists(uid), 
          builder: (context,userSnapshots){
            if(userSnapshots.connectionState ==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            //if user data doesn't exists, sign them out and show the SignInPage
            if(userSnapshots.hasData && !userSnapshots.data!){
              FirebaseAuth.instance.signOut();
              return const LoginScreen();
            }

            //if user data exists, navigate to the HomePage
            return HomeScreen();
          });
        }

        //if the user is not singed in , show the SingInPage
        return const LoginScreen();
      });
  }
}
