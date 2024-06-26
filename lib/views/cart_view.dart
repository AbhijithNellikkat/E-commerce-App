import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<CartController>(
        builder: (context, cartController, child) {
          List<ProductModel> cartItems = cartController.cartItems;

          if (cartItems.isEmpty) {
            return Center(
              child: Lottie.asset('assets/animation/emptycart.json'),
            );
          }
          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              ProductModel product = cartItems[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  tileColor: const Color.fromARGB(102, 33, 33, 33),
                  leading: Image.network(
                    '${product.image}',
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    '${product.name}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                  ),
                  subtitle: Text(
                    '${product.price}',
                    style: const TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          cartController.decrementQuantity(product);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${product.quantity}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () {
                          cartController.incrementQuantity(product);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                        icon: const Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartController>(
        builder: (context, cartController, child) {
          double totalAmount = cartController.getTotalAmount();

          return Container(
            color: const Color.fromARGB(102, 33, 33, 33),
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: \$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Implement your checkout logic here
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(170, 35, 35, 35),
                    ),
                  ),
                  child: const Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
