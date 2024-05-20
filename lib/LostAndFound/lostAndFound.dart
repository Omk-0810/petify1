import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petify/LostAndFound/lostAndFoundForm.dart';
import 'package:petify/dashboard/navBar.dart';
import 'package:petify/dashboard/onBoarding.dart';
import 'package:petify/model/lostAndFoundModel.dart';
import 'package:petify/profile/profile_page.dart';

class LostAndFound extends StatefulWidget {
  const LostAndFound({super.key});

  @override
  _LostAndFoundState createState() => _LostAndFoundState();
}

class _LostAndFoundState extends State<LostAndFound> {
  final user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  List<LostFound> pets = [];
  int _selectedIndex = 1;
  String labelText='';

  @override
  void initState() {
    super.initState();
    _onItemTapped(_selectedIndex);
  }


  signout() async {
    await FirebaseAuth.instance.signOut();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );

          break;
        case 1:
          labelText='Lost Pets...';
          Stream<QuerySnapshot<Map<String, dynamic>>> petsStream =
          _firestore.collection('LostAndFound').snapshots();
          Get.snackbar("Lost!", "");
          petsStream.listen((snapshot) {
            pets = snapshot.docs.map((doc) => LostFound.fromMap(doc.data()))
                .toList();
            pets = pets.where((pet) => pet.casee == "Lost").toList();
            setState(() {

            });
            print(pets);
          });

          break;
        case 2:
          labelText='Found Pets...';

          Stream<QuerySnapshot<Map<String, dynamic>>> petsStream =
          _firestore.collection('LostAndFound').snapshots();
          Get.snackbar("Found!", "");
          petsStream.listen((snapshot) {
            pets = snapshot.docs.map((doc) => LostFound.fromMap(doc.data()))
                .toList();
            pets = pets.where((pet) => pet.casee == "Found").toList();
            setState(() {

            });
            print(pets);
          });
          break;
      }
    });
  }

  // final Pet pet;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(

        // leading: const Icon(
        //   Icons.menu,
        //   color: Colors.black,
        // ),
        title: Text(
          "Petify",
          style: GoogleFonts.kaushanScript().copyWith(fontSize: 30),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,

      ),
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(labelText, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Display the label

              Stack(children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // itemCount: pets.length,
                  scrollDirection: Axis.vertical,
                  itemCount: pets.length, // Use filteredPets list
                  itemBuilder: (context, index) {
                    LostFound pet = pets[index];
                    return buildPetContainer(pet);
                  },

                ),
              ]),
            ],
          ),
        ),
      ),
     bottomNavigationBar:  BottomNavigationBar(


          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.pets), label: "Donate & Adopt"),
            BottomNavigationBarItem(icon: Icon(LineAwesomeIcons.search), label: "Lost"),
            BottomNavigationBarItem(
                icon: Icon(LineAwesomeIcons.lightbulb_1), label: "Found"),
          ],
       currentIndex: _selectedIndex,
       selectedItemColor: Colors.amber[800],
       onTap: _onItemTapped,
     ),



    );
  }

  Widget buildPetContainer(LostFound pet) {
    return Column(
      children: [
        Container(

          // height: 240,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                  child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: 200,
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)
                        )
                    ),
                    child: Align(
                      child: Image.network(
                        pet.imageUrl,
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              )),
              Expanded(
                  child: Stack(
                children: [
                  Container(
                      height: 200,
                      width: 150,
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      decoration: BoxDecoration(color: Colors.white,

                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 50),
                          Text(
                            pet.casee,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),

                          Text(
                            pet.breed,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(Icons.location_on),
                              Flexible(
                                child: Text(
                                  "  ${pet.address} ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 5),

                        ],
                      )),
                ],
              ))
            ],
          ),
        ),
        Container(height: 1,color: Colors.grey,)
      ],
    );
  }
}
