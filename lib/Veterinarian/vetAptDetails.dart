import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/Veterinarian/veteDash.dart';
import 'package:petify/profile/profile_page.dart';
import 'package:petify/Veterinarian//edit.dart';



class ViewDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> vet;
  const ViewDetails({super.key,required this.vet});

  @override
  State<ViewDetails> createState() => _ViewDetailsState(vet:vet);

}

class _ViewDetailsState extends State<ViewDetails> {
  final isLoading = false.obs;
  final QueryDocumentSnapshot<Map<String, dynamic>> vet;
  _ViewDetailsState({required this.vet});
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
      body: Container(
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.all(20),
        height: 300,

        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Name: ${vet?['aptName']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
              Text('Contact no: ${vet?['aptContact']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
            SizedBox(height: 10,),
            Text('Appointment time: ${vet?['aptDay']}'+'  ${vet?['aptTime']}',style: TextStyle(fontSize: 15,),),
              SizedBox(height: 10,),
              Text('Description : ${vet?['aptMessage']}',style: TextStyle(fontSize: 15,),),
              SizedBox(height: 15,),
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    Get.to(EditAppointmentTime( aptBy: '${vet?['aptBy']}',));

                  },
                      child: Text('Edit',style: TextStyle(color: Colors.black),),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                      ),
                  SizedBox(width: 20,),
                  ElevatedButton(onPressed: () async {
                    final confirmed =  await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                      title: Text('Confirm Delete'),
                      content: Text('Are you sure you want to delete this appointment?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                    );
                    if (confirmed != null && confirmed) {
                      await deleteAppointment();
                    }
                  },
                      child: Text('Delete',style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                ],
              )

            ]
          ),
        ),
      ),


    );
  }
  Future<void> deleteAppointment() async {
    final String vetId = FirebaseAuth.instance.currentUser?.uid ?? "";
    final String userId= vet?['aptBy'];
    print(vetId);

    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('appointments')
          .where('aptWith', isEqualTo: vetId)
          .where('aptBy', isEqualTo: userId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final appointmentToDelete = querySnapshot.docs.first;
        await appointmentToDelete.reference.delete();
        Get.to(VetDashBoard());
      }

      isLoading(false);
    } catch (error) {
      print("Error deleting appointment: $error");
    }
  }
}
