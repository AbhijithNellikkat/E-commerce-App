import 'package:e_commerce_app/controllers/wishlist_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class WishlistView extends StatelessWidget {
  final List<ProductModel> wishlist;
  final Function(ProductModel) onFavoriteToggle;

  const WishlistView(
      {super.key, required this.wishlist, required this.onFavoriteToggle});

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
          'Wishlist',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<WishlistController>(
        builder: (context, value, child) {
          if (wishlist.isEmpty) {
            return Center(
              child: Lottie.asset('assets/animation/emptycart.json'),
            );
          }
          return ListView.builder(
            itemCount: wishlist.length,
            itemBuilder: (context, index) {
              final product = wishlist[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  tileColor: const Color.fromARGB(102, 33, 33, 33),
                  leading: Image.network('${product.image}'),
                  title: Text('${product.name}',
                      style: const TextStyle(color: Colors.white)),
                  subtitle: Text('${product.description}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w300)),
                  trailing: IconButton(
                    icon: Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isFavorite ? Colors.red : Colors.white,
                    ),
                    onPressed: () => onFavoriteToggle(product),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
