import 'package:catalog_app/models/products.dart';
import 'package:catalog_app/services/product_details_service.dart';
import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailScreen> {
  late Future<Product> productFuture;
  var isLoaded = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Fetch product data from the API using the provided id.
    getData();
  }

  getData() async {
    try {
      var data = await ProductDetailService().getProduct(1);
      setState(() {
        productFuture = data as Future<Product>; // Store the single product
        isLoaded = true;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoaded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Details')),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: 1, // Only one product to display
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: NetworkImage(
                          (productFuture as Product).images[0],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    (productFuture as Product).title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    (productFuture as Product).description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price: \$${(productFuture as Product).price}',
                    style: const TextStyle(fontSize: 18, color: Colors.green),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
