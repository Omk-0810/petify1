import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/profile/profile_page.dart';


class ViewDetails extends StatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> vet;
  const ViewDetails({super.key,required this.vet});

  @override
  State<ViewDetails> createState() => _ViewDetailsState(vet:vet);
}

class _ViewDetailsState extends State<ViewDetails> {
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
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text('Name: ${vet?['aptName']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
            Text('Contact no: ${vet?['aptContact']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
          SizedBox(height: 10,),
          Text('Appointment time: ${vet?['aptDay']}'+'  ${vet?['aptDay']}',style: TextStyle(fontSize: 15,),), SizedBox(height: 10,),
            Text('Description : ${vet?['aptMessage']}',style: TextStyle(fontSize: 15,),),
        ]
        ),
      ),


    );
  }
}
