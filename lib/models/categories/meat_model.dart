class MeatModel {
  final int id;
  final String name;
  final double price;
  final String companyName;
  final String image;

  MeatModel({
    required this.id,
    required this.name,
    required this.price,
    required this.companyName,
    required this.image,
  });

  factory MeatModel.fromJson(Map<String, dynamic> json) {
    return MeatModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      companyName: json['companyName'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'companyName': companyName,
        'image': image,
      };
}
