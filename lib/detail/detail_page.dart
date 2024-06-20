import 'package:app_test/contact_seller/contact_seller.dart';
import 'package:app_test/extensions.dart';
import 'package:app_test/models/product.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    void goToContactSeller() async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ContactSellerPage(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle Anuncio',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Image.network(product.image),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        product.price.getFormattedPrice,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Simulate rating

                  Column(
                    children: [
                      const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          Text('4.8'),
                          SizedBox(width: 5),
                          Text(
                            ' 10 reviews',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade50,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Mapa',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              Text(
                product.description,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),

          // Simulate bottom bar

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade400,
                ),
                onPressed: goToContactSeller,
                child: const Text(
                  'Contactar Vendedor',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
