import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps/app/domain/models/product.dart';
import '../cart_page.dart' show cartPageProvider;

class CartPageWidget extends StatelessWidget {
  CartPageWidget({Key? key}) : super(key: key);

  final _controller = cartPageProvider.read;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  products[index].quantity++;
                                  products[index].subtotal = products[index].quantity * double.parse(products[index].price);
                                  _controller.recalculate(products[index]);
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.plusCircle,
                                  color: Colors.green,
                                  size: 28,
                                ),
                              ),
                              Text(
                                "${products[index].quantity}",
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  if (products[index].quantity > 1) {
                                    products[index].quantity--;
                                    products[index].subtotal = products[index].quantity * double.parse(products[index].price);
                                    _controller.recalculate(products[index]);
                                  }
                                },
                                icon: const Icon(
                                  FontAwesomeIcons.minusCircle,
                                  color: Colors.red,
                                  size: 28,
                                ),
                              ),
                            ],
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
    );
  }
}
