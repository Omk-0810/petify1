import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VetLogin extends StatefulWidget {
  const VetLogin({super.key});


  @override
  State<VetLogin> createState() => _VetLoginState();
}

class _VetLoginState extends State<VetLogin> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Veterinarian?'),
                    TextButton(onPressed: (()=>Get.to(ForgotPass())), child: Text("Login here")),

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
}
