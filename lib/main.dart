import 'package:versatil/pages/LoginPage.dart';
import 'package:versatil/pages/signup.page.dart';
import 'package:versatil/pages/data.page.dart';
import 'package:versatil/routes.dart';
import 'package:versatil/pages/reset-password.page.dart';
import 'package:flutter/material.dart';
import 'package:versatil/routes.dart';

main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        routes: {
          Routes.HOME: (context) => LoginPage(),
          Routes.PAGINA_CADASTRO: (context) => SignupPage(),
          Routes.PAGINA_DADOS: (context) => DadosPage(),
        });
  }
}
