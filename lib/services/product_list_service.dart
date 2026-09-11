import 'package:catalog_app/models/products.dart';
import 'package:http/http.dart' as http;

class ProductListService {
  Future<List<Product>> getProducts() async {
    var client = http.Client();
    var uri = Uri.parse('https://dummyjson.com/products?limit=20&skip=0');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      var json = response.body;
      return productsFromJson(json).products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
