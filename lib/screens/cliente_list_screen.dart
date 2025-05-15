import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/services/ClienteService.dart';

class ClienteListScreen extends StatefulWidget {
  const ClienteListScreen({super.key});

  @override
  _ClienteListState createState() => _ClienteListState();
}

class _ClienteListState extends State<ClienteListScreen> {

  final ClienteService customerService = ClienteService();
  List<dynamic> customers = List.empty();

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    Map<String, dynamic> result = await customerService.buscarClientes();

    if(!result['success']) {
      showDialog(context: context, builder: (BuildContext build) => AlertDialog(
        title: const Text("Atenção!"),
        content: Text("Ocorreu um erro ao buscar clientes!\n${result['body']}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'Ok'),
            },
            child: const Text("Ok")
          )
        ],
      ));
      return;
    }

    setState(() {
      customers = result['data'];
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clientes'), centerTitle: true),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          final inicial = customer['name'].isNotEmpty ? customer['name'][0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(child: Text(inicial)),
              title: Text(customer['name']),
              subtitle: Text(customer['email']),
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
