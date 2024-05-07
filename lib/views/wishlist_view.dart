import 'package:e_commerce_app/controllers/wishlist_controller.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishListView extends StatelessWidget {
  const WishListView({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductModel> wishlistItems =
        Provider.of<WishListController>(context).wishlistItems;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: const Text(
            'WishList',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
          itemCount: wishlistItems.length,
          itemBuilder: (context, index) {
            ProductModel product = wishlistItems[index];

            return ListTile(
              title: Text(
                '${product.name}',
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Price: \$${product.price}',
                style: const TextStyle(color: Colors.white),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline_outlined,
                  color: Colors.red,
                ),
                onPressed: () {
                  Provider.of<WishListController>(context, listen: false)
                      .removeFromWishlist(product);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
