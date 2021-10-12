import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../checkout_page.dart' show checkoutProvider;

class AddressWidget extends StatelessWidget {
  AddressWidget({Key? key}) : super(key: key);

  final _controller = checkoutProvider.read;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        _controller.goToHome();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Text(
          'Seleccione el lugar de entrega',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
