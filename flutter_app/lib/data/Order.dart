import 'dart:async';

import 'package:flutter_app/utils/database_manager.dart';
import 'product.dart';

class Order {
  int id = 0;
  final int statusId;
  final String statusName;
  final double total;
  List<Product> products = [];

  Order({this.statusId, this.statusName, this.total});

  Order.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        statusId = json["status_id"],
        statusName = json["status_name"],
        total = json["total"],
        products = Product.products(json["products"]);

  @override
  String toString() {
    return "Order {id: $id, statusId: $statusId, statusName: $statusName, total: $total, products: $products}";
  }

  static FutureOr<List<Order>> fetchListOrders() async {
    final results =
        await DatabaseManager.instance.database.rawQuery(DatabaseConstants.sqlFetchListOrders);
    if (results == null) {
      return null;
    }

    Map<String, dynamic> orders = {};
    results.forEach((mapping) {
      final key = mapping["id"].toString();
      Map<String, dynamic> order = orders[key] ??
          {
            "id": mapping["id"],
            "status_id": mapping["status_id"],
            "status_name": mapping["status_name"],
            "total": mapping["total"]
          };
      final product = {
        "product_id": mapping["product_id"],
        "product_name": mapping["product_name"],
        "quantity": mapping["quantity"],
        "price": mapping["price"],
        "category_id": mapping["category_id"]
      };

      List<Map<String, dynamic>> products = order["products"] ?? [];
      products.add(product);
      order["products"] = products;
      orders[key] = order;
    });

    return orders.entries.map((entry) {
      return Order.fromJson(entry.value);
    }).toList();
  }
}
