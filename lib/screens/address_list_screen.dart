import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/models/Address.dart';
import 'package:mysalesflutterapp/services/AddressService.dart';

import '../models/Customer.dart';

class AddressListScreen extends StatefulWidget {
  const AddressListScreen({super.key});

  @override
  _AddressListScreenState createState() => _AddressListScreenState();
}

class _AddressListScreenState extends State<AddressListScreen> {
  final AddressService addressService = AddressService();
  Customer customer = Customer.withId(0, "", "", "", true);
  List<dynamic> addresses = List.empty();

  @override
  void initState() {
    super.initState();
    /* fetchAddresses(); */
  }

  void fetchAddresses() async {
    Map<String, dynamic> result = await addressService.fetchAddresses(customer.id as int);

    if(!result['success']) {
      showDialog(context: context, builder: (BuildContext build) => AlertDialog(
        title: const Text("Atenção!"),
        content: Text("Ocorreu um erro ao carregar endereços do cliente!\n${result['body']}"),
        actions: <Widget>[
          TextButton(
            onPressed: () => {
              Navigator.pop(context, 'Ok'),
            },
            child: const Text("Ok")
          )
        ],
      ));
    }

    setState(() {
      addresses = result['addresses'];
    });
    
  }

  @override
  Widget build(BuildContext context) {
    Customer customer = Customer.fromJson(ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);

    setState(() {
      this.customer = customer;
    });

    return Scaffold(
      appBar: AppBar(title: Text("Endereços de ${this.customer.name}"), backgroundColor: Colors.blue),
      body: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          final address = addresses[index];
          
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.blueAccent,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const CircleAvatar(backgroundColor: Colors.white, child: const Icon(Icons.map)),
                  title: Text("${address['description']} - ${address['id']}"),
                  subtitle: Text("${address['street']} - ${address['zipCode']}"),
                  textColor: Colors.white,
                  trailing: PopupMenuButton<void>(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: () => Navigator.pushNamed(context, '/customer/address', arguments: customer),
                        child: const Text("Editar")
                      ),
                      PopupMenuItem(
                        /* onTap: () => {
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
                        }, */
                        child: const Text("Excluir"),
                      ),
                    ]
                  ),
                ),
              ],
              
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          fetchAddresses()
        },
        tooltip: "Buscar",
        child: const Icon(Icons.search)
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