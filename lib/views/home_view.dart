import 'dart:convert';

import 'package:e_commerce_app/models/product_model.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Home"),
        ),
        body: FutureBuilder(
          future: products(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error : ${snapshot.error}'),
              );
            } else {
              List<ProductModel>? products = snapshot.data;
              return ListView.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  ProductModel product = products[index];

                  return ListTile(
                    leading: Image.network('${product.image}'),
                    title: Text('${product.name}'),
                  );
                },
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
