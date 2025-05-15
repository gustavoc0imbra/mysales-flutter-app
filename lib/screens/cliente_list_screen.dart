import 'package:flutter/material.dart';

class ClienteListScreen extends StatelessWidget {
  const ClienteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista fictícia de clientes
    final List<Map<String, String>> clientes = [
      {'nome': 'Matheus Maximiano', 'email': 'matheus@email.com'},
      {'nome': 'Gustavo Silva', 'email': 'gustavo@email.com'},
      {'nome': 'Eduarda Gusmao', 'email': 'eduarda@email.com'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Clientes'), centerTitle: true),
      body: ListView.builder(
        itemCount: clientes.length,
        itemBuilder: (context, index) {
          final cliente = clientes[index];
          final nome = cliente['nome']!;
          final email = cliente['email']!;
          final inicial = nome.isNotEmpty ? nome[0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text(inicial)),
              title: Text(nome),
              subtitle: Text(email),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  // ação de deletar
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () {
                  // ação de editar
                },
              ),
              IconButton(
                icon: const Icon(Icons.add, color: Colors.blue),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.grey),
                onPressed: () {
                  // ação futura
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
