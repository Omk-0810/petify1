import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DeleteProfile extends StatefulWidget {
  @override
  _DeleteVetProfileScreenState createState() => _DeleteVetProfileScreenState();
}

class _DeleteVetProfileScreenState extends State<DeleteProfile> {
  final user = FirebaseAuth.instance.currentUser;
  final DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  Future<void> deleteVetProfile() async {
    try {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please sign in to delete your profile!')),
        );
        return;
      }

      final  userId = user?.uid;

      // Delete veterinarian data from the 'veterinarian' section
      await databaseReference.child('veterinarian/$userId').remove();

      // Update the user's role back to 'user' in the 'users' section
      await databaseReference.child('users/$userId').update({'role': 'user'});

      // Show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Profile deleted successfully!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Go back to the previous screen
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error deleting profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Vet Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: deleteVetProfile,
          child: Text('Delete Profile'),
        ),
      ),
    );
  }
}
