import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditAppointmentTime extends StatefulWidget {
  final String aptBy;
  const EditAppointmentTime({super.key,required this.aptBy});

  @override
  State<EditAppointmentTime> createState() => _EditAppointmentTimeState();
}

class _EditAppointmentTimeState extends State<EditAppointmentTime> {
  final timeController = TextEditingController();
  final day = TextEditingController();

  final isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Appointment Time'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              controller: timeController,
              readOnly: true, // Disable manual text input for clarity
              decoration: InputDecoration(
                labelText: 'Select the new appointment time',
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
                      timeController.text = formattedTime;
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            TextFormField(
              controller:day,
              readOnly: true, // Disable manual text input for clarity
              decoration: InputDecoration(
                labelText: 'Select the new appointment day',
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

            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async {
                  final String vetId = FirebaseAuth.instance.currentUser?.uid ?? "";
                  final String userId=widget.aptBy;
                  final querySnapshot =await FirebaseFirestore.instance
                      .collection('appointments')
                      .where('aptBy',isEqualTo: userId)
                      .where('aptWith',isEqualTo:vetId)
                      .get();

                  if (querySnapshot.docs.isNotEmpty) {
                    final appointmentToUpdate = querySnapshot.docs.first;

                    // Update appointment time
                    await FirebaseFirestore.instance
                        .collection('appointments')
                        .doc(appointmentToUpdate.id)
                        .update({
                      'aptTime': timeController.text,
                    'aptDay':day.text
                        });

                    isLoading(false);
                    Navigator.pop(context); // Close this screen
                  } else {
                    // Handle case where no matching appointment is found (show error message?)
                  } // Close this screen
                },
                child: Text('Save Changes', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber, side: BorderSide.none, shape: StadiumBorder()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
