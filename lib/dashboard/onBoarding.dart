import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/authentication/wrapper.dart';
import 'package:petify/dashboard/navBar.dart';
import 'package:petify/model/pet_model.dart';
import 'package:petify/dashboard/dog_adopt.dart';
import 'package:petify/dashboard/cat_adopt.dart';
import 'package:petify/dashboard/donation.dart';
import 'package:petify/profile/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final _firestore = FirebaseFirestore.instance;
  List<Pet> pets = [];
  String _selectedSpecies = 'All'; 


  @override
  void initState() {
    super.initState();
    _fetchPets();
    // Call data fetching function on initialization
  }


  Future<void> _fetchPets() async {
    // Stream to listen for changes in the pets collection
    Stream<QuerySnapshot<Map<String, dynamic>>> petsStream =
    _firestore.collection('pets').snapshots();

    // Listen to the stream and update the pets list
    petsStream.listen((snapshot) {
      pets = snapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList();
      print(pets);
      setState(() {}); // Update UI when pets list changes
    });
  }


  signout() async {
    await FirebaseAuth.instance.signOut();
  }
  void _navigateToSpeciesPage(String selectedSpecies) {
    if (selectedSpecies == 'Dog') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DogAdopt()),
      );
    } else if (selectedSpecies == 'Cat') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CatAdopt()),
      );
    }
    else if (selectedSpecies == 'All') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }
  }

  // final Pet pet;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    Widget imageIcon = Image.asset('assets/images/profile.webp');
    return Scaffold(
      drawer: NavBar(),
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
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
              icon: imageIcon,
            ),
          )
        ],
      ),
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(left: BorderSide(width: 4))),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  ),
                  Text('Filter')
                ],
              ),
              Divider(),
              //categorie
              Container(
                height: 50,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: DropdownButton<String>(
                  hint: Text('Filter by Species' ,style: TextStyle(color: Colors.white),),
                  value: _selectedSpecies,
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 25,
                  elevation: 50,
                  style: const TextStyle(color: Colors.white,),
                  underline: Container(
                    margin: EdgeInsets.only(left: 50),
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSpecies = newValue!;
                      // Handle navigation based on selection
                      _navigateToSpeciesPage(newValue);
                    });
                  },
                  items: <String>['All', 'Dog', 'Cat']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      // Set the child as Text with the value
                    );
                  }).toList(),
                  dropdownColor:Colors.black,
                ),
              ),

              Stack(children: [
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: pets.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    Pet pet = pets[index];
                    return buildPetContainer(pet);





                  },
                )


              ]
              ),

            ],
          ),
        ),
      ),

    );
  }
  Widget buildPetContainer(Pet pet) {
    return Container(
      // height: 240,

      margin:EdgeInsets.symmetric(horizontal: 20),

      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height:200,
                    decoration: BoxDecoration(color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20)
                        )
                    ),
                    child: Align(
                      child:Image.network(pet.imageUrl,height: 180,width: 180,fit: BoxFit.cover,),
                    ),

                  ),


                ],

              )),
              Expanded(child: Stack(
                children: [
                  Container(
                      height:200,
                      width: 150,
                      margin: EdgeInsets.only(top:40,bottom: 20),
                      decoration: BoxDecoration(color: Colors.white,

                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [
                          SizedBox(height: 30),
                          Text(
                            pet.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "${pet.age} months old",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            pet.breed,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                  ),
                ],
              )),
            ],
          ),
          Divider()
        ],
      ),
    );}
}
