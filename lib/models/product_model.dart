// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);


class ProductModel {
  String? name;
  String? description;
  String? price;
  String? image;

  ProductModel({
    this.name,
    this.description,
    this.price,
    this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "price": price,
        "image": image,
      };
}