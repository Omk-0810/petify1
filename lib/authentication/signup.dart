import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/authentication/wrapper.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  signup()async{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);
    Get.offAll(Wrapper());
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
              controller: email,
              decoration: InputDecoration(hintText:'Enter email' ),
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
