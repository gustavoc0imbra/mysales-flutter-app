import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mysalesflutterapp/models/Product.dart';
import 'package:http/http.dart' as httpCli;

class ProductService {
  final String url = "http://localhost:8080/api/v0/products";

  Future<Map<String, dynamic>> saveProduct(Product product) async {
    final Response response = await httpCli.post(
      Uri.parse(this.url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    if (response.statusCode != HttpStatus.created) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(data);
    Product result = Product.fromJson(json);

    return {"success": true, "product": result};
  }

  Future<Map<String, dynamic>> updateProduct(int id, Product product) async {
    print('🔄 Atualizando produto com id: $id');
    print('📦 Dados enviados: ${jsonEncode(product.toJson())}');

    final Response response = await httpCli.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product.toJson()),
    );

    print('📤 Status da resposta: ${response.statusCode}');
    print('📥 Corpo da resposta: ${response.body}');

    if (response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(data);
    Product updatedProduct = Product.fromJson(json);

    return {"success": true, "product": updatedProduct};
  }

  Future<Map<String, dynamic>> getProducts() async {
    final Response response = await httpCli.get(
      Uri.parse(this.url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String jsonString = utf8.decode(response.bodyBytes);
    List<dynamic> jsonList = jsonDecode(jsonString);

    // Converte JSON para lista de objetos Product
    List<Product> products =
        jsonList.map((item) => Product.fromJson(item)).toList();

    return {"success": true, "data": products};
  }

  Future<Map<String, dynamic>> deleteProduct(int id) async {
    final Response response = await httpCli.delete(
      Uri.parse("${this.url}/$id"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != HttpStatus.noContent) {
      return {"success": false, "body": response.body};
    }

    return {"success": true, "data": "Produto deletado com sucesso!"};
  }
}
