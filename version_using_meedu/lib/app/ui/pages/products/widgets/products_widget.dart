import 'package:flutter/material.dart';
import 'package:google_maps/app/domain/models/product.dart';

import '../products_page.dart' show productsProvider;

class ProductsWidget extends StatelessWidget {
  final int? categoryId;
  ProductsWidget({Key? key, required this.categoryId}) : super(key: key);

  final _controller = productsProvider.read;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: _controller.getCartStream,
        initialData: _controller.getItems,
        builder: (_, AsyncSnapshot<List<Product>?> snap) {
          return FutureBuilder(
            future: _controller.findProductsByCategory(categoryId!),
            builder: (_, AsyncSnapshot<List<Product>?> snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data;
                if (products != null) {
                  if (products.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (_, index) {
                        final exists = _controller.exists(
                          products[index].id,
                        );
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(15),
                            leading: Ink.image(
                              width: 100,
                              height: 200,
                              image: NetworkImage(
                                products[index].image,
                              ),
                              fit: BoxFit.contain,
                            ),
                            title: Text(
                              products[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Disponible: ${products[index].stock}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "\$ ${products[index].price}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            trailing: !exists
                                ? IconButton(
                                    onPressed: () {
                                      _controller.addProduct(products[index]);
                                    },
                                    icon: const Icon(
                                      Icons.add_shopping_cart_outlined,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      _controller.removeProduct(
                                        products[index],
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.remove_shopping_cart_sharp,
                                    ),
                                  ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text(
                      'No hay productos disponibles',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        },
      ),
    );
  }
}
