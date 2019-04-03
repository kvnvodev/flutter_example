class Product {
  int id;
  final String name;
  int quantity;
  final double price;
  final int categoryId;

  Product({this.id, this.name, this.quantity, this.price, this.categoryId});

  Product.fromJson(Map<String, dynamic> json)
      : id = json["product_id"],
        name = json["product_name"],
        quantity = json["quantity"],
        price = json["price"],
        categoryId = json["category_id"];

  static List<Product> products(List<Map<String, dynamic>> list) {
    return list.map((json) {
      return Product.fromJson(json);
    }).toList();
  }

  @override
  String toString() {
    return "Product {id: $id, name: $name, quantity: $quantity, price: $price, categoryId: $categoryId}";
  }
}
