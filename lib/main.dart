import 'package:e_commerce_app/controllers/cart_controller.dart';
import 'package:e_commerce_app/controllers/wishlist_controller.dart';
import 'package:e_commerce_app/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartController(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishListController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E-commerce App',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          useMaterial3: true,
        ),
        home: const SpalshView(),
      ),
    );
  }
}
