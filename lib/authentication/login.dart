import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petify/authentication/signup.dart';
import 'package:petify/authentication/forgetpass.dart';
import 'package:google_fonts/google_fonts.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  bool isloading=false;
  signIn()async{
    setState(() {
      isloading=true;
    });
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text, password: password.text);
    }on FirebaseAuthException catch(e){
      Get.snackbar("error msg", e.code);
    }catch(e){
      Get.snackbar("error msg", e.toString());
    }
    setState(() {
      isloading=false;
    });
  }

  @override
  Widget build(BuildContext context) => isloading?Center(child: CircularProgressIndicator(),):
  Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(
              children: [
                SizedBox(child: Spacer(),height: 100,),
        
                Text('Petify',
                style: GoogleFonts.kaushanScript(textStyle:TextStyle(
                  fontSize: 38,
        
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.5,
                ),
                ),
                ),
                Image.asset('assets/images/petlogin.png',
                  width: 200,
                  height: 200,),
                SizedBox(child: Spacer()),
        
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(hintText:'Enter email' ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
        
                TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(hintText:'Enter password' ),
                ),
                SizedBox(child: Spacer(),height: 20,),
        
        
        
                ElevatedButton(onPressed: (()=>signIn()), child: Text("Login")),
                SizedBox(child: Spacer()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Dont have an account?'),
                    TextButton(onPressed: (()=>Get.to(Signup())), child: Text("Click here!")),
        
                  ],
                ),
                SizedBox(child: Spacer()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Forgotten your login details?'),
                    TextButton(onPressed: (()=>Get.to(ForgotPass())), child: Text("Forget Password")),
        
                  ],
                ),
                SizedBox(child: Spacer()),

              ],
            ),
          ),
        ),
      ),


    );
}
