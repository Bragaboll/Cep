import 'package:app_cep/address_model.dart';
import 'package:app_cep/resultado.dart';
import 'package:flutter/material.dart';
import 'app_controller.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: AppController.instance.isDarkTheme
                  ? Brightness.dark
                  : Brightness.light,
              primarySwatch: Colors.blue,
            ),
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: {
              '/': (context) => const Home(),
              '/resultado': (context) => Resultado(
                  item: ModalRoute.of(context)?.settings.arguments
                      as AddressModel),
            },
          );
        });
  }
}
