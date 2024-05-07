class ProductModel {
  String? name;
  String? description;
  String? price;
  String? image;
  int quantity;
  bool isFavorite;
  ProductModel(
      {this.name,
      this.description,
      this.price,
      this.image,
      this.quantity = 1,
      this.isFavorite = false});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      description: json["description"],
      price: json["price"],
      image: json["image"],
      quantity: 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "image": image,
      "quantity": quantity,
    };
  }
}
