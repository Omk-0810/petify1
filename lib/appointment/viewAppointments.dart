import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/profile/profile_page.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({super.key});

  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  final CollectionReference _appointments = FirebaseFirestore.instance.collection('appointments');
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // Fetch appointments for the current user
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> _getAppointments() async {
    if (currentUser == null) {
      return []; // Handle case where user is not logged in
    }
    final snapshot = await _appointments.where('aptBy', isEqualTo: currentUser!.uid).get();
    return snapshot.docs.cast<QueryDocumentSnapshot<Map<String, dynamic>>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Leading: const Icon(
        //   Icons.menu,
        //   color: Colors.black,
        // ),
        title: Text(
          "Your appointments",
          style:TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
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
      body: FutureBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        future: _getAppointments(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error fetching appointments'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final appointments = snapshot.data!;

          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              final veterinarianName = appointment['aptWithName'];
              final appointmentDay = appointment['aptDay'];
              final appointmentTime = appointment['aptTime'];

              return ListTile(
                leading: CircleAvatar(child: Image.asset('assets/images/support.jpg')),
                title: Text(veterinarianName),
                subtitle: Text(appointmentDay +' '+appointmentTime),
              );
            },
          );
        },
      ),
    );
  }
}
