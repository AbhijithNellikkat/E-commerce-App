import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  double getTotalAmount() {
    double totalAmount = _cartItems.fold(
      0,
      (previousValue, product) =>
          previousValue + double.parse(product.price!.substring(1)),
    );
    return totalAmount;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
