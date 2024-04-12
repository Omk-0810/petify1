import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';




class RequestDetails extends StatefulWidget {
  const RequestDetails({Key? key, required this.requestData}) : super(key: key);
  final Map<String, dynamic> requestData;

  @override
  State<RequestDetails> createState() => _RequestDetailsState();

}

class _RequestDetailsState extends State<RequestDetails> {

  @override
  Widget build(BuildContext context) {
    bool _isAccepted = false;

    final requesterId = widget.requestData['requesterId'];
    final receiverId = widget.requestData['receiverId']; // Assuming key is 'receiverId'

    final petId = widget.requestData['petId'];
    DatabaseReference requestRef;

    final firebaseApp = Firebase.app();
    final userRef = FirebaseDatabase.instanceFor(app:firebaseApp,databaseURL: 'https://petify-794fd-default-rtdb.asia-southeast1.firebasedatabase.app/' ).ref().child('/users/$requesterId');

    return Scaffold(

      appBar: AppBar(
    title: Text('Request Details'),
    ),
      body: Container(
        height: 230,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(20),


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<DatabaseEvent>(future:  userRef.once(),
                  builder: (context,snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final userData = snapshot.data!.snapshot.value as Map<Object?, Object?>;
                      final requesterName = userData["name"] ?? 'Unknown Requester';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                          'Requester: $requesterName',
                          style: TextStyle(fontSize: 16.0),
                        ),
                          SizedBox(height: 10,),
                          Text(
                            'Address: ${userData["address"]}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 15,),

                          if (widget.requestData['status'] == 'pending')
                            Row(
                             children: [
                                ElevatedButton(
                                    onPressed: ()async {
                                   bool confirmAction = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("Confirm Acceptance"),
                                        content: Text("If you accept ,the requester will get your contact information...Do you want to continue  ?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(false); // Return false on cancel
                                            },
                                            child: Text("Cancel"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop(true); // Return true on confirm
                                            },
                                            child: Text("Accept"),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                  if (confirmAction == true)
                                  {
                                  final querySnapshot= await FirebaseFirestore.instance
                                    .collection('requests').where('requesterId',isEqualTo: receiverId).where('petId',isEqualTo: petId).get();
                                 if (querySnapshot.docs.isNotEmpty) {
                                 // Loop through the documents and update each one
                                 for (final docSnapshot in querySnapshot.docs) {
                                   await docSnapshot.reference.update({'status': 'accepted'});
                                 }
                                 setState(() {
                                   _isAccepted = true;
                                 });
                                 } else {
                                 print('No matching request found');
                                }
                                 }
                               }, child: Text('Accept',style: TextStyle(color: Colors.black),),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.amber,
                                      side: BorderSide.none,
                                      shape: StadiumBorder()
                                  ),                                ),
                               SizedBox(width: 25,),
                               ElevatedButton(
                                   onPressed: ()async {
                                     bool confirmAction = await showDialog(
                                       context: context,
                                       builder: (BuildContext context) {
                                         return AlertDialog(
                                           title: Text("Confirm rejection"),
                                           content: Text("Are you sure you want to reject this request?"),
                                           actions: [
                                             TextButton(
                                               onPressed: () {
                                                 Navigator.of(context).pop(false); // Return false on cancel
                                               },
                                               child: Text("Cancel"),
                                             ),
                                             TextButton(
                                               onPressed: () {
                                                 Navigator.of(context).pop(true); // Return true on confirm
                                               },
                                               child: Text("Reject"),
                                             ),
                                           ],
                                         );
                                       },
                                     );
                                     if (confirmAction == true)
                                     {
                                       final querySnapshot= await FirebaseFirestore.instance
                                           .collection('requests').where('requesterId',isEqualTo: receiverId).where('petId',isEqualTo: petId).get();
                                       if (querySnapshot.docs.isNotEmpty) {
                                         // Loop through the documents and update each one
                                         for (final docSnapshot in querySnapshot.docs) {
                                           await docSnapshot.reference.update({'status': 'rejected'});
                                         }
                                         setState(() {
                                           _isAccepted = true;
                                         });
                                       } else {
                                         print('No matching request found');
                                       }
                                     }
                                   }, child: Text('Reject',style: TextStyle(color: Colors.black)),
                                 style: ElevatedButton.styleFrom(
                                     backgroundColor: Colors.amber,
                                     side: BorderSide.none,
                                     shape: StadiumBorder()
                                 ),
                               ),


                            ],
                          ),
                          if (widget.requestData['status'] != 'pending') // Show current status if not pending
                      // Show current status if not pending
                            Text(
                              'Status: ${widget.requestData['status']}',
                                style: TextStyle(fontSize: 16.0),
                                 ),


                        ]
                      );
                    }

                  })

            ],
          ),
        ),

    );

  }
}
