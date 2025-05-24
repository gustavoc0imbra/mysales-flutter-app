import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mysalesflutterapp/models/Customer.dart';
import 'package:http/http.dart' as httpCli;

class CustomerService {
  final String url = "http://localhost:8080/api/v0/customers";

  Future<Map<String, dynamic>> saveCustomer(Customer customer) async {
    final Response response = await httpCli.post(
      Uri.parse(this.url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );

    if (response.statusCode != HttpStatus.created) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    Map<String, dynamic> json = jsonDecode(data);

    Customer result = Customer.fromJson(json);

    return {"success": true, "customer": result};
  }

  Future<Map<String, dynamic>> updateCustomer(int id, Customer customer) async {
    print('🔄 Atualizando cliente com id: $id');
    print('📦 Dados enviados: ${jsonEncode(customer.toJson())}');

    final Response response = await httpCli.put(
      Uri.parse("$url/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(customer.toJson()),
    );

    print('📤 Status da resposta: ${response.statusCode}');
    print('📥 Corpo da resposta: ${response.body}');

    if (response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);
    Map<String, dynamic> json = jsonDecode(data);
    Customer updatedCustomer = Customer.fromJson(json);

    return {"success": true, "customer": updatedCustomer};
  }

  Future<Map<String, dynamic>> getCustomers() async {
    final Response response = await httpCli.get(
      Uri.parse(this.url),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String json = utf8.decode(response.bodyBytes);
    List<dynamic> data = jsonDecode(json);

    return {"success": true, "data": data};
  }

  Future<Map<String, dynamic>> deleteCustomer(int id) async {
    final Response response = await httpCli.delete(
      Uri.parse("${this.url}/${id}"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != HttpStatus.noContent) {
      return {"success": false, "body": response.body};
    }

    return {"success": true, "data": "Registro deletado com sucesso!"};
  }
}
