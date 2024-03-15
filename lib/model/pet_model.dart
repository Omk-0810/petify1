class Pet {
  final String name;
  final String species; // Optional, if applicable
  final String breed;
  final String gender;
  final int age;
  final String imageUrl;
  final String userId; // Optional, if needed for user-specific actions

  Pet({
    required this.name,
    this.species = '', // Set default empty string for species
    required this.breed,
    required this.gender,
    required this.age,
    required this.imageUrl,
    this.userId = '', // Set default empty string for userId
  });

  factory Pet.fromMap(Map<String, dynamic> data) => Pet(
    name: data['petName'] as String,
    species: data['petSpecies'] ?? '', // Handle potential missing species
    breed: data['petBreed'] as String,
    gender: data['gender'] as String,
    age: data['age'] as int,
    imageUrl: data['imageUrl'] as String,
    userId: data['userId'] ?? '', // Handle potential missing userId
  );

  @override
  String toString() {
    return 'Pet(name: $name, species: $species, breed: $breed, gender: $gender, age: $age, imageUrl: $imageUrl, userId: $userId)';
  }
}// class Pet{
//   String name;
//   String species;
//   String breed;
//   String imageUrl;
//   int age;
//   String gender;
//   // PetOwner petOwner;
//
//   factory Pet.fromMap(Map<String, dynamic> data) => Pet(
//     name: data['name'] as String,
//     species: data['species'] as String,
//     breed: data['breed'] as String,
//     imageUrl: data['imageUrl'] as String,
//     age: data['age'] as int,
//     gender: data['gender'] as String,
//     // petOwner: PetOwner(
//     //   name: data['petOwner']['name'] as String,
//     // ),
//   );
//
// // Add a separate function to handle adding data to lists
//   void addToCatList(Pet pet) {
//     if (pet.species.toLowerCase() == 'cat') { // Check if species is "cat" (case-insensitive)
//       cats.add(pet);
//     }
//   }
//
//   Pet({
//      required this.name,
//     required this.species,
//     required this.breed,
//      required this.imageUrl,
//      required this.age,
//      required this.gender,
//      // required this.petOwner,
//
//   });
// }
// // class PetOwner{
// //   String name;
// //   // String imageUrl;
// //   // DateTime dateTime;
// //
// //   PetOwner({
// //     required this.name,
// //     // required this.imageUrl,
// //     // required this.dateTime,
// //   });
// //
// // }
// List<Pet>cats=[
//   Pet(
//     name:"oreo",
//     imageUrl:"assets/images/CatAdopt/oreo.jpg",
//     breed:"Maine Coon",
//     species: '',
//     age:4,
//     gender:"Male",
//     // petOwner:PetOwner(
//     // name:"Ashish patel",
//     //
//     // )
//   ),
//   Pet(
//       name:"charlie",
//     species: '',
//
//     imageUrl:"assets/images/CatAdopt/charlie.jpg",
//       breed:"Maine Coon",
//       age:4,
//       gender:"Male",
//       // petOwner:PetOwner(
//       //   name:"sunil jadhav",
//       //
//       // ),
//   ),Pet(
//       name:"oreo",
//       species: '',
//
//       imageUrl:"assets/images/CatAdopt/oreo.jpg",
//       breed:"Maine Coon",
//       age:4,
//       gender:"Male",
//       // petOwner:PetOwner(
//       //   name:"Ashish patel",
//       //
//       // )
//   ),
//
// ];
//
// List<Pet>dogs=[
//   Pet(
//       name:"simba",
//       imageUrl:"assets/images/DogAdopt/simba.png",
//
//       breed:"German Shephard",
//       age:3,
//       species: '',
//
//       gender:"Male",
//       // petOwner:PetOwner(
//       //   name:"sanjay patil",
//       //
//       // )
//   ),
//   Pet(
//       name:"simba",
//       imageUrl:"assets/images/DogAdopt/simba.png",
//       species: '',
//
//       breed:"German Shephard",
//       age:3,
//       gender:"Male",
//       // petOwner:PetOwner(
//       //   name:"sanjay patil",
//       //
//       // )
//   ),
//
//   Pet(
//
//       name:"Moti",
//       species: '',
//       imageUrl:'assets/images/DogAdopt/moti.png',
//       breed:"Indian Bear hound",
//       age:4,
//       gender:"Male",
//       // petOwner:PetOwner(
//       //   name:"Ravi jadhav",
//       //
//       // )
//   ),
//   Pet(
//       name:"Moti",
//       species: '',
//       imageUrl:'assets/images/DogAdopt/moti.png',
//       breed:"Indian Bear hound",
//       age:4,
//       gender:"Male",
//       // petOwner:PetOwner(
//       //   name:"Ravi jadhav",
//       //
//       // )
//   )
// ];