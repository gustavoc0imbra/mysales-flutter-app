import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/models/Customer.dart';
import 'package:mysalesflutterapp/screens/product_list_screen.dart';
import 'package:mysalesflutterapp/services/CustomerService.dart';

class CustomerFormScreen extends StatefulWidget {
  @override
  _CustomerFormState createState() => _CustomerFormState();

  const CustomerFormScreen({super.key});
}

class _CustomerFormState extends State<CustomerFormScreen> {
  final CustomerService customerService = CustomerService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  var editingCustomer = null;

  @override
  void initState() {
    super.initState();
  }

  bool verifyFields() {
    return _nameController.text.isEmpty ||
        _lastnameController.text.isEmpty ||
        _emailController.text.isEmpty;
  }

  void saveCustomer() async {
    if (verifyFields()) {
      showDialog(
        context: context,
        builder:
            (BuildContext build) => AlertDialog(
              title: const Text("Atenção!"),
              content: const Text("Favor preencher todos os campos!"),
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

    Customer customer = Customer(
      editingCustomer?.id,
      _nameController.text,
      _lastnameController.text,
      _emailController.text,
    );

    Map<String, dynamic> result;

    // Verifica se está editando
    if (customer.id != null) {
      result = await customerService.updateCustomer(
        editingCustomer!.id!,
        customer,
      );
    } else {
      result = await customerService.saveCustomer(customer);
    }

    if (!result['success']) {
      showDialog(
        context: context,
        builder:
            (BuildContext build) => AlertDialog(
              title: const Text("Atenção!"),
              content: Text(
                "Ocorreu um erro ao ${editingCustomer != null ? 'atualizar' : 'salvar'} o cliente!\n${result['body']}",
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

    showDialog(
      context: context,
      builder:
          (BuildContext build) => AlertDialog(
            title: const Text("Sucesso!"),
            content: Text(
              "O cliente ${result['customer'].name} foi ${editingCustomer != null ? 'atualizado' : 'adicionado'} com sucesso!\nAo clicar em OK você será redirecionado para a página de clientes.",
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Ok');
                  Navigator.pushNamed(context, '/');
                },
                child: const Text("Ok"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /* Checagem se a rota da página possui os parâmetros */
    Map<String, dynamic> params =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    if (params.isNotEmpty) {
      setState(() {
        editingCustomer = Customer.withId(
          params['id'],
          params['name'],
          params['lastName'],
          params['email'],
          params['active'],
        );
      });

      _nameController.text = editingCustomer.name;
      _lastnameController.text = editingCustomer.lastName;
      _emailController.text = editingCustomer.email;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          editingCustomer != null ? 'EDITAR CLIENTE' : 'NOVO CLIENTE',
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _lastnameController,
                          decoration: const InputDecoration(
                            labelText: 'Sobrenome',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: saveCustomer,
                child: const Text('Salvar'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Cancelar'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/endereco');
                },
                child: const Text('Endereços'),
              ),
            ),
          ],
        ),
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
                  Navigator.pushNamed(context, ProductListScreen.route);
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
