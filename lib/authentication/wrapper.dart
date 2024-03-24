import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petify/Veterinarian/veteDash.dart';
import 'package:petify/authentication/login.dart';
import 'package:petify/authentication/signup.dart';
import 'package:petify/dashboard/donation.dart';
import 'package:petify/dashboard/onBoarding.dart';
import 'package:petify/authentication/verifyemail.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}
final firebaseApp = Firebase.app();
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseDatabase _database = FirebaseDatabase.instanceFor(app:firebaseApp,databaseURL: 'https://petify-794fd-default-rtdb.asia-southeast1.firebasedatabase.app/' );

class _WrapperState extends State<Wrapper> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User? currentUser = snapshot.data;
          if (currentUser != null && currentUser.emailVerified) {
            return StreamBuilder<DatabaseEvent>(
              stream: _database.ref('users/${currentUser.uid}/role').onValue,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final String role = snapshot.data!.snapshot.value as String;
                  return getWidgetForRole(role); // Handle routing based on role
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return Verify();
          }
        } else {
          return Login();
        }
      },
    );
  }

  Widget getWidgetForRole(String role) {
    switch (role) {
      case 'admin':
        return VetDashBoard(); // Replace with admin-specific widget
      case 'user':
        return WelcomeScreen(); // Replace with user-specific widget
      default:
        return const Center(child: Text('Unauthorized Role'));
    }
  }
}
