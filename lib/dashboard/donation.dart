import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/dashboard/onBoarding.dart';

class PetInformationForm extends StatefulWidget {
  @override
  _PetInformationFormState createState() => _PetInformationFormState();
}

class _PetInformationFormState extends State<PetInformationForm> {
  String _petName = '';
  String _petBreed = '';
  String _gender = '';
  int _age = 0;
  File? _image;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _getImage() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed:()=> Get.back(),

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
                Get.snackbar("Profile Clicked!", "");
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Pet Name'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter pet name';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _petName = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Pet Breed'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter pet breed';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _petBreed = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Gender'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter gender';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _gender = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Age'),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter age';
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    _age = int.tryParse(value) ?? 0;
                  });
                },
                keyboardType: TextInputType.number,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                height: 50,
                width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: Colors.white70),
                child: Row(

                  children:
                  [
                    Text('Upload the image of the pet',style: TextStyle(fontSize: 15),),
                    Spacer(),
                    IconButton(
                      onPressed: _getImage,

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
              :SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // You can process the form data here, for example, send it to an API
                    print('Pet Name: $_petName');
                    print('Pet Breed: $_petBreed');
                    print('Gender: $_gender');
                    print('Age: $_age');
                    print('Image Path: ${_image?.path}');
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PetInformationForm(),
  ));
}
