import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/models/Cliente.dart';
import 'package:mysalesflutterapp/services/ClienteService.dart';

class ClienteFormScreen extends StatefulWidget {
  @override
  _ClienteFormState createState() => _ClienteFormState();

  const ClienteFormScreen({super.key});
}

class _ClienteFormState extends State<ClienteFormScreen> {

  final ClienteService clienteService = ClienteService();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _sobrenomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool verificaCampos() {
    return _nomeController.text.isEmpty || _sobrenomeController.text.isEmpty || _emailController.text.isEmpty;
  }

  void salvarCliente() async {

    if(verificaCampos()) {
      showDialog(context: context, builder: (BuildContext build) => AlertDialog(
        title: const Text("Atenção!"),
        content: Text("Favor preencher todos os campos!"),
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

    Cliente cliente = Cliente(_nomeController.text, _sobrenomeController.text, _emailController.text);

    Map<String, dynamic> resultado = await clienteService.salvarCliente(cliente);

    if (!resultado['success']) {
      showDialog(context: context, builder: (BuildContext build) => AlertDialog(
        title: const Text("Atenção!"),
        content: Text("Ocorreu um erro ao salvar o cliente!\n${resultado['body']}"),
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
      content: Text("O cliente ${resultado['cliente'].name} foi adicionado com sucesso!\nAo clicar em OK você será redirecionado para pagína de clientes."),
      actions: <Widget>[
        TextButton(
          onPressed: () => {
            Navigator.pop(context, 'Ok'),
            Navigator.pushNamed(context, '/lista-clientes')
          },
          child: const Text("Ok")
        )
      ],
    ));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Cliente'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nomeController,
                          decoration: const InputDecoration(labelText: 'Nome'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          controller: _sobrenomeController,
                          decoration: const InputDecoration(labelText: 'Sobrenome'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email')
                  ),
                ],
              )
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: salvarCliente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Salvar'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/endereco');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Endereços'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/lista-clientes');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Clientes'),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Cancelar'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Icon(Icons.group),
              SizedBox(width: 20),
              Icon(Icons.person),
              SizedBox(width: 20),
              Icon(Icons.settings),
            ],
          ),
        ),
      ),
    );
  }
}
