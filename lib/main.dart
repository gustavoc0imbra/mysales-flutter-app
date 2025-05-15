import 'package:flutter/material.dart';
import 'screens/cliente_form_screen.dart';
import 'screens/endereco_form_screen.dart';
import 'screens/cliente_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Vendas',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Tela inicial agora é Novo Cliente
      routes: {
        '/': (context) => const ClienteFormScreen(),
        '/endereco': (context) => const EnderecoFormScreen(),
        '/lista-clientes': (context) => const ClienteListScreen(),
      },
    );
  }
}
