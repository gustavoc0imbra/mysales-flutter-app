import 'package:flutter/material.dart';
import 'screens/customer_form_screen.dart';
import 'screens/address_form_screen.dart';
import 'screens/address_list_screen.dart';
import 'screens/customer_list_screen.dart';

void main() => runApp(const MySales());

class MySales extends StatelessWidget {
  const MySales({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Vendas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)
      ),
      initialRoute: '/', // Tela inicial agora é Novo Cliente
      routes: {
        '/': (context) => const CustomerListScreen(),
        AddressListScreen.route: (context) => const AddressListScreen(),
        AddressFormScreen.route: (context) => const AddressFormScreen(),
        '/save-customer': (context) => const CustomerFormScreen(),
      },
    );
  }
}
