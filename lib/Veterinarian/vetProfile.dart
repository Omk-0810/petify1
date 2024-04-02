import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petify/Veterinarian/apply.dart';
import 'package:petify/appointment/viewAppointments.dart';
import 'package:petify/profile/edit_profile.dart';

class ProfileScreenVet extends StatelessWidget {

  ProfileScreenVet({super.key});
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.snackbar("Logged Out!", "");
    } catch (error) {
      Get.snackbar("Logout Error", error.toString());
    }
  }

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
          "Petify",
          style: GoogleFonts.kaushanScript().copyWith(fontSize: 30),
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
              SizedBox(width: 120,
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),child: Image(image: AssetImage('assets/images/profile.webp'),),
                ),),
              const SizedBox(height: 10),
              Text('${user!.email}'),
              const SizedBox(height: 10),
              SizedBox(width: 200,
                  child: ElevatedButton(
                    onPressed: (){
                     Get.to(EditProfile());
                     },
                    child: Text('Edit profile',style:TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor:Colors.black,side: BorderSide.none,shape: StadiumBorder() ),

                  )),
              SizedBox(height: 30),
              Divider(),
              SizedBox(height: 10),

              ProfileMenuWidget(title: "settings",icon: LineAwesomeIcons.cog,onPress: (){},),
              ProfileMenuWidget(title: "Delete profile",icon: Icons.delete,onPress: (){}),
              ProfileMenuWidget(title: "Logout",
                icon: LineAwesomeIcons.alternate_sign_out,
                onPress: () async{
                await signout();
                  Get.snackbar("Profile Clicked!", "");
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon=true,

  });
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: onPress,
        leading: Container(
          width: 30,height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),

          ),
          child: Icon(icon,color: Colors.blueAccent,),
        ),
        title: Text(title,),
        trailing:
        endIcon? Container(
            width: 30,height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),

            ),
            child: Icon(LineAwesomeIcons.angle_right,color: Colors.blueAccent,)):null
    );
  }
}
