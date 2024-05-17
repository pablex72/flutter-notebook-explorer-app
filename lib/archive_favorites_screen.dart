import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_notebooks/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ArchiveScreen extends StatefulWidget {
  const ArchiveScreen({Key? key}) : super(key: key);

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List<ProductModel?> savedProducts = [];

  @override
  void initState() {
    super.initState();
    _getSavedProducts();
  }

  void _getSavedProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? productJsonList = prefs.getStringList('selected_products');
    if (productJsonList != null) {
      setState(() {
        savedProducts.clear();
        for (int i = productJsonList.length - 1;
            i >= 0 && savedProducts.length < 5;
            i--) {
          ProductModel product =
              ProductModel.fromJson(json.decode(productJsonList[i]));
          savedProducts.add(product);
          // print('image added: ${product}');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products Visited'),
      ),
      body: ListView.builder(
        itemCount: savedProducts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: InkWell(
              child: Card(
                elevation: 4,
                color: const Color.fromARGB(255, 129, 213, 170),
                child: ListTile(
                  title: Text(
                    savedProducts[index]!.title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Total Price: ${savedProducts[index]!.price} USD",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
