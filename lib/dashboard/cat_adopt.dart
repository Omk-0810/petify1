import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/model/pet_model.dart';
import 'package:petify/dashboard/onBoarding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CatAdopt extends StatefulWidget {
  const CatAdopt({super.key});

  @override
  State<CatAdopt> createState() => _CatAdoptState();
}

class _CatAdoptState extends State<CatAdopt> {
  final _firestore = FirebaseFirestore.instance;
  final user = FirebaseAuth.instance.currentUser;
  List<Pet> pets = [];

  @override
  void initState() {
    super.initState();
    _getCats(); // Call data fetching function on initialization
  }

  Future<void> _getCats() async {
    Stream<QuerySnapshot<Map<String, dynamic>>> petsStream =
    _firestore.collection('pets').where('species'.toLowerCase(),isEqualTo:'Cat').snapshots();

    // Listen to the stream and update the pets list
    petsStream.listen((snapshot) {
      pets = snapshot.docs.map((doc) => Pet.fromMap(doc.data())).toList();
      setState(() {});
      // Update UI when pets list changes
    });
  }


  signout() async {
    await FirebaseAuth.instance.signOut();
  }


  @override
  Widget build(BuildContext context) {
    Widget imageIcon = Image.asset('assets/images/profile.webp');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed:(){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomeScreen()),
            );
          } ,
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
                Get.snackbar("Profie Clicked!", "");
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



              //categories


              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: const BoxDecoration(
                    border: Border(left: BorderSide(width: 4))),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Cats',
                      style: TextStyle(
                          fontSize: 14, color: Colors.black.withOpacity(0.6)),
                    ),
                  ],
                ),
              ),

          Stack(children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: pets.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                Pet pet = pets[index];
                return buildPetContainer(pet);
                // if (index < dogs.length) {
                //  Pet pet = dogs[index];
                //  return buildPetContainer(pet);
                // } else {
                //   int catIndex = index - dogs.length;
                //   Pet pet = cats[catIndex];
                //   return buildPetContainer(pet);
                // }




              },
            )


          ]


          ),
          ],
        ),
      ),


    )

    );
  }
  Widget buildPetContainer(Pet pet) {
    return Container(
      // height: 240,

      margin:EdgeInsets.symmetric(horizontal: 20),

      child: Row(
        children: [
          Expanded(child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height:200,
                decoration: BoxDecoration(color: Colors.transparent,
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
                        "${pet.age} years old",
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
          ))
        ],
      ),

    );}
}
