import 'package:catalog_app/models/products.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  Future<Product> getProduct(int? id) async {
    String baseUrl = 'https://dummyjson.com';
    var client = http.Client();
    var uri = Uri.parse('$baseUrl/products/$id');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json).products[0]; //0 is the index
    } else {
      throw Exception('Failed to load product');
    }
  }
}
