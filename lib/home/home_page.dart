import 'dart:developer';

import 'package:app_test/detail/detail_page.dart';
import 'package:app_test/extensions.dart';
import 'package:app_test/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

    if (controller.products.isEmpty) {
      controller.getProducts();
      controller.initController();

      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppbar(),
      drawer: const CustomDrawer(),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 20,
        ),
        controller: controller.scrollController,
        children: [
          SizedBox(
            width: double.infinity,
            child: Center(
              child: ToggleButtons(
                onPressed: controller.selectButton,
                isSelected: controller.buttonValues,
                selectedColor: Colors.blue,
                fillColor: Colors.blue.withOpacity(0.1),
                children: const [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text('Autos'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text('Inmuebles'),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Text('Electronicos'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          const SearchBarApp(),
          const SizedBox(height: 12),
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];

              return InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        product: product,
                      ),
                    ),
                  );
                },
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.image,
                            width: 110,
                            height: 110,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 110,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  product.title.capitalizeFirstLetter,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Text(product.price.getFormattedPrice),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              product.description,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              );
            },
          ),
          if (controller.isLoadingMore)
            const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }

  AppBar CustomAppbar() {
    return AppBar(
      title: const Text(
        'Buscador Anuncio',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blueGrey[900],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  State<SearchBarApp> createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      builder: (BuildContext context, SearchController controller) {
        return SearchBar(
          backgroundColor: WidgetStatePropertyAll<Color>(Colors.grey[100]!),
          controller: controller,
          padding: const WidgetStatePropertyAll<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 16.0)),
          onTap: () {
            controller.openView();
          },
          onChanged: (_) {
            controller.openView();
          },
          leading: const Icon(Icons.search),
        );
      },
      suggestionsBuilder: (BuildContext context, SearchController controller) {
        final products =
            Provider.of<HomeController>(context, listen: false).products;
        final suggestions = products
            .where((product) => product.title
                .toLowerCase()
                .contains(controller.text.toLowerCase()))
            .toList();
        return List<ListTile>.generate(suggestions.length, (int index) {
          final String item = suggestions[index].title;
          return ListTile(
            title: Text(item),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    product: suggestions[index],
                  ),
                ),
              );
            },
          );
        });
      },
    );
  }
}
