import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/LostAndFound/lostAndFound.dart';
import 'package:petify/Veterinarian/book.dart';
import 'package:petify/dashboard/navBar.dart';
import 'package:petify/profile/profile_page.dart';

class VetInfo extends StatefulWidget {
  const VetInfo({super.key});

  @override
  State<VetInfo> createState() => _VetInfoState();
}
final firebaseApp = Firebase.app();
DatabaseReference databaseReference  =
FirebaseDatabase.instanceFor(app:firebaseApp,databaseURL: 'https://petify-794fd-default-rtdb.asia-southeast1.firebasedatabase.app/' ).ref();

class _VetInfoState extends State<VetInfo> {
  int _selectedIndex=2;
  void _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          break;

        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LostAndFound()),
          );
          break;

        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => (VetInfo())),
          );

          break;
      }
    });
  }

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
              icon: Image.asset('assets/images/profile.webp'),
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[350],
      body:StreamBuilder<DatabaseEvent>(
          stream: databaseReference.child('veterinarian').onValue,
          builder: (BuildContext context, snapshot){

        if(!snapshot.hasData ||  snapshot.data!.snapshot.value == null){
          return Center(child: CircularProgressIndicator(),);
        }
        else{
          final dynamic data = snapshot.data!.snapshot.value;
           if (data is Map<dynamic, dynamic>)
           {
             log(data!.length.toString());
             return SizedBox(
                  child: ListView.builder(
                    itemCount: data?.length ?? 0,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final vetData =
                          data.values.toList()[index] as Map<dynamic, dynamic>;

                      return Container(
                        margin: EdgeInsets.all(10),
                        color: Colors.white,
                        height: 100,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(
                              'assets/images/vet.jpg',
                              height: 70,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              children: [
                                Text('${vetData?['name']}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('${vetData!['education']}'),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('${vetData!['experience']}'),
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional.center,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (vetData != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => BookAppointment(vet: vetData!),
                                      ),
                                    );
                                  } else {
                                    // Handle the case where vetData is null
                                  }
                                },
                                child: Text(
                                  'Book',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    side: BorderSide.none,
                                    shape: StadiumBorder()),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
    else {
             return Center(child: Text('Data is not in the expected format.'));
           }
            }
          }
          )


      ,bottomNavigationBar:  BottomNavigationBar(


        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.pets) ,label: "Donate & Adopt"),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Lost & Found"),
          BottomNavigationBarItem(icon: Icon(Icons.health_and_safety_outlined) ,label: " Veterinarian"),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onTapped,
      ),


    );
  }
}
