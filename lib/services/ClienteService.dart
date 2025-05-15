import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mysalesflutterapp/DTOs/ResponseSalvarClienteDTO.dart';
import 'package:mysalesflutterapp/models/Cliente.dart';
import 'package:http/http.dart' as httpCli;

class ClienteService {
  final String url = "http://localhost:8080/api/v0/customers";

  Future<Map<String, dynamic>> salvarCliente(Cliente cliente) async {
    final Response response = await httpCli.post(
      Uri.parse(this.url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': cliente.nome,
        'lastName': cliente.sobrenome,
        'email': cliente.email
      })
    );

    if(response.statusCode != HttpStatus.created) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    Map<String, dynamic> json = jsonDecode(data);

    ResponseSalvarClienteDTO dto = ResponseSalvarClienteDTO.fromJson(json);

    return {"success": true, "cliente": dto};
  }
}