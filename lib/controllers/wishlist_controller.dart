import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class WishListController extends ChangeNotifier {
  final List<ProductModel> _wishlistItems = [];

  List<ProductModel> get wishlistItems => _wishlistItems;

  

  void addToWishlist(ProductModel product) {
    _wishlistItems.add(product);
    notifyListeners();
  }

  void removeFromWishlist(ProductModel product) {
    _wishlistItems.remove(product);
    notifyListeners();
  }
}
