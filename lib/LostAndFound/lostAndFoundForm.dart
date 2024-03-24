import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petify/profile/profile_page.dart';

class LostAndFoundForm extends StatefulWidget {
  @override
  _LostAndFoundFormState createState() => _LostAndFoundFormState();
}

class _LostAndFoundFormState extends State<LostAndFoundForm> {
  String? currentUserId;

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('pets');

  final _firestore = FirebaseFirestore.instance;
  String _desc = '';
  String _casee = '';
  String _species = '';
  String _petBreed = '';
  String _address = '';
  File? _image;
  String imageUrl = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? pickedFile;

  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser?.uid;
  }

  // Future<void> _getImage()
  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MaterialApp(
      home: LostAndFoundForm(),
    ));
  }

  // Future<String?> uploadImage(XFile? pickedFile) async {
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
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
              icon: Image.asset('assets/images/profile.webp'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Lost',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            leading: Radio<String>(
                              value: 'Lost',
                              groupValue: _casee,
                              onChanged: (String? value) {
                                setState(() {
                                  _casee = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              'Found',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            leading: Radio<String>(
                              value: 'Found',
                              groupValue: _casee,
                              onChanged: (String? value) {
                                setState(() {
                                  _casee = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ]),
                  Divider(),
                  Opacity(
                    opacity: 0.5,
                    child: Text(
                      "Please select the species of the animal you found :",
                      style: TextStyle(
                          fontSize: 17.0), // Adjust text style as needed
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: ListTile(
                            title:
                                Opacity(opacity: 0.8, child: const Text('Dog')),
                            leading: Radio<String>(
                              value: 'Dog',
                              groupValue: _species,
                              onChanged: (String? value) {
                                setState(() {
                                  _species = value!;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title:
                                Opacity(opacity: 0.8, child: const Text('Cat')),
                            leading: Radio<String>(
                              value: 'Cat',
                              groupValue: _species,
                              onChanged: (String? value) {
                                setState(() {
                                  _species = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ])
                ],
              ),
              Container(
                height: 1, // Adjust height as needed
                color: Colors.black45, // Adjust color for boldness
                margin: EdgeInsets.symmetric(
                    horizontal: 10.0), // Adjust margins as needed
              ),

              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Animal Breed',
                    prefixIcon: Icon(Icons.category_rounded)),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter animal breed';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _petBreed = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Address where found at lost at',
                    prefixIcon: Icon(Icons.place)),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter address';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _address = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Description ',
                    prefixIcon: Icon(Icons.description)),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _desc = value;
                  });
                },
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                height: 50,
                width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white70),
                child: Row(
                  children: [
                    Text('Upload the image of the pet',
                        style: TextStyle(fontSize: 15)),
                    Spacer(),
                    IconButton(
                      onPressed: () async {
                        XFile? pickedFile = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        print('${pickedFile?.path}');

                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload = referenceDirImages.child(
                            'pet_images/${DateTime.now().millisecondsSinceEpoch}');

                        try {
                          await referenceImageToUpload
                              .putFile(File(pickedFile!.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } on FirebaseException catch (e) {
                          // Handle image upload errors
                          print(e);
                          Get.snackbar(
                            "Error",
                            "Failed to upload image: ${e.message}",
                          );
                          return null;
                        }
                        Get.snackbar('Success', 'Image uploaded successfully');
                      },
                      icon: Image.asset('assets/images/upload.png'),
                    ),
                  ],
                ),
              ),
              // ElevatedButton(
              //   onPressed: _getImage,
              //   child: Text('Select Image'),
              // ),
              _image != null
                  ? Image.file(
                      _image!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    )
                  : SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  print(imageUrl);
                  if (imageUrl.isEmpty) {
                    Get.snackbar('Error', 'please upload an image');
                    return;
                  }
                  try {
                    // Add data to Firebase Firestore
                    await FirebaseFirestore.instance
                        .collection('LostAndFound')
                        .add({
                      'casee':_casee,
                      'userId': currentUserId,
                      'species': _species,
                      'petBreed': _petBreed,
                      'imageUrl': imageUrl,
                      'address': _address,
                      'desc': _desc,
                    });

                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Text('Details submitted successfully!!!'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Get.back();
                                  },
                                  child: Text('OK'))
                            ],
                          );
                        }); // Navigate to next screen
                  } catch (e) {
                    // Handle errors
                    print(e);
                    // Display error message to the user
                  }
                },
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    side: BorderSide.none,
                    shape: StadiumBorder()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//
// void main() {
//   runApp(MaterialApp(
//     home: PetInformationForm(),
//   ));
// }
