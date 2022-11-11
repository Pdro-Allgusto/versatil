import 'package:flutter/material.dart';
import 'package:versatil/pages/Avaliados.dart';

class AvaliadoPage extends StatefulWidget {
  final Avaliado? avaliado;
  const AvaliadoPage({Key? key, this.avaliado}) : super(key: key);
  @override
  _AvaliadoPageState createState() => _AvaliadoPageState();
}

class _AvaliadoPageState extends State<AvaliadoPage> {
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _avaliacaoController = TextEditingController();

  late Avaliado _editarAvaliado;
  bool editado = false;

  @override
  void initState() {
    super.initState();
    if (widget.avaliado == null) {
      _editarAvaliado = Avaliado(null, '', '', 0);
    } else {
      _editarAvaliado = Avaliado.fromMap(widget.avaliado!.toMap());
      _nomeController.text = _editarAvaliado.nome!;
      _precoController.text = _editarAvaliado.preco!;
      _avaliacaoController.text = _editarAvaliado.avaliacao.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editarAvaliado.nome == ''
              ? 'Nova Avaliação'
              : (_editarAvaliado.nome).toString(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 60, left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Nome do Restaurante',
                hintText: 'Entre com o Restaurante',
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 145, 123, 99))),
              ),
              controller: _nomeController,
              onChanged: (nome) {
                editado = true;
                setState(() {
                  _editarAvaliado.nome = nome;
                });
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Preço',
                hintText: 'Entre com o preço',
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 145, 123, 99))),
              ),
              controller: _precoController,
              onChanged: (preco) {
                editado = true;
                _editarAvaliado.preco = preco.toString();
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(
                labelText: 'Avaliação',
                hintText: 'Entre com a avaliação',
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 145, 123, 99))),
              ),
              controller: _avaliacaoController,
              onChanged: (avaliacao) {
                editado = true;
                _editarAvaliado.avaliacao = double.parse(avaliacao);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if ((_editarAvaliado.nome).toString().isEmpty ||
              _editarAvaliado.preco == 0 ||
              _editarAvaliado.avaliacao == 0) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (inContext) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text(
                        'Todos os dados devem ser preenchidos e ou não devem sernulos!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(inContext);
                        },
                        child: Text('Ok'),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            Navigator.pop(context, _editarAvaliado);
          }
        },
      ),
    );
  }
}
