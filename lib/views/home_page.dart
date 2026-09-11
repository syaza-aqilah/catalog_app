import 'package:catalog_app/models/products.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Product>? products;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
  }

  getData() async {
    // products = await ProductListService().getProducts();
    // if (products != null) {
    //   setState(() {
    //     isLoaded = true;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }
}
