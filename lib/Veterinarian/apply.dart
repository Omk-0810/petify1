import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:petify/Veterinarian/vetInfo.dart';


class ApplyVet extends StatefulWidget {

  ApplyVet({super.key});

  @override
  State<ApplyVet> createState() => _ApplyVetState();
}
final firebaseApp = Firebase.app();
DatabaseReference databaseReference  =
FirebaseDatabase.instanceFor(app:firebaseApp,databaseURL: 'https://petify-794fd-default-rtdb.asia-southeast1.firebasedatabase.app/' ).ref();


class _ApplyVetState extends State<ApplyVet> {

  TextEditingController email=TextEditingController();
  TextEditingController name=TextEditingController();
  TextEditingController education=TextEditingController();
  TextEditingController experience=TextEditingController();
  TextEditingController timings=TextEditingController();
  TextEditingController phone=TextEditingController();
  TextEditingController address=TextEditingController();

  TimeOfDay? startTime;
  TimeOfDay? endTime;

  final user = FirebaseAuth.instance.currentUser;

  // Function to handle time picker for start time
  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != startTime) {
      setState(() {
        startTime = pickedTime;
      });
    }
  }

  // Function to handle time picker for end time
  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != endTime) {
      setState(() {
        endTime = pickedTime;
      });
    }
  }

  // Function to format time based on TimeOfDay object
  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final String hours = (time.hour % 12).toString().padLeft(2, '0');
    final String minutes = time.minute.toString().padLeft(2, '0');
    final String period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hours:$minutes $period';
  }

  Future<void> applyVet(BuildContext context) async {
    try {
      final User? user = await FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Handle the case where user is not logged in
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please sign in to apply!')),
        );
        return;
      }

      final String userId = user.uid;
      final String formattedStartTime = _formatTime(startTime);
      final String formattedEndTime = _formatTime(endTime);
      final Map<String, dynamic> userDataMap = {

        "email": email.text,
        "name": name.text,
        "education": education.text,
        "experience": experience.text,
        "timings": '$formattedStartTime - $formattedEndTime', // Concatenate formatted times
        "phone": phone.text,
        "address": address.text,
        "id": userId,
      };

      await databaseReference.child('veterinarian/$userId').set(userDataMap);
      await databaseReference.child('users/$userId').update({'role': 'veterinarian'}); // Update role


      showDialog(
          context: context ,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('Details submitted successfully!'),
              actions: [
                TextButton(
                  onPressed: () {

                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VetInfo()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context as BuildContext).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    }
  }

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
          "Apply as veterinarian",
          style: GoogleFonts.siemreap().copyWith(fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white70),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(controller:email,decoration: InputDecoration(label: Text("E-mail "),prefixIcon: (Icon(LineAwesomeIcons.inbox))),
              ),
              SizedBox(height: 20,),
              TextFormField(controller:name,decoration: InputDecoration(label: Text("Full Name"),prefixIcon: (Icon(LineAwesomeIcons.user))),
              ),
              SizedBox(height: 20,),
              TextFormField(controller:education,decoration: InputDecoration(label: Text("Education "),prefixIcon: (Icon(LineAwesomeIcons.school))),
              ),
              TextFormField(controller:experience,decoration: InputDecoration(label: Text("Experience :"),prefixIcon: (Icon(LineAwesomeIcons.hospital))),
              ),
              TextFormField(
                controller: timings,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Timings",
                  prefixIcon: Icon(LineAwesomeIcons.business_time),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.access_time),
                    onPressed: () => _selectStartTime(context),
                  ),
                ),
              ),
              Text(
                startTime != null ? 'to' : '',
                style: TextStyle(color: Colors.black),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _selectStartTime(context),
                    child: Text(
                      startTime != null ? _formatTime(startTime) : 'Start Time',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _selectEndTime(context),
                    child: Text(
                      endTime != null ? _formatTime(endTime) : 'End Time',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20,),
              TextFormField(
                controller:phone,
                decoration: InputDecoration(
                  labelText: "Phone No",
                  prefixIcon: Icon(LineAwesomeIcons.phone),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
              SizedBox(height: 20,),
              TextFormField(controller:address,decoration: InputDecoration(label: Text("Address"),prefixIcon: (Icon(LineAwesomeIcons.user))),
              ),
              SizedBox(height: 30,),
              ElevatedButton(onPressed: (()=>applyVet(context)),
                  style:ElevatedButton.styleFrom(backgroundColor:Colors.amber ,side: BorderSide.none,shape: StadiumBorder(),),
                  child: Text('Apply',style: TextStyle(color: Colors.black),))



            ],
          ),
        ),
      ),
    );
  }
}

