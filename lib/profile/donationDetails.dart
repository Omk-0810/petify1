import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});


  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Pet Donations'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('pets')
          .where('userId',isEqualTo: user?.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final pets = snapshot.data!.docs;

            return ListView.builder(
              itemCount: pets.length,
              itemBuilder: (context, index) {
                final pet = pets[index];
                final petData = pet.data() as Map<String, dynamic>;
                final petId = pet.id;
               final totalDonations=pets.length;
                return Container(
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.all(15),
                  child: ListTile(
                    title: Text(petData['petName'] ?? 'Unknown Pet',
                      style: TextStyle(fontWeight: FontWeight.bold),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: ${petData['age']}'), // Display pet age
                        Text('Breed: ${petData['petBreed']}'), // Display pet breed
                         // Display total donations
                      ],
                    ),
                  ),
                );

                // Query the donations collection to get the total number of donations for this pet
              },
            );
          }
        },
      ),
    );
  }
}
