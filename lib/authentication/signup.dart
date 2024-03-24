import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/authentication/wrapper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}
final firebaseApp = Firebase.app();
DatabaseReference databaseReference  =
FirebaseDatabase.instanceFor(app:firebaseApp,databaseURL: 'https://petify-794fd-default-rtdb.asia-southeast1.firebasedatabase.app/' ).ref('users');
class _SignupState extends State<Signup> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController address=TextEditingController();



  Future <void>signup()async{
    try{
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      // Get.offAll(Wrapper());
      final String userId = userCredential.user!.uid;
      final Map<String, dynamic> userDataMap = {
        "name": name.text,
        "phone": phone.text,
        "email": email.text,
        "address": address.text,
        "id": userId,
        "role":"user",
      };
      await databaseReference.child(userId).set(userDataMap);      // print(usersRef.toString());
      // await usersRef.set(userDataMap);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Wrapper()));
    }on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)), // Display user-friendly error message
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Spacer(),
            Text('Petify',
              style: GoogleFonts.kaushanScript(textStyle:TextStyle(
                fontSize: 38,

                fontWeight: FontWeight.bold,
                color: Colors.black,
                letterSpacing: 1.5,
              ),
              ),
            ),
            SizedBox(child: Spacer(),height: 20,),
            Text('Create an Account',style: TextStyle(fontSize: 15,),),
            TextField(
              controller: name,
              decoration: InputDecoration(hintText:'Enter your name.' ),
            ),
            TextField(
              controller: phone ,
              decoration: InputDecoration(hintText:'Enter mobile no.' ),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText:'Enter email.' ),
            ),
            TextField(
              controller: address ,
              decoration: InputDecoration(hintText:'Enter your address.' ),
            ),
            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(hintText:'Enter password' ),
            ),
            SizedBox(child: Spacer(),height: 20,),


            ElevatedButton(onPressed: (()=>signup()), child: Text("Sign Up")),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
