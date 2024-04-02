import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/appointment/viewAppointments.dart';
import 'package:petify/profile/profile_page.dart';

TextEditingController name=TextEditingController();
TextEditingController day=TextEditingController();
TextEditingController time=TextEditingController();
TextEditingController phone=TextEditingController();
TextEditingController message=TextEditingController();
var isLoading=false.obs;

class BookAppointment extends StatelessWidget {
  final Map<dynamic, dynamic> vet;
  const BookAppointment({super.key, required this.vet});

  bookAppointment(BuildContext context)async{
    isLoading(true);
    var appointment=FirebaseFirestore.instance.collection('appointments').doc();
    await appointment.set({
      'aptBy':FirebaseAuth.instance.currentUser?.uid,
      'aptDay':day.text,
      'aptTime':time.text,
      'aptName':name.text,
      'aptContact':phone.text,
      'aptMessage':message.text,
      'aptWith':vet['id'],
      'aptWithName':vet['name'],

    }
    );
    isLoading(false);
    showDialog(
        context:  context ,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Appointment is booked successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.back(); // Assuming GetX navigation is used
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final String vetId;
    final String vetName;
    return Scaffold(
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
                  context, MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: Image.asset('assets/images/profile.webp'),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text('${vet?['name']}',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text('${vet?['timings']}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300),),
              SizedBox(height: 10,),
              Text('Education: ${vet?['education']}',style: TextStyle(fontSize: 15,),),
              Text('Experience: ${vet?['experience']}',style: TextStyle(fontSize: 15,),),
              SizedBox(height: 10,),
              Text('Address: ${vet?['address']}',style: TextStyle(fontSize: 15,),),
              Divider(),
              Align(alignment:Alignment.center,child: Text('Book Appointment',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20),)),
              Divider(),
              TextFormField(
                controller:name,
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                  )
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller:day,
                readOnly: true, // Disable manual text input for clarity
                decoration: InputDecoration(
                  labelText: 'Select appointment day',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () async {
                      // Show date picker
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(Duration(days: 30)), // Allow booking up to 30 days in advance
                        lastDate: DateTime.now().add(Duration(days: 30)), // Allow booking up to 30 days later
                      );
                      if (selectedDate != null) {
                        // Format the date for storage
                        final formatter = DateFormat('y MMM d'); // Customize date format as needed
                        day.text = formatter.format(selectedDate);
                      }
                    },
                  ),
                ),
              ),
          GestureDetector(
            onTap: () async {
              // Show time picker
              final selectedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (selectedTime != null) {
                // Format the time for storage (consider 12-hour or 24-hour format)
                final formattedTime = selectedTime.format(context); // Uses MaterialApp's locale
                time.text = formattedTime;
              }
            },
            child: TextFormField(
              controller: time,
              readOnly: true, // Disable manual text input for clarity
              decoration: InputDecoration(
                labelText: 'Select appointment time',
                suffixIcon: IconButton(
                  icon: Icon(Icons.watch_later_outlined),
                  onPressed: () async {
                    // Show time picker
                    final selectedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (selectedTime != null) {
                      // Format the time for storage (consider 12-hour or 24-hour format)
                      final formattedTime = selectedTime.format(context); // Uses MaterialApp's locale
                      time.text = formattedTime;
                    }
                  },
                ),
              ),
            ),
          ),
              SizedBox(height: 10,),
              TextFormField(
                controller:phone,
                decoration: InputDecoration(
                  labelText: "Phone No",
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your phone number';
                  }
                  if (value?.length != 10) {
                    return 'Phone number must be 10 digits';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),

              TextFormField(
                  controller:message,
                  decoration: InputDecoration(
                    labelText: 'Message...',
                  )
              ),
              SizedBox(height: 10,),

              Align(
                alignment: Alignment.center,

                child: ElevatedButton(onPressed: (){
                  bookAppointment( context);
                }, child:Text('Book appointment',style: TextStyle(color: Colors.black),),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.amber,side: BorderSide.none,shape: StadiumBorder()),
                ),
              ),






            ],
          ),
        ),
      ),

    );
  }
}
