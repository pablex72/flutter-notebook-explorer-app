import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_application_notebooks/models/user_model.dart';
// import 'package:http/http.dart' as http;

class UserRepository {
  String endpoint = 'https://api.mercadolibre.com/sites/MLU/search?q=notebook#json';
  Future<List<UserModel>> getUsers() async {
    Response response = await get(Uri.parse(endpoint));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body)['results'];
      return result.map(((e) => UserModel.fromJson(e))).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}