import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as httpCli;
import 'package:mysalesflutterapp/models/Address.dart';

class AddressService {
  final String _url = "http://localhost:8080/api/v0/customers/{customerId}/addresses";
  final String _fetchAddressUrl = "http://localhost:8080/api/v0/address";

  Future<Map<String, dynamic>> searchAddress(String zipCode) async {
    final Response response = await httpCli.get(
      Uri.parse("$_fetchAddressUrl/$zipCode"),
      headers: {'Content-Type': 'application/json; charset=utf8'},
    );

    if(response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    Map<String, dynamic> json = jsonDecode(data);

    Address address = Address.fromSearchJson(json);

    return {"success": true, "address": address};
  }

  Future<Map<String, dynamic>> fetchAddresses(int customerId) async {
    final Response response = await httpCli.get(
      Uri.parse(_url.replaceAll("{customerId}", customerId.toString())),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    List<dynamic> json = jsonDecode(data);

    return {"success": true, "addresses": json};
  }

  Future<Map<String, dynamic>> saveAddress(Address address) async {
    final Response response = await httpCli.post(
      Uri.parse(_url.replaceAll("{customerId}", address.customerId.toString())),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(address.toJson())
    );

    if(response.statusCode != HttpStatus.created) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    Map<String, dynamic> json = jsonDecode(data);

    address = Address.fromJson(json);

    return {"success": true, "address": address};
  }

  Future<Map<String, dynamic>> deleteAddress(int id, int customerId) async {
    final Response response = await httpCli.delete(
      Uri.parse("${_url.replaceAll("{customerId}", customerId.toString())}/${id.toString()}"),
      headers: {'Content-Type': 'application/json'},
    );

    if(response.statusCode != HttpStatus.noContent) {
      return {"success": false, "body": response.body};
    }

    return {"success": true, "address": "Endereço excluído com sucesso!"};
  }
}