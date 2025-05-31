import 'package:flutter/material.dart';
import 'screens/customer_form_screen.dart';
import 'screens/address_form_screen.dart';
import 'screens/address_list_screen.dart';
import 'screens/customer_list_screen.dart';
import 'screens/product_list_screen.dart';
import 'screens/product_form_screen.dart'; // <-- IMPORTANTE

void main() => runApp(const MySales());

class MySales extends StatelessWidget {
  const MySales({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Vendas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const CustomerListScreen(),
        AddressListScreen.route: (context) => const AddressListScreen(),
        AddressFormScreen.route: (context) => const AddressFormScreen(),
        '/save-customer': (context) => const CustomerFormScreen(),
        ProductListScreen.route:
            (context) => const ProductListScreen(), // <-- NOVO
        ProductFormScreen.route:
            (context) => const ProductFormScreen(), // <-- NOVO
      },
    );
  }
}
