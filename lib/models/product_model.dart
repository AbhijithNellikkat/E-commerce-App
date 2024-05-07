class ProductModel {
  String? name;
  String? description;
  String? price;
  String? image;
  int quantity; // New field for quantity

  ProductModel({
    this.name,
    this.description,
    this.price,
    this.image,
    this.quantity = 1, // Default quantity is 1
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json["name"],
      description: json["description"],
      price: json["price"],
      image: json["image"],
      quantity: 1, // Default quantity is 1
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "price": price,
      "image": image,
      "quantity": quantity, // Include quantity in the JSON output
    };
  }
}
