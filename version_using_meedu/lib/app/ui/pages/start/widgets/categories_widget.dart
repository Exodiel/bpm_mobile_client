import 'package:flutter/material.dart';
import 'package:google_maps/app/domain/models/category.dart';
import '../start_page.dart' show startProvider;


class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  final _controller = startProvider.read;

  @override
  void initState() {
    _controller.initializeNotifications(context);
    _controller.connect();
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder(
        future: _controller.find(),
        builder: (_, AsyncSnapshot<List<Category>> snapshot) {
          final categories = snapshot.data;
          if (snapshot.hasData) {
            if (categories != null) {
              return GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.goToProducts(categories[index].id);
                    },
                    child: Card(
                      elevation: 4.0,
                      child: Column(
                        children: [
                          Flexible(
                            child: Ink.image(
                              image: NetworkImage(
                                categories[index].image,
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              categories[index].name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
