import 'package:flutter/material.dart';
import 'package:google_maps/app/domain/models/product.dart';
import '../checkout_page.dart' show checkoutProvider;

class CheckoutWidget extends StatelessWidget {
  CheckoutWidget({Key? key}) : super(key: key);

  final _controller = checkoutProvider.read;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: StreamBuilder(
        stream: _controller.getCartStream,
        initialData: _controller.getItems,
        builder: (_, AsyncSnapshot<List<Product>?> snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data;
            if (products != null) {
              if (products.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  itemBuilder: (_, index) {
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
                              "Cant. ${products[index].quantity}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "\$ ${products[index].price}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            )
                          ],
                        ),
                        trailing: Text(
                          "\$ ${products[index].subtotal}",
                          style: const TextStyle(
                            fontSize: 24,
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
      ),
    );
  }
}
