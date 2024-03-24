class LostFound {
  final String casee;
  final String species; // Optional, if applicable
  final String breed;
  final String imageUrl;
  final String userId;
  final String desc;
  final String address;


  LostFound({
    required this.casee,
    this.species = '', // Set default empty string for species
    required this.breed,
    required this.imageUrl,
    this.userId = '',
    required this.desc,
    required this.address,

// Set default empty string for userId
  });

  factory LostFound.fromMap(Map<String, dynamic> data) => LostFound(
    species: data['petSpecies'] ?? '',
    breed: data['petBreed'] as String,
    casee: data['casee'] ??'',
    imageUrl: data['imageUrl'] as String,
    userId: data['userId'] ?? '',
    desc: data['desc'] as String,
    address: data['address'] as String,

  );

  @override
  String toString() {
    return 'LostFound( casee:$casee,species: $species, breed: $breed,  imageUrl: $imageUrl, userId: $userId,desc:$desc,address:$address)';
  }
}