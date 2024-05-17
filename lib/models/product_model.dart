import 'dart:ffi';

class ProductModel {
  final String id;
  final String title;
  final String price;
  final String description;
  final String imageProduct;
  ProductModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.imageProduct});



    // Define el método toMap para convertir ProductModel a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'imageProduct': imageProduct,
    };
  }



  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // Obtener la lista de atributos del producto
    List<dynamic> attributes = json['attributes'];

    // Buscar el atributo 'BRAND' dentro de la lista de atributos
    Map<String, dynamic>? brandAttribute = attributes.firstWhere(
      (attribute) => attribute['id'] == 'BRAND',
      orElse: () => null,
    );

    String brandName =
        brandAttribute != null ? brandAttribute['value_name'] : 'Brand Name';

    //for filter --> brandName
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? 'Title Product',
      price: "${json['price']} USD",
      description: brandName,
      imageProduct: json['thumbnail'] ??
          'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740',
    );
  }
}
