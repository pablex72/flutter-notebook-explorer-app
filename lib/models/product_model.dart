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

  // Method to convert string
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'imageProduct': imageProduct,
    };
  }

  factory ProductModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      // If json is null, return a ProductModel defualt
      return ProductModel(
        id: 'Default ID',
        title: 'Default Title',
        price: '0 USD',
        description: 'Default Description',
        imageProduct:
            'https://img.freepik.com/free-vector/laptop_53876-43921.jpg?t=st=1715981896~exp=1715985496~hmac=bc04d79f30ff1d0172176fcbe8ee8fd38830281b75925d587cd1bf9109233ee1&w=996',
      );
    }

    // Getting the list of attributes of product
    List<dynamic>? attributes = json['attributes'];

    // Getting atribute brand which will be as description
    Map<String, dynamic>? brandAttribute = attributes?.firstWhere(
      (attribute) => attribute['id'] == 'BRAND',
      orElse: () => null,
    );

    String brandName =
        brandAttribute != null ? brandAttribute['value_name'] : 'Brand Name';

    return ProductModel(
      id: json['id'] ?? 'Default ID',
      title: json['title'] ?? 'Title Product',
      price: "${json['price'] ?? 0}",
      description: brandName,
      imageProduct: json['thumbnail'] ??
          'https://img.freepik.com/free-vector/laptop_53876-43921.jpg?t=st=1715981896~exp=1715985496~hmac=bc04d79f30ff1d0172176fcbe8ee8fd38830281b75925d587cd1bf9109233ee1&w=996',
    );
  }
}
