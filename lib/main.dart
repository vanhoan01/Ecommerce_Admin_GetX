import 'package:ecommerce_admin_getx/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
//https://console.firebase.google.com/u/0/project/ecommerce-bloc-app-cd95a/overview

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My eCommerce Backend',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      getPages: [
        GetPage(name: '/products', page: () => ProductsScreen()),
        GetPage(name: '/products/new', page: () => NewProductScreen()),
        GetPage(name: '/orders', page: () => OrdersScreen())
      ],
    );
  }
}