import 'package:flutter/material.dart';
import 'package:flutter_application_notebooks/models/product_model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.e}) : super(key: key);
  final ProductModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(e.imageProduct),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Center(
                    child: Text(
                        "\n${e.title} \n \n Price: ${e.price} USD  \n Brand: ${e.description}",
                        textAlign: TextAlign.center))
              ],
            ),
          ),
        ));
  }
}
