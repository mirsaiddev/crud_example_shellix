import 'dart:convert';

import 'package:crud_example_shellix/models/element.dart' as e;
import 'package:crud_example_shellix/models/response/http_response.dart';
import 'package:crud_example_shellix/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<e.Element>> getAllElements() async {
    String url = 'https://crudcrud.com/api/$apiKey/users';

    http.Response response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      List allElementsMap = jsonDecode(response.body);
      List<e.Element> allElementsList = allElementsMap.map((el) => e.Element.fromJson(el)).toList();
      return allElementsList;
    } else {
      throw Exception(response.body);
    }
  }

  Future<HttpResponse> addNewElement(e.Element element) async {
    String url = 'https://crudcrud.com/api/$apiKey/users';

    http.Response response = await http.post(
      Uri.parse(url),
      body: jsonEncode(element.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 201) {
      return HttpResponse(
        isSuccesfull: true,
        data: element,
        message: 'Başarılı',
      );
    } else {
      debugPrint(response.body);
      return HttpResponse(
        isSuccesfull: false,
        data: response.body,
        message: 'Başarısız',
      );
    }
  }

  Future<HttpResponse> deleteElement(e.Element element) async {
    String url = 'https://crudcrud.com/api/$apiKey/users/${element.id}';

    http.Response response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      return HttpResponse(
        isSuccesfull: true,
        data: element,
        message: 'Başarılı',
      );
    } else {
      debugPrint(response.body);
      return HttpResponse(
        isSuccesfull: false,
        data: null,
        message: 'Başarısız',
      );
    }
  }

  Future<HttpResponse> updateElement(e.Element element) async {
    String url = 'https://crudcrud.com/api/$apiKey/users/${element.id}';
    late http.Response response;
    try {
      response = await http.put(
        Uri.parse(url),
        body: jsonEncode(element.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
    } catch (e) {
      debugPrint('hata : $e');
    }

    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      return HttpResponse(
        isSuccesfull: true,
        data: element,
        message: 'Başarılı',
      );
    } else {
      debugPrint(response.body);
      return HttpResponse(
        isSuccesfull: false,
        data: response.body,
        message: 'Başarısız',
      );
    }
  }
}
