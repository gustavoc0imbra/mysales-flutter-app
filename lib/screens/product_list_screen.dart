import 'package:flutter/material.dart';
import 'package:mysalesflutterapp/models/Product.dart';
import 'package:mysalesflutterapp/screens/customer_list_screen.dart';
import 'package:mysalesflutterapp/screens/product_form_screen.dart';
import 'package:mysalesflutterapp/services/ProductService.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  static final String route = '/products';

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductListScreen> {
  final ProductService productService = ProductService();
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    Map<String, dynamic> result = await productService.getProducts();

    if (!result['success']) {
      showDialog(
        context: context,
        builder:
            (BuildContext build) => AlertDialog(
              title: const Text("Atenção!"),
              content: Text(
                "Ocorreu um erro ao buscar produtos!\n${result['body']}",
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
      products = result['data'] as List<Product>;
    });
  }

  Future<void> deleteProduct(int id) async {
    Map<String, dynamic> result = await productService.deleteProduct(id);

    if (!result['success']) {
      showDialog(
        context: context,
        builder:
            (BuildContext build) => AlertDialog(
              title: const Text("Atenção!"),
              content: Text(
                "Ocorreu um erro ao deletar produto!\n${result['body']}",
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

    // Atualiza a lista após exclusão
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PRODUTOS'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          final inicial =
              product.name.isNotEmpty ? product.name[0].toUpperCase() : '?';

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.greenAccent,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text(inicial),
                    backgroundColor: Colors.white,
                  ),
                  title: Text("${product.name} - ID: ${product.id ?? ''}"),
                  subtitle: Text(
                    "Preço: R\$${product.price.toStringAsFixed(2)}\nEstoque: ${product.stockQuantity}",
                  ),
                  textColor: Colors.black87,
                  trailing: PopupMenuButton<void>(
                    itemBuilder:
                        (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            onTap: () {
                              Future.delayed(Duration.zero, () {
                                Navigator.pushNamed(
                                  context,
                                  '/save-product',
                                  arguments: product,
                                );
                              });
                            },
                            child: const Text("Editar"),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder:
                                    (BuildContext builder) => AlertDialog(
                                      title: const Text("Atenção"),
                                      content: Text(
                                        "Deseja realmente deletar o produto ${product.name}?",
                                      ),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          onPressed: () async {
                                            await deleteProduct(product.id!);
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
                              );
                            },
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
        onPressed: () => Navigator.pushNamed(context, ProductFormScreen.route),
        tooltip: "Adicionar Produto",
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.group, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, CustomerListScreen.route);
                },
                tooltip: "Clientes",
              ),
              IconButton(
                icon: const Icon(Icons.category_rounded, color: Colors.white),
                onPressed: () {
                  // Já estamos aqui na tela de produtos
                },
                tooltip: "Produtos",
                color: Colors.white,
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                onPressed: () {
                  Navigator.pushNamed(context, '/sales');
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
