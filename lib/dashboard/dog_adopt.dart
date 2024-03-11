import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petify/authentication/wrapper.dart';
import 'package:petify/model/pet_model.dart';
import 'package:petify/dashboard/onBoarding.dart';


class DogAdopt extends StatefulWidget {
  const DogAdopt({super.key});

  @override
  State<DogAdopt> createState() => _DogAdoptState();
}

class _DogAdoptState extends State<DogAdopt> {
  final user = FirebaseAuth.instance.currentUser;

  signout() async {
    await FirebaseAuth.instance.signOut();
  }

  // final Pet pet;

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
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
              icon: Image.asset('assets/images/profile.webp'),
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
                      'Dogs',
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
                  itemCount: dogs.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){
                    Pet pet = dogs[index];
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

      child: Row(
        children: [
          Expanded(child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                height:200,
                decoration: BoxDecoration(color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Align(

                  child:Image.asset(pet.imageUrl,height: 180,width: 180,),

                ),


              ),


            ],

          )),
          SizedBox(width: 5),
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
                    crossAxisAlignment: CrossAxisAlignment.start,

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
