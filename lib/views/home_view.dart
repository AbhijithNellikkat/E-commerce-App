import 'dart:convert';

import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/views/cart_view.dart';
import 'package:e_commerce_app/views/product_details_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
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
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartView(),
                  ),
                );
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
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
                            Container(
                              height:
                                  200, // Set a fixed height for the image container
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
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
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '${product.price}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  SizedBox(height: 8),
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
                                        icon: Icon(Icons.add_shopping_cart),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Add to wishlist functionality
                                        },
                                        icon: Icon(Icons.favorite_border),
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
