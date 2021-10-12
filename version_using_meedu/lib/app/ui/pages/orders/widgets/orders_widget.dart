import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps/app/domain/models/order.dart';
import '../orders_page.dart' show ordersProvider;

class OrdersWidget extends StatelessWidget {
  OrdersWidget({Key? key}) : super(key: key);
  final _controller = ordersProvider.read;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder(
        future: _controller.getOrdersByLoggedUser(),
        builder: (_, AsyncSnapshot<List<Orders>> snapshot) {
          final orders = snapshot.data;
          if (snapshot.hasData) {
            if (orders != null) {
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (_, index) {
                  return Card(
                    elevation: 4,
                    child: ListTile(
                      title: Text(
                        orders[index].sequential,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          Text(
                            orders[index].date,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "TOTAL: \$ ${orders[index].total}",
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: Text(
                        orders[index].state,
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
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
