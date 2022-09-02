import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:app_cep/address_model.dart';
import 'package:app_cep/switch_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Future<dynamic> buscaCep() async {
    dynamic cep = txtcep.text;
    var url = Uri.parse('http://viacep.com.br/ws/$cep/json/');
    http.Response response;
    response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> dados = json.decode(response.body);
      String? erro = dados['erro'];
      if (erro == 'true') {
        const snackBar = SnackBar(
          content: Text('Cep Inválido'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        String logradouro = dados['logradouro'];
        String complemento = dados['complemento'];
        String bairro = dados['bairro'];
        String localidade = dados['localidade'];
        final AddressModel address = AddressModel(
            logradouro: logradouro,
            complemento: complemento,
            bairro: bairro,
            localidade: localidade);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed('/resultado', arguments: address);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_literals_to_create_immutables
        actions: [
          const SwitchWidget(),
        ],
        title: const Text(
          'Consulta de Cep',
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: txtcep,
                        decoration:
                            const InputDecoration(labelText: 'Digite um cep'),
                        style:
                            const TextStyle(fontSize: 18, color: Colors.blue),
                        onSaved: (cep) {
                          txtcep.text = cep!;
                        },
                        validator: (cep) {
                          if (cep!.isEmpty || cep.length < 8) {
                            return 'Cep inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            _formkey.currentState!.save();
                            buscaCep();
                          }
                        },
                        child: const Text(
                          'Consultar',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
