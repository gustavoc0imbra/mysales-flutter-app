import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/models/Customer.dart';
import 'package:mysalesflutterapp/screens/product_list_screen.dart';
import 'package:mysalesflutterapp/services/CustomerService.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});

  @override
  _CustomerListState createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerListScreen> {
  final CustomerService customerService = CustomerService();
  List<dynamic> customers = List.empty();

  @override
  void initState() {
    super.initState();
    fetchCustomers();
  }

  Future<void> fetchCustomers() async {
    Map<String, dynamic> result = await customerService.getCustomers();

    if (!result['success']) {
      showDialog(
        context: context,
        builder:
            (BuildContext build) => AlertDialog(
              title: const Text("Atenção!"),
              content: Text(
                "Ocorreu um erro ao buscar clientes!\n${result['body']}",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text("Ok"),
                ),
              ],
            ),
      );
      return;
    }

    setState(() {
      customers = result['data'];
    });
  }

  Future<void> deleteCustomer(int id) async {
    Map<String, dynamic> result = await customerService.deleteCustomer(id);

    if (!result['success']) {
      showDialog(
        context: context,
        builder:
            (BuildContext build) => AlertDialog(
              title: const Text("Atenção!"),
              content: Text(
                "Ocorreu um erro ao deletar cliente!\n${result['body']}",
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text("Ok"),
                ),
              ],
            ),
      );
      return;
    }
    fetchCustomers(); // Atualiza a lista após exclusão
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CLIENTES'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          final inicial =
              customer['name'].isNotEmpty
                  ? customer['name'][0].toUpperCase()
                  : '?';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blueAccent,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text(inicial),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(
                    "${customer['name']} - ${customer['id'].toString()}",
                  ),
                  subtitle: Text(customer['email']),
                  textColor: Colors.white,
                  trailing: PopupMenuButton<void>(
                    itemBuilder:
                        (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/save-customer',
                                arguments: customer,
                              );
                            },
                            child: const Text("Editar"),
                          ),
                          PopupMenuItem(
                            onTap:
                                () => Navigator.pushNamed(
                                  context,
                                  '/customer/address',
                                  arguments: customer,
                                ),
                            child: const Text("Endereços"),
                          ),
                          PopupMenuItem(
                            onTap:
                                () => showDialog(
                                  context: context,
                                  builder:
                                      (BuildContext builder) => AlertDialog(
                                        title: const Text("Atenção"),
                                        content: Text(
                                          "Deseja realmente deletar o cliente ${customer['name']}?",
                                        ),
                                        actions: <Widget>[
                                          ElevatedButton(
                                            onPressed: () async {
                                              await deleteCustomer(
                                                customer['id'],
                                              );
                                              Navigator.pop(context);
                                            },
                                            child: const Text("Sim"),
                                          ),
                                          ElevatedButton(
                                            onPressed:
                                                () => Navigator.pop(context),
                                            child: const Text("Não"),
                                          ),
                                        ],
                                      ),
                                ),
                            child: const Text("Excluir"),
                          ),
                        ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/save-customer'),
        tooltip: "Adicionar",
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.group, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/'); // Clientes
                },
                tooltip: "Clientes",
              ),
              IconButton(
                icon: const Icon(Icons.category_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    ProductListScreen.route,
                  ); // Produtos
                },
                tooltip: "Produtos",
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/sales'); // Vendas
                },
                tooltip: "Vendas",
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // ação futura
                },
                tooltip: "Configurações",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
