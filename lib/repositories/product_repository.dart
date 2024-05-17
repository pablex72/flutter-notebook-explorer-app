import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter_application_notebooks/models/product_model.dart';

class ProductRepository {
  String endpoint = 'https://api.mercadolibre.com/sites/MLU/search?q=notebook#json';
  Future<List<ProductModel>> getProducts() async {
    Response response = await get(Uri.parse(endpoint));
    if(response.statusCode == 200){
      final List result = jsonDecode(response.body)['results'];
      return result.map(((e) => ProductModel.fromJson(e))).toList();
    }else{
      throw Exception(response.reasonPhrase);
    }
  }
}