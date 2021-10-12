import 'package:flutter/material.dart';

class PaymenWidget extends StatefulWidget {
  final TextEditingController controller;
  const PaymenWidget({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _PaymenWidgetState createState() => _PaymenWidgetState();
}

class _PaymenWidgetState extends State<PaymenWidget> {
  String _value = 'EFECTIVO';
 
  @override
  Widget build(BuildContext context) {
    widget.controller.text = _value;
    return DropdownButton<String>(
      value: _value,
      //elevation: 5,
      style: const TextStyle(color: Colors.black),
      items: <String>[
        'EFECTIVO',
        'CHEQUE',
        'TRANSFERENCIA',
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
      hint: const Text(
        'Seleccione una forma de pago',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      onChanged: (String? value) {
        setState(
          () {
            if (value != null) {
              _value = value;
              widget.controller.text = value;
            }
          },
        );
      },
    );
  }
}
