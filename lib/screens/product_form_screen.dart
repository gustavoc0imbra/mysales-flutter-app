import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/models/Product.dart';
import 'package:mysalesflutterapp/services/ProductService.dart';

class ProductFormScreen extends StatefulWidget {
  const ProductFormScreen({super.key});

  static final String route = '/save-product';

  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductFormScreen> {
  final ProductService productService = ProductService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockQuantityController =
      TextEditingController();

  var editingProduct = null;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is Product) {
        setState(() {
          editingProduct = args;
          _nameController.text = editingProduct!.name;
          _descriptionController.text = editingProduct!.description;
          _priceController.text = editingProduct!.price.toString();
          _stockQuantityController.text =
              editingProduct!.stockQuantity.toString();
        });
      }
    });
  }

  bool verifyFields() {
    return _nameController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _stockQuantityController.text.isEmpty;
  }

  void saveProduct() async {
    if (verifyFields()) {
      showDialog(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
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

    double? price = double.tryParse(_priceController.text);
    int? stockQuantity = int.tryParse(_stockQuantityController.text);

    if (price == null || stockQuantity == null) {
      showDialog(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
              title: const Text("Atenção!"),
              content: const Text(
                "Preço e Quantidade em estoque devem ser números válidos.",
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

    Product product = Product(
      _nameController.text,
      _descriptionController.text,
      price,
      stockQuantity,
    );

    if (editingProduct != null) {
      product.id = editingProduct!.id;
    }

    Map<String, dynamic> result;

    if (editingProduct != null) {
      result = await productService.updateProduct(editingProduct!.id!, product);
    } else {
      result = await productService.saveProduct(product);
    }

    if (!result['success']) {
      showDialog(
        context: context,
        builder:
            (BuildContext context) => AlertDialog(
              title: const Text("Atenção!"),
              content: Text(
                "Ocorreu um erro ao ${editingProduct != null ? 'atualizar' : 'salvar'} o produto!\n${result['body']}",
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
          (BuildContext context) => AlertDialog(
            title: const Text("Sucesso!"),
            content: Text(
              "O produto ${result['product'].name} foi ${editingProduct != null ? 'atualizado' : 'adicionado'} com sucesso!\nAo clicar em OK você será redirecionado para a página de produtos.",
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context, 'Ok');
                  Navigator.pushNamed(context, '/products');
                },
                child: const Text("Ok"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(editingProduct != null ? 'EDITAR PRODUTO' : 'NOVO PRODUTO'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Nome'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(labelText: 'Descrição'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(labelText: 'Preço'),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _stockQuantityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Quantidade em estoque',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: saveProduct,
                  child: const Text('Salvar'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: FilledButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text('Cancelar'),
                ),
              ),
            ],
          ),
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
                icon: const Icon(Icons.category_rounded, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/products');
                },
                tooltip: "Produtos",
                isSelected: true,
              ),
              IconButton(
                icon: const Icon(Icons.group, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                tooltip: "Clientes",
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  // Ação futura para vendas
                },
                tooltip: "Vendas",
              ),
              IconButton(
                icon: const Icon(Icons.settings, color: Colors.white),
                onPressed: () {
                  // Ação futura para configurações
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
