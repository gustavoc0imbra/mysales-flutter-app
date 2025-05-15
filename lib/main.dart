import 'package:flutter/material.dart';
import 'screens/cliente_form_screen.dart';
import 'screens/endereco_form_screen.dart';
import 'screens/cliente_list_screen.dart';

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
        '/': (context) => const ClienteFormScreen(),
        '/endereco': (context) => const EnderecoFormScreen(),
        '/lista-clientes': (context) => const ClienteListScreen(),
      },
    );
  }
}
