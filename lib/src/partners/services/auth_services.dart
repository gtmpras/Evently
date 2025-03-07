
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/core/constants/route_constants.dart';
import 'package:evently/src/partners/models/evently_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //Google SignIn
  Future<bool> signInWithGoogle()async{
    try{
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      if(gUser == null){
        return false;
      }

      //obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      //create a new credential for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken
      );

      //Sign In to firebase with google credentials
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      //check user signed in successfully
      if(userCredential.user != null){
        //save user data to firestore

        await _saveUserData(userCredential.user!);
        return true;
      }
    }
    catch (e){
      print("Google sign-in error: $e");
      return false;
    }

    return false;


  }

//save user data
Future <void> _saveUserData(User user) async {
  try {
   // FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    await users.doc(user.uid).set({
      'uid': user.uid,
      'displayname': user.displayName,
      'email': user.email,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
  catch(e){
    print("Error sacing user data to firestore: $e");
  }
}

//Fetch all the active events from FireStore
Future<List<ActiveEvent>> fetchActiveEvents()async{
  try{
    var snapshot = await firestore.collection('ActiveEvents').get();
    return snapshot.docs.map((doc){
    return ActiveEvent(
      docId: doc.id,
      eventName: doc['eventName'],
      eventDesc: doc['eventDesc'], 
      location: doc['location'],
      bannerPhoto: doc['bannerPhoto'], 
      hostName: doc['hostName'],
      eventDate: (doc['eventDate']as Timestamp).toDate(),
    );
  }).toList();
  }catch (e){
    throw Exception("Error fetching events: $e");
  }
}


//Add a new active event
Future<void> addActiveEvent(ActiveEvent event)async{
  try{
    await firestore.collection('ActiveEvents').add({
      'eventName': event.eventName,
      'eventDesc': event.eventDesc,
      'location':event.location,
      'bannerPhoto': event.bannerPhoto,
      'hostName': event.hostName,
      'eventDate': event.eventDate
    });
  }catch(e){
    throw Exception("Error adding event: $e");
  }
}


//Logout
Future<void> signOut(BuildContext context) async{
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().signOut();

  //After successful sign-out, navigate to the login screen
  context.go(AppRoutes.login);
  print("Signed out successfully");
  

}
}