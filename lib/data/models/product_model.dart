class ProductModel {
  final String title, image;
  final num price;
  int quantity = 1;

  ProductModel({
    required this.title,
    required this.price,
    required this.image,
  });

  factory ProductModel.fromJson({required Map<String, dynamic> json}) {
    return ProductModel(
      title: json['title'],
      price: json['price'],
      image: json['image']
    );
  }
}