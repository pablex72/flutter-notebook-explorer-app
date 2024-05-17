import 'dart:ffi';

class UserModel {
  final String id;
  final String title;
  final String price;
  final String description;
  final String imageProduct;
  UserModel(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.imageProduct});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Obtener la lista de atributos del producto
    List<dynamic> attributes = json['attributes'];

    // Buscar el atributo 'BRAND' dentro de la lista de atributos
    Map<String, dynamic>? brandAttribute = attributes.firstWhere(
      (attribute) => attribute['id'] == 'BRAND',
      orElse: () => null,
    );

    // Obtener el valor de 'value_name' del atributo 'BRAND' si existe
    String brandName =
        brandAttribute != null ? brandAttribute['value_name'] : 'Brand Name';

    //for filter --> brandName
    return UserModel(
      id: json['id'],
      title: json['title'] ?? 'Title Product',
      price: "${json['price']} USD",
      description: brandName,
      imageProduct: json['thumbnail'] ??
          'https://img.freepik.com/free-vector/illustration-user-avatar-icon_53876-5907.jpg?w=740',
    );
  }
}
