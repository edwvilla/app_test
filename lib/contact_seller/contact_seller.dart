import 'package:app_test/contact_seller/contact_seller_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactSellerPage extends StatelessWidget {
  const ContactSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ContactSellerController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contactar al vendedor',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue.shade900,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                      'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png'),
                ),
              ),
              const Center(
                child: Text(
                  'Juan Perez',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 10),
                  Text('Llamar al vendedor'),
                ],
              ),
              InkWell(
                onTap: () => controller.callSeller(context),
                child: TextField(
                  controller: controller.phoneController,
                  enabled: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(
                      color: Colors.black,
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Icon(Icons.email),
                  SizedBox(width: 10),
                  Text('Enviar correo'),
                ],
              ),
              const SizedBox(height: 5),
              const Text('Nombre'),
              TextField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Correo'),
              TextField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              const Text('Mensaje'),
              TextField(
                controller: controller.messageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                  ),
                  onPressed: () => controller.sendEmail(context),
                  child: controller.isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        )
                      : const Text(
                          'Enviar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
