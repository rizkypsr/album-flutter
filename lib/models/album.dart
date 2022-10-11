class Album {
  int? id;
  String? grupName;
  String? albumName;
  int? price;
  String? imagePath;

  Album({
    this.id,
    required this.grupName,
    required this.albumName,
    required this.price,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'grup_name': grupName,
      'album_name': albumName,
      'price': price,
      'image_path': imagePath,
    };
  }

  Album.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    grupName = map['grup_name'];
    albumName = map['album_name'];
    price = map['price'];
    imagePath = map['image_path'];
  }
}
