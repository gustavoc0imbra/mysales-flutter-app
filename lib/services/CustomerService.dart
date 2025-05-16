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
      body: jsonEncode(customer.toJson())
    );

    if(response.statusCode != HttpStatus.created) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    Map<String, dynamic> json = jsonDecode(data);

    print("Antes Erro");

    Customer result = Customer.fromJson(json);

    print("Depois erro");

    return {"success": true, "customer": result};
  }

  Future<Map<String, dynamic>> getCustomers() async {
    final Response response = await httpCli.get(
      Uri.parse(this.url),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String json = utf8.decode(response.bodyBytes);
    List<dynamic> data = jsonDecode(json);

    return {"success": true, "data": data};
  }
}