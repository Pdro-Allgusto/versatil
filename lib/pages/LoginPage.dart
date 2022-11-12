import 'package:flutter/material.dart';
import 'package:versatil/pages/validation.dart';
import '../pessoa.dart';
import '../routes.dart';

class LoginPage extends StatelessWidget {
  final Validation validar = Validation();
  final _formKey = GlobalKey<FormState>();
  final Pessoa usuario = Pessoa();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              SizedBox(
                width: 128,
                height: 128,
                child: Image.asset("assets/images/logo.png"),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'E-mail',
                        hintText: 'Entre com seu e-mail',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 179, 179, 179)),
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 123, 99))),
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) =>
                          validar.campoEmailLogin(email.toString()),
                      onSaved: (String? value) {
                        usuario.email = value;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Entre com sua senha',
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w100,
                            fontSize: 15.0,
                            color: Color.fromARGB(255, 179, 179, 179)),
                        labelStyle: TextStyle(
                          color: Colors.black38,
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 145, 123, 99))),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      validator: (senha) =>
                          validar.campoSenhaLogin(senha.toString()),
                      onFieldSubmitted: (value) {
                        _onSubmit(context);
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 70, 53, 33),
                            onPrimary:
                                const Color.fromARGB(255, 255, 255, 255)),
                        child: const Text(
                          "Login",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          _onSubmit(context);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 70, 53, 33),
                            onPrimary: Color.fromARGB(255, 255, 255, 255)),
                        child: const Text(
                          "Cadastre-se",
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              Routes.PAGINA_CADASTRO,
                              arguments: null);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  void _onSubmit(inContext) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Navigator.of(inContext)
          .pushNamed(Routes.PAGINA_DADOS, arguments: usuario);
    } else {
      showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (inContext) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: const Text('Dados Inválidos!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
