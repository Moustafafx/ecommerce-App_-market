class productmodel{
  final int ?id;
  final String nameproduct;
  final String imageproduct;
  final double ?price;
  final double ?rating;
  productmodel({required this.nameproduct, required this.imageproduct, required this.rating, this.price, this.id});




factory productmodel.fromjson(Map<String,dynamic>json){
return productmodel(nameproduct:json["title"] , imageproduct:json["images"][0], rating:json["rating"].toDouble(),price:json["price"].toDouble(),id: json["id"] );
}

}


