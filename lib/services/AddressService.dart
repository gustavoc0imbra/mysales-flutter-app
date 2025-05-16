import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/http.dart' as httpCli;
import 'package:mysalesflutterapp/models/Address.dart';

class Addressservice {
  final String _url = "http://localhost:8080/api/v0/customer/{customerId}/address";
  final String _fetchAddressUrl = "http://localhost:8080/api/v0/address";

  Future<Map<String, dynamic>> searchAddress(String zipCode) async {
    final Response response = await httpCli.get(
      Uri.parse("${this._fetchAddressUrl}/$zipCode"),
      headers: {'Content-Type': 'application/json; charset=utf8'},
    );

    if(response.statusCode != HttpStatus.ok) {
      return {"success": false, "body": response.body};
    }

    String data = utf8.decode(response.bodyBytes);

    Map<String, dynamic> json = jsonDecode(data);

    Address address = Address.fromJson(json);

    return {"success": true, "address": address};
  }
}