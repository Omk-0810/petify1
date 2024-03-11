import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/authentication/wrapper.dart';
class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  forgetPass()async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
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

            Text('Enter an email ,you will receive the link to your      email id to reset the password.'),
            SizedBox(child: Spacer(),height: 20,),
            TextField(
              controller: email,
              decoration: InputDecoration(hintText:'Enter email' ),
            ),
            SizedBox(child: Spacer(),height: 20,),
            ElevatedButton(onPressed: (()=>forgetPass()), child: Text("send link")),
            Spacer(),

          ],
        ),
      ),


    );
  }
}