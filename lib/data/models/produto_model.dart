//primeiro criar e inicializar os campos do model

class ProdutoModel{
  final String? title;
  final String? description;
  final double price;
  final double rating;
  final String? brand;
  final String? category;
  final String? thumbnail;
  final String? barcode;
  final List<String?> images;

  ProdutoModel({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.barcode,
    required this.images
  });
  // depois de criar e inicializar os models, crie um mapa para a interpretação do dart

  factory ProdutoModel.fromMap(Map<String?, dynamic> map){
    return ProdutoModel(
        title: map['title'],
        description: map['description'],
        price: map['price'] * 1.0, // multiplicação para se tornar um double
        rating: map['rating'] * 1.0,
        brand: map['brand'],
        category: map['category'],
        thumbnail: map['thumbnail'],
        barcode: map['meta']['barcode'],
        images: List<String?>.from((map['images'] as List)),
    );
  }
}