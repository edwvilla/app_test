import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:emailjs/emailjs.dart' as emailjs;

class ContactSellerController extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  final phoneController = TextEditingController(text: '+52 667 302 17 37');

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final messageController = TextEditingController();

  void callSeller(BuildContext context) {
    try {
      launchUrlString('tel:${phoneController.text}');
    } catch (e) {
      print(e);
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('No se puede realizar la llamada'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              ));
    }
  }

  void sendEmail(BuildContext context) async {
    isLoading = true;

    try {
      Map<String, dynamic> templateParams = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'text': messageController.text.trim(),
      };

      try {
        await emailjs.send(
          'service_oeiphzo',
          'template_yf4b9pb',
          templateParams,
          const emailjs.Options(
            publicKey: 'RxT_nYSXJF98g-rLT',
            privateKey: '07P4YY-yH5L8cdKFhMs8t',
          ),
        );

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Correo enviado'),
            content: const Text('El correo ha sido enviado correctamente'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      } catch (error) {
        print('$error');
      }
    } catch (e) {
      log(e.toString());
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('No se puede enviar el correo'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Aceptar'),
                  ),
                ],
              ));
    } finally {
      isLoading = false;
    }
  }

  sendFCMAlert() {
    // Send firebase cloud message alert to the seller that the buyer is interested
  }
}
