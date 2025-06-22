class VegetablesCatModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String companyName;

  VegetablesCatModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.companyName,
  });

  factory VegetablesCatModel.fromJson(Map<String, dynamic> json) {
    return VegetablesCatModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      companyName: json['companyName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'companyName': companyName,
    };
  }
}
