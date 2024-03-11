class Pet{
  String name;
  String breed;
  String imageUrl;
  int age;
  String gender;
  PetOwner petOwner;

  Pet({
     required this.name,
     required this.breed,
     required this.imageUrl,
     required this.age,
     required this.gender,
     required this.petOwner,

  });
}
class PetOwner{
  String name;
  // String imageUrl;
  // DateTime dateTime;

  PetOwner({
    required this.name,
    // required this.imageUrl,
    // required this.dateTime,
  });

}
List<Pet>cats=[
  Pet(
    name:"oreo",
    imageUrl:"assets/images/CatAdopt/oreo.jpg",
    breed:"Maine Coon",
    age:4,
    gender:"Male",
    petOwner:PetOwner(
    name:"Ashish patel",

    )
  ),
  Pet(
      name:"charlie",
      imageUrl:"assets/images/CatAdopt/charlie.jpg",
      breed:"Maine Coon",
      age:4,
      gender:"Male",
      petOwner:PetOwner(
        name:"sunil jadhav",

      ),
  ),Pet(
      name:"oreo",
      imageUrl:"assets/images/CatAdopt/oreo.jpg",
      breed:"Maine Coon",
      age:4,
      gender:"Male",
      petOwner:PetOwner(
        name:"Ashish patel",

      )
  ),

];

List<Pet>dogs=[
  Pet(
      name:"simba",
      imageUrl:"assets/images/DogAdopt/simba.png",

      breed:"German Shephard",
      age:3,
      gender:"Male",
      petOwner:PetOwner(
        name:"sanjay patil",

      )
  ),
  Pet(
      name:"simba",
      imageUrl:"assets/images/DogAdopt/simba.png",

      breed:"German Shephard",
      age:3,
      gender:"Male",
      petOwner:PetOwner(
        name:"sanjay patil",

      )
  ),

  Pet(
      name:"Moti",
      imageUrl:'assets/images/DogAdopt/moti.png',
      breed:"Indian Bear hound",
      age:4,
      gender:"Male",
      petOwner:PetOwner(
        name:"Ravi jadhav",

      )
  ),
  Pet(
      name:"Moti",
      imageUrl:'assets/images/DogAdopt/moti.png',
      breed:"Indian Bear hound",
      age:4,
      gender:"Male",
      petOwner:PetOwner(
        name:"Ravi jadhav",

      )
  )
];