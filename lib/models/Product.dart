class Product {
  int? id;
  String name;
  String description;
  double price;
  int stockQuantity;

  // Construtor sem id (para criação)
  Product(this.name, this.description, this.price, this.stockQuantity);

  // Construtor com id (para objetos que já existem no banco)
  Product.withId(
    this.id,
    this.name,
    this.description,
    this.price,
    this.stockQuantity,
  );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'stockQuantity': stockQuantity,
    };
  }

  static Product fromJson(Map<String, dynamic> json) {
    return Product.withId(
      json['id'],
      json['name'],
      json['description'],
      (json['price'] as num).toDouble(),
      json['stockQuantity'],
    );
  }
}
