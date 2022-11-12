import 'package:versatil/pages/LoginPage.dart';
import 'package:versatil/pages/signup.page.dart';
import 'package:versatil/pages/data.page.dart';
import 'package:versatil/pages/Visitados.dart';
import 'package:versatil/routes.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        routes: {
          Routes.HOME: (context) => LoginPage(),
          Routes.PAGINA_CADASTRO: (context) => SignupPage(),
          Routes.PAGINA_DADOS: (context) => DadosPage(),
          Routes.PAGINA_VISITADOS: (context) => Visitados(),
        });
  }
}
