import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ReceivedRequestDetails extends StatefulWidget {
  const ReceivedRequestDetails({Key? key, required this.requestData}) : super(key: key);
  final Map<String, dynamic> requestData;

  @override
  State<ReceivedRequestDetails> createState() => _ReceivedRequestDetailsState();
}

class _ReceivedRequestDetailsState extends State<ReceivedRequestDetails> {
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: EdgeInsets.all(20),
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

                    return Container(
                      height: 230,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(15)),
                      child: Column(
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
                            SizedBox(height: 10,),

                            if (widget.requestData['status'] == 'accepted')...{

                              Text('${widget.requestData['status']}'),
                              Text(
                                'Your request has been accepted,you can now contact the pet owner',
                                style: TextStyle(fontStyle: FontStyle.italic),),
                              Text('${widget.requestData['status']}'),
                              SizedBox(height: 10,),
                              ElevatedButton(
                                onPressed: () {
                                  // Show user contact details
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Contact Details'),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .start,
                                          children: [
                                            Text('Email: ${userData['email']}'),
                                            Text('Phone: ${userData['phone']}'),
                                          ],
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('Close',
                                              style: TextStyle(
                                                  color: Colors.black),),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Text('Show Contact Details',
                                  style: TextStyle(color: Colors.black),),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.amber,
                                    side: BorderSide.none,
                                    shape: StadiumBorder()
                                ),
                              ),
                            },
                            if (widget.requestData['status'] != 'pending')...{
                              Text('Your request is still ${widget.requestData['status']}...Please check again later',style: TextStyle(fontStyle: FontStyle.italic),)
                            }



    ]
                      ),
                    );
                  }

                })

          ],
        ),
      ),
    );
  }
}
