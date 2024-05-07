import 'dart:convert';

import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/controllers/wishlist_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/cart_view.dart';
import 'package:e_commerce_app/views/product_details_view.dart';
import 'package:e_commerce_app/views/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const HomeView({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Zomato',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Consumer<WishlistController>(
              builder: (context, wishlistProvider, _) {
                int wishlistCount = wishlistProvider.wishlist.length;
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WishlistView(
                              onFavoriteToggle: wishlistProvider.toggleFavorite,
                              wishlist: wishlistProvider.wishlist,
                            ),
                          ),
                        );
                      },
                    ),
                    wishlistCount > 0
                        ? Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.red,
                              child: Text(
                                '$wishlistCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
            Consumer<CartController>(
              builder: (context, cartProvider, _) {
                int cartCount = cartProvider.cartItems.length;
                return Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.shopping_cart,
                        size: 30,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartView(),
                          ),
                        );
                      },
                    ),
                    cartCount > 0
                        ? Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              radius: 9,
                              backgroundColor: Colors.red,
                              child: Text(
                                '$cartCount',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ],
                );
              },
            ),
            const SizedBox(
              width: 10,
            )
          ],
        ),
        body: FutureBuilder(
          future: products(context),
          builder: (context, AsyncSnapshot<List<ProductModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<ProductModel>? products = snapshot.data;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: products!.length,
                  itemBuilder: (context, index) {
                    ProductModel product = products[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProductDetailsView(product: product),
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 200,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  '${product.image}',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${product.name}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${product.price}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Provider.of<CartController>(context,
                                                  listen: false)
                                              .addToCart(product);
                                        },
                                        icon:
                                            const Icon(Icons.add_shopping_cart),
                                      ),
                                      Consumer<WishlistController>(
                                        builder: (context, controller, _) {
                                          return IconButton(
                                            onPressed: () {
                                              controller
                                                  .toggleFavorite(product);
                                            },
                                            icon: Icon(
                                              product.isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: product.isFavorite
                                                  ? Colors.red
                                                  : null,
                                              size: 23,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<List<ProductModel>> products(BuildContext context) async {
    var jsonString =
        await DefaultAssetBundle.of(context).loadString('assets/data.json');
    List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => ProductModel.fromJson(json)).toList();
  }
}
