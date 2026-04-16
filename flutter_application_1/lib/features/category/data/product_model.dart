class categorydetailsModel {
  final int ?id;
  final String? title;
  final String ?description;
  final String ?category;
  final double ?price;
  final double ?rating;
  final int ?stock;
  final String? thumbnail;
  final List<String>? images;
  final String ?shippingInformation;
  categorydetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.stock,
    required this.thumbnail,
    required this.images,
    required this.shippingInformation,
  });

  factory categorydetailsModel.fromJson(Map<String, dynamic> json) {
    return categorydetailsModel(
      id: json['id'],
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      stock: json['stock'],
      thumbnail: json['thumbnail'] ?? "",
      images: List<String>.from(json['images']),
      shippingInformation: json['shippingInformation'] ?? "",
    );
  }
}
