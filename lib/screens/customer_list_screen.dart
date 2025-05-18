import 'package:flutter/material.dart';
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

  Future<void> deleteCustomer(int id) async {
    Map<String, dynamic> result = await customerService.deleteCustomer(id);

    if(!result['success']) {
      showDialog(context: context, builder: (BuildContext build) => AlertDialog(
        title: const Text("Atenção!"),
        content: Text("Ocorreu um erro ao deletar cliente!\n${result['body']}"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CLIENTES'), centerTitle: true, backgroundColor: Colors.blue,),
      body: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final customer = customers[index];
          final inicial = customer['name'].isNotEmpty ? customer['name'][0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blueAccent,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(child: Text(inicial), backgroundColor: Colors.white,),
                  title: Text("${customer['name']} - ${customer['id'].toString()}"),
                  subtitle: Text(customer['email']),
                  textColor: Colors.white,
                  trailing: PopupMenuButton<void>(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () => Navigator.pushNamed(context, '/save-customer'),
                        child: const Text("Editar")
                      ),
                      PopupMenuItem(
                        onTap: () => Navigator.pushNamed(context, '/customer/address', arguments: customer),
                        child: const Text("Endereços")
                      ),
                      PopupMenuItem(
                        onTap: () => {
                          showDialog(context: context, builder: (BuildContext builder) => AlertDialog(
                            title: Text("Atenção"),
                            content: Text("Deseja realmente deletar o cliente ${customer['name']}?"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () async => {
                                  await deleteCustomer(customer['id']),
                                  Navigator.pop(context),
                                  fetchCustomers()
                                },
                                child: const Text("Sim")
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  Navigator.pop(context),
                                },
                                child: const Text("Não")
                              )
                            ],
                          ))
                        },
                        child: const Text("Excluir"),
                      ),
                    ]
                  ),
                ),
                /* Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FilledButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/save-customer'),
                        icon: Icon(Icons.edit),
                        label: const Text("Editar")
                      ),
                      SizedBox(width: 10),
                      FilledButton.icon(
                        onPressed: () => Navigator.pushNamed(context, '/customer/address'),
                        icon: Icon(Icons.home),
                        label: const Text("End.")
                      ),
                      SizedBox(width: 10,),
                      FilledButton.icon(
                        onPressed: () => {
                          showDialog(context: context, builder: (BuildContext builder) => AlertDialog(
                            title: Text("Atenção"),
                            content: Text("Deseja realmente deletar o cliente ${customer['name']}?"),
                            actions: <Widget>[
                              ElevatedButton(
                                onPressed: () async => {
                                  await deleteCustomer(customer['id']),
                                  Navigator.pop(context),
                                  fetchCustomers()
                                },
                                child: const Text("Sim")
                              ),
                              ElevatedButton(
                                onPressed: () => {
                                  Navigator.pop(context),
                                },
                                child: const Text("Não")
                              )
                            ],
                          ))
                        },
                        label: const Text("Deletar")
                      )
                    ],
                  ),
                ) */
                
              ],
              
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.pushNamed(context, '/save-customer')
        },
        tooltip: "Adicionar",
        child: const Icon(Icons.add)
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
                  Navigator.pushNamed(context, '/');
                },
                tooltip: "Clientes",
                isSelected: true,
              ),
              IconButton(
                icon: const Icon(Icons.category_rounded, color: Colors.white),
                onPressed: () {
                  // Ir para tela de produtos
                },
                tooltip: "Produtos",
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  //Ir para tela de vendas
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
