import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/model/pet_model.dart';
import 'package:petify/profile/profile_page.dart';

class PetDetailsPage extends StatelessWidget {
  const PetDetailsPage({Key? key, required this.pet}) : super(key: key);

  final Pet pet;

  Future<void> sendRequestToUploader(String uploaderUid, context) async {
    final user = FirebaseAuth.instance.currentUser;

    // Create a request document with relevant information
    final requestData = {
      'requesterId': user!.uid,
      'petId': pet.petId,
      'uploaderId': uploaderUid,
      'status': "pending",
      'message': 'I am interested in adopting ${pet.name}', // Optional message
      'timestamp': DateTime.now().millisecondsSinceEpoch, // Timestamp
    };

    await FirebaseFirestore.instance.collection('requests').add(requestData);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Request submitted successfully!!!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.back();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
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
                Get.to(ProfileScreen());
              },
              icon: Image.asset('assets/images/profile.webp'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                width: 350,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                child: Image.network(
                  pet.imageUrl,
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                width: 350,
                decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),

                child: Column(
                  children: [
                    Text(
                      "Name: ${pet.name}",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Age: ${pet.age} months old",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Breed: ${pet.breed}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Gender: ${pet.gender}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        bool hasExistingRequest = false;

                        await FirebaseFirestore.instance
                            .collection('requests')
                            .where('petId', isEqualTo: pet.petId)
                            .where('requesterId', isEqualTo: user!.uid)
                            .get()
                            .then((snapshot) {
                          if (snapshot.docs.isNotEmpty) {
                            hasExistingRequest = true;
                          }
                        });
                        if (hasExistingRequest) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'You have already requested to adopt ${pet.name}!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              });
                        } else {
                          // If no existing request, proceed to send the request
                          await sendRequestToUploader(pet.userId, context);
                        }
                      },
                      child: Text('Adopt',style: TextStyle(color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          side: BorderSide.none,
                          shape: StadiumBorder()
                      ),
                    ),
                  ]

                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
