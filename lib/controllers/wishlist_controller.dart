import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class WishlistController extends ChangeNotifier {
  final List<ProductModel> _wishlist = [];

  List<ProductModel> get wishlist => _wishlist;

  void toggleFavorite(ProductModel product) {
    final index = _wishlist.indexWhere((item) => item.name == product.name);
    if (index != -1) {
      _wishlist.removeAt(index);
    } else {
      product.isFavorite = true;
      _wishlist.add(product);
    }
    notifyListeners();
  }
}
