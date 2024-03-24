import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/authentication/wrapper.dart';
import 'package:petify/model/pet_model.dart';
import 'package:petify/dashboard/dog_adopt.dart';
import 'package:petify/dashboard/cat_adopt.dart';
import 'package:petify/dashboard/donation.dart';
import 'package:petify/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';





class VetDashBoard extends StatefulWidget {
  const VetDashBoard({super.key});

  @override
  State<VetDashBoard> createState() => _VetDashBoardState();
}

class _VetDashBoardState extends State<VetDashBoard> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }


  signout() async {
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
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
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: Icon(Icons.supervised_user_circle),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              //categories
              SizedBox(
                width: double.infinity,
                height: 80,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 90,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => PetInformationForm()),
                                    );

                                  },
                                  icon: Image.asset(
                                    'assets/images/donate.png',
                                    width: 40,
                                    height: 40,
                                  )),
                              // SizedBox(height: 5),

                              Text(
                                "Edit appointments",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 90,
                          height: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Image.asset(
                                    'assets/images/support.jpg',
                                    width: 40,
                                    height: 40,
                                  )),
                              // SizedBox(height: 5),

                              Text(
                                "Help & Support",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(left: BorderSide(width: 4))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available appointments...',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}
