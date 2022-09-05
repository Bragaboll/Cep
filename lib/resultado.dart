import 'package:flutter/material.dart';
import 'package:app_cep/address_model.dart';

class Resultado extends StatefulWidget {
  const Resultado({
    Key? key,
    required this.item,
  }) : super(key: key);
  final AddressModel item;

  @override

  // ignore: no_logic_in_create_state
  State<Resultado> createState() => _ResultadoState(item);
}

class _ResultadoState extends State<Resultado> {
  final AddressModel item;

  _ResultadoState(this.item);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Resultado',
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 160),
            child: ListTile(
              title: Text(
                '${item.logradouro}${item.complemento}, ${item.bairro}, ${item.localidade}.',
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop('/home');
                  },
                  child: const Text(
                    'Voltar',
                    style: TextStyle(fontSize: 22),
                  ),
                 
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
