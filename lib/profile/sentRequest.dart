import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:petify/profile/profile_page.dart';
import 'package:petify/profile/receivedRequestDetails.dart';
import 'package:petify/profile/requestDetails.dart';
import 'package:petify/profile/showRequests.dart';

class SentRequestScreen extends StatefulWidget {
  const SentRequestScreen({Key? key}) : super(key: key);

  @override
  State<SentRequestScreen> createState() => _SentRequestScreenState();
}

class _SentRequestScreenState extends State<SentRequestScreen> {
  final user = FirebaseAuth.instance.currentUser; // Assuming user is fetched
  int _selectedIndex = 1;
  String labelText = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {

        case 0:
          Get.to(RequestScreen());

          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption Requests'),
      ),
      bottomNavigationBar: BottomNavigationBar(


        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_down_outlined), label: "Received"),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_circle_up_outlined), label: "sent"),

        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('requests')
            .where(
            'requesterId', isEqualTo: user!.uid) // Filter by uploader ID
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          if (documents.isEmpty) {
            return Center(child: Text('No adoption requests yet.'));
          }

          return ListView.builder(
            itemCount: documents.length,
            // ... (existing code)

            itemBuilder: (context, index) {
              final requestData = documents[index].data() as Map<
                  String,
                  dynamic>;
              final petId = requestData['petId'];

              return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance.collection('pets').doc(
                    petId).get(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot
                        .error}'); // Handle error gracefully
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }


                  final petData = snapshot.data?.data() as Map<
                      String,
                      dynamic>;
                  final petName = petData?['petName'];

                  return Container(
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(15),
                    child: ListTile(
                      title: Text('Request for $petName',
                        style: TextStyle(fontWeight: FontWeight.bold),),
                      trailing: IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                ReceivedRequestDetails(requestData: requestData,),),);
                        },
                      ),
                    ),
                  );
                },
              );
            },


          );
        },
      ),

    );
  }
}





