import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class EditProfile extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          "Edit Profile",
          style: GoogleFonts.siemreap().copyWith(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white70),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(initialValue:'${user!.email}' ,enabled:false,decoration: InputDecoration(prefixIcon: (Icon(LineAwesomeIcons.inbox))),
              ),
              SizedBox(height: 20,),
              TextFormField(decoration: InputDecoration(label: Text("Full Name"),prefixIcon: (Icon(LineAwesomeIcons.user))),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Phone No",
                  prefixIcon: Icon(LineAwesomeIcons.phone),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your phone number';
                  }
                  if (value?.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20,),
              TextFormField(decoration: InputDecoration(label: Text("Address"),prefixIcon: (Icon(LineAwesomeIcons.user))),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (){},
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.amber ,side: BorderSide.none,shape: StadiumBorder()),
                  child: Text('Edit Profile',style: TextStyle(color: Colors.black),))


            ],
          ),
        ),
      ),
    );
  }
}
