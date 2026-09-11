import 'package:catalog_app/models/products.dart';
import 'package:http/http.dart' as http;

class ProductDetailService {
  Future<Product> getProduct(int id) async {
    var client = http.Client();
    var uri = Uri.parse('https://dummyjson.com/products/$id');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json).products[0];
    } else {
      throw Exception('Failed to load product');
    }
  }
}
