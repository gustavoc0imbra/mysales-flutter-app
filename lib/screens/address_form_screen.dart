import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mysalesflutterapp/models/Address.dart';
import 'package:mysalesflutterapp/models/Customer.dart';
import 'package:mysalesflutterapp/services/AddressService.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({super.key});

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressFormScreen> {
  final AddressService addressservice = AddressService();
  Customer customer = Customer.withId(0, "", "", "", true);

  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _addressnumberController = TextEditingController();
  final TextEditingController _neighborhoodController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();

  bool validateRequiredFields() {
    return _descriptionController.text.isEmpty || _zipCodeController.text.isEmpty || _addressnumberController.text.isEmpty || _neighborhoodController.text.isEmpty || _cityController.text.isEmpty || _streetController.text.isEmpty;
  }

  void fetchZipCode(String zipCode) async {
    
    if(zipCode.length != 8) {
      return;
    }

    Map<String, dynamic> result = await addressservice.searchAddress(zipCode);
    
    if(!result['success']) {
      showDialog(context: context, builder: (BuildContext builder) => AlertDialog(
        title: const Text("Erro"),
        content: Text("Erro ao buscar CEP: ${result['body']}!"),
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

    _neighborhoodController.text = result['address'].neighborhood;
    _cityController.text = result['address'].city;
    _streetController.text = result['address'].street;

  }

  void saveAddress() async {

    if(customer.id == null) {
      return;
    }

    if(validateRequiredFields()) {
      return;
    }

    Address address = Address(
      null,
      customer.id,
      _descriptionController.text,
      _zipCodeController.text,
      int.parse(_addressnumberController.text),
      _streetController.text,
      _neighborhoodController.text,
      _cityController.text
    );

    Map<String, dynamic> result = await addressservice.saveAddress(address);

    if (!result['success']) {
      showDialog(context: context, builder: (BuildContext build) => AlertDialog(
        title: const Text("Atenção!"),
        content: Text("Ocorreu um erro ao salvar o endereço!\n${result['body']}"),
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

    showDialog(context: context, builder: (BuildContext build) => AlertDialog(
      title: const Text("Sucesso!"),
      content: Text("O endereço de ${customer.name} foi adicionado com sucesso!\nAo clicar em OK você será redirecionado para pagína de endereços do cliente."),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Ok'),
            Navigator.pushNamed(context, '/customer/address', arguments: this.customer.toJson())
          },
          child: const Text("Ok")
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    Customer customer = Customer.fromJson(ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>);

    setState(() {
      this.customer = customer;
    });

    return Scaffold(
      appBar: AppBar(title: const Text('SALVAR ENDEREÇO'), centerTitle: true, backgroundColor: Colors.blue,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                maxLength: 50,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _zipCodeController,
                      decoration: const InputDecoration(labelText: 'CEP'),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 8,
                      onChanged: (value) => fetchZipCode(value),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _addressnumberController,
                      decoration: const InputDecoration(labelText: 'Número'),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      maxLength: 4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _neighborhoodController,
                decoration: const InputDecoration(labelText: 'Bairro'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'Cidade'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _streetController,
                decoration: const InputDecoration(labelText: 'Rua'),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  FilledButton(
                    onPressed: () => saveAddress(),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Salvar'),
                  ),
                  const SizedBox(height: 10),
                  FilledButton(
                    onPressed: () {
                      // ação de cancelar
                      Navigator.pop(context);
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        )
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
