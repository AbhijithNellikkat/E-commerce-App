import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class CartController extends ChangeNotifier {
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    if (_cartItems.any((item) => item.name == product.name)) {
      ProductModel existingProduct =
          _cartItems.firstWhere((item) => item.name == product.name);
      existingProduct.quantity++;
    } else {
      product.quantity = 1;
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void incrementQuantity(ProductModel product) {
    product.quantity++;
    notifyListeners();
  }

  void decrementQuantity(ProductModel product) {
    if (product.quantity > 1) {
      product.quantity--;
      notifyListeners();
    }
  }

  double getTotalAmount() {
    double totalAmount = _cartItems.fold(
      0,
      (previousValue, product) =>
          previousValue +
          (double.parse(product.price!.substring(1)) * product.quantity),
    );
    return totalAmount;
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
