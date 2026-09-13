import 'package:catalog_app/models/products.dart';
import 'package:catalog_app/services/product_list_service.dart';
import 'package:catalog_app/views/product_details_screen.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Product>? products = [];
  var isLoaded = false;
  int skip = 0;
  int limit = 10;
  bool hasMore = true;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    //fetch data from API
    getData();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMore) {
        skip += limit;
        getData();
      }
    });
  }

  getData() async {
    products = await ProductListService().getProducts();
    if (products != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage'), centerTitle: true),
      body: Visibility(
        visible: isLoaded,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          controller: scrollController,
          itemCount: products?.length ?? 0 + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < products!.length) {
              return InkWell(
                onTap: () {
                  // Navigate to product details screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailScreen(id: products![index].id),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(products![index].images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products![index].title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              products![index].thumbnail,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 10),
                            ),
                            Text(
                              'Price: \$${products![index].price}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Rating: ${products![index].rating}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            // return InkWell(
            //   onTap: () {
            //     // Navigate to product details screen
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) =>
            //             ProductDetailScreen(id: products![index].id),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     child: Container(
            //       padding: const EdgeInsets.all(16),
            //       child: Row(
            //         children: [
            //           Container(
            //             height: 50,
            //             width: 50,
            //             decoration: BoxDecoration(
            //               color: Colors.blueAccent,
            //               borderRadius: BorderRadius.circular(12),
            //               image: DecorationImage(
            //                 image: NetworkImage(products![index].images[0]),
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //           const SizedBox(width: 16),
            //           Expanded(
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   products![index].title,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //                 Text(
            //                   products![index].thumbnail,
            //                   maxLines: 2,
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyle(fontSize: 10),
            //                 ),
            //                 Text(
            //                   products![index].price.toString(),
            //                   overflow: TextOverflow.ellipsis,
            //                   style: TextStyle(
            //                     fontSize: 10,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // );
          },
        ),
      ),
    );
  }
}
