class Pet {
  final String name;
  final String species; // Optional, if applicable
  final String breed;
  final String gender;
  final int age;
  final String imageUrl;
  final String userId;
  final String petId;

  Pet( {
    required this.name,
    this.species = '',
    required this.breed,
    required this.gender,
    required this.age,
    required this.imageUrl,
    this.userId = '',
    required this.petId,
  });

  factory Pet.fromMap(Map<String, dynamic> data) => Pet(
    name: data['petName'] as String,
    species: data['petSpecies'] ?? '',
    breed: data['petBreed'] as String,
    gender: data['gender'] as String,
    age: data['age'] as int,
    imageUrl: data['imageUrl'] as String,
    userId: data['userId'] ?? '',
    petId: data['petId'] ?? '',

  );


  @override
  String toString() {
    return 'Pet(name: $name, species: $species, breed: $breed, gender: $gender, age: $age, imageUrl: $imageUrl, userId: $userId,petId:$petId)';
  }
}