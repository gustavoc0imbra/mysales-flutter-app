import 'package:flutter/material.dart';

class AddressFormScreen extends StatelessWidget {
  const AddressFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _cepController = TextEditingController();
    final TextEditingController _addressnumberController = TextEditingController();
    final TextEditingController _cityController = TextEditingController();
    final TextEditingController _streetController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Salvar Endereço'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrição'),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _cepController,
                      decoration: const InputDecoration(labelText: 'CEP'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _addressnumberController,
                      decoration: const InputDecoration(labelText: 'Número'),
                    ),
                  ),
                ],
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
                  ElevatedButton(
                    onPressed: () {
                      // ação de salvar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Salvar'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // ação de cancelar
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
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
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.groups),
                onPressed: () {
                  // ação para tela de grupo
                },
              ),
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  // ação para tela de pessoa
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // ação para configurações
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
