class DairyModel {
  final int id;
  final String name;
  final double price;
  final String companyName;
  final String image;

  DairyModel({
    required this.id,
    required this.name,
    required this.price,
    required this.companyName,
    required this.image,
  });

  factory DairyModel.fromJson(Map<String, dynamic> json) {
    return DairyModel(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      companyName: json['companyName'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'companyName': companyName,
      'image': image,
    };
  }
}
