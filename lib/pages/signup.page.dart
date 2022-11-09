
import 'package:flutter/material.dart';
import 'package:versatil/pages/validation.dart';
import 'package:versatil/pessoa.dart';
import 'package:versatil/pages/data.page.dart';
import 'package:versatil/routes.dart';


class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final Validation validar = Validation();
  final Pessoa usuario = Pessoa();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Página de Cadastro'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                    hintText: 'Entre com seu nome',
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
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  validator: (nome) => validar.campoNome(nome.toString()),
                  onSaved: (String? value) {
                    usuario.nome = value;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Sobrenome',
                    hintText: 'Entre com seu sobrenome',
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
                  keyboardType: TextInputType.text,
                  validator: (sobrenome) =>
                      validar.campoSobreNome(sobrenome.toString()),
                  onSaved: (String? value) {
                    usuario.sobrenome = value;
                  },
                ),
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
                  validator: (email) => validar.campoEmail(email.toString()),
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
                  keyboardType: TextInputType.number,
                  validator: (senha) => validar.campoSenha(senha.toString()),
                  onSaved: (String? value) {
                    usuario.senha = value;
                  },
                  onFieldSubmitted: (value) {
                    _onSubmit(context);
                  },
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    child: const Text('Cadastrar'),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    onPressed: () {
                      _onSubmit(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit(inContext) {
    if (_formKey.currentState!.validate()) {
      print('Formulário Validado!');

      _formKey.currentState!.save();

      Navigator.of(inContext).pushNamed(Routes.PAGINA_DADOS, arguments: usuario);

    } else {
      print('********* Formulário com erros. ********');
      showDialog(
        context: inContext,
        barrierDismissible: false,
        builder: (inContext) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text('Dados Inválidos!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(inContext);
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    }
  }
}
