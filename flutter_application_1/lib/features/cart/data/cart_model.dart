class CartProduct {
  final int id;
  final String title;
  final double price;
  final String imageCover;
  final double rating;
  int quantity;

  CartProduct({
    required this.id,
    required this.title,
    required this.price,
    required this.imageCover,
    required this.rating,
    this.quantity = 1,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
      print('KEYS: ${json.keys.toList()}');
    return CartProduct(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      imageCover: json['thumbnail'] ?? '',
      rating: (json['rating'] as num).toDouble(),
    );
  }
}