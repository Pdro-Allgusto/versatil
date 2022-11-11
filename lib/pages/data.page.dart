import 'package:flutter/material.dart';
import 'package:versatil/pages/LoginPage.dart';
import 'package:versatil/pages/vistasDAO.dart';
import 'package:versatil/pessoa.dart';
import 'dart:convert';
import 'package:versatil/routes.dart';

class DadosPage extends StatefulWidget {
  @override
  State<DadosPage> createState() => _DadosPageState();
}

class _DadosPageState extends State<DadosPage> {
  Map<String, dynamic>? _ultimoItemRemovido;
  int? _posicaoUltimoItemRemovido;

  final _visitaController = TextEditingController();
  List _listaTarefas = [];
  visitasDao db = visitasDao();
  @override
  void initState() {
    super.initState();
    db.readData().then(
      (data) {
        setState(() {
          _listaTarefas = json.decode(data!);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pessoa = ModalRoute.of(context)?.settings.arguments as Pessoa;
    if (pessoa.nome == null) {
      pessoa.nome = 'Gustavo';
      pessoa.sobrenome = 'pedrosa';
    }

    return Scaffold(
      appBar: AppBar(title: const Text('SoulChef'), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: _atualiza,
              child: ListView.builder(
                itemCount: _listaTarefas.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    background: Container(
                      color: Colors.red,
                      child: const Align(
                        alignment: Alignment(-0.9, 0),
                        child: Icon(
                          Icons.add_business_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.green,
                      child: Align(
                        alignment: Alignment(0.9, 0),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // ignore: sort_child_properties_last
                    child: CheckboxListTile(
                      title: Text(_listaTarefas[index]['descricao']),
                      value: _listaTarefas[index]['ok'],
                      secondary: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: _listaTarefas[index]['ok']
                            ? Colors.green
                            : Colors.red,
                        child: Icon(_listaTarefas[index]['ok']
                            ? Icons.add_location_alt_rounded
                            : Icons.add_location_alt_outlined),
                      ),
                      onChanged: (checked) {
                        setState(() {
                          _listaTarefas[index]['ok'] = checked;
                          db.saveData(_listaTarefas);
                        });
                      },
                    ),
                    //direction: DismissDirection.startToEnd,
                    onDismissed: (direcao) {
                      _ultimoItemRemovido = Map.from(_listaTarefas[index]);
                      _posicaoUltimoItemRemovido = index;
                      _listaTarefas.removeAt(index);
                      db.saveData(_listaTarefas);
                      if (direcao == DismissDirection.startToEnd) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: const Duration(seconds: 2),
                            content: Text(
                              '"${_ultimoItemRemovido!['descricao']}" removido(a).',
                              style: const TextStyle(color: Colors.blue),
                            ),
                            action: SnackBarAction(
                              label: 'Desfazer',
                              onPressed: () {
                                setState(() {
                                  _listaTarefas.insert(
                                      _posicaoUltimoItemRemovido!,
                                      _ultimoItemRemovido);
                                  db.saveData(_listaTarefas);
                                });
                              },
                            ),
                          ),
                        );
                      }
                      if (direcao == DismissDirection.endToStart) {
                        setState(() {
                          _listaTarefas.insert(
                              _posicaoUltimoItemRemovido!, _ultimoItemRemovido);
                          _listaTarefas[index]['ok'] =
                              !_listaTarefas[index]['ok'];
                          db.saveData(_listaTarefas);
                        });
                      }
                    },
                  );
                },
              ),
            ),
          ),
          Form(
            child: Container(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 60),
              child: TextFormField(
                controller: _visitaController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    labelText: 'Tarefa',
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 95, 25, 0),
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                    hintText: 'Adcione uma tarefa',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 15.0,
                        color: Color.fromARGB(255, 179, 179, 179)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.black12,
                    ))),
                onFieldSubmitted: (texto) {
                  _onSubmit(context, texto);
                },
              ),
            ),
          )
        ],
      ),

      //==========================================
      drawer: SafeArea(
        child: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  '${pessoa.nome} ${pessoa.sobrenome}'.toUpperCase(),
                  style: const TextStyle(fontSize: 25),
                ),
                accountEmail: Text(
                  '${pessoa.email}',
                  style: const TextStyle(fontSize: 17),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/logo_interna.png'),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_business_outlined,
                  color: Colors.brown,
                ),
                title: const Text("Lugares à Visitar"),
                subtitle: const Text("Lugares para conhecer..."),
                trailing: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.brown,
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/dados");
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_reaction_outlined,
                  color: Colors.brown,
                ),
                title: const Text("Restaurante Avaliados"),
                subtitle: const Text("Lugares que já fui..."),
                trailing: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.brown,
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.PAGINA_VISITADOS, arguments: null);
                  print("Restaurante avaliados");
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.exit_to_app,
                  color: Colors.brown,
                ),
                title: const Text("Logout"),
                trailing: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.brown,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(),
                    ),
                  );

                  print("Anúncios");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(context, texto) {
    if (texto.toString().isNotEmpty) {
      setState(() {
        Map<String, dynamic> novaTarefa = {};
        novaTarefa['descricao'] = _visitaController.text;
        _visitaController.clear();
        novaTarefa['ok'] = false;
        _listaTarefas.add(novaTarefa);
        db.saveData(_listaTarefas);
      });
      print('Tarefa adicionada!!!!');
    } else {
      print('Sem Tarefa preenchida');
    }
  }

  Future<void> _atualiza() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _listaTarefas.sort((a, b) {
        return (a['ok'].toString()).compareTo(b['ok'].toString());
      });
      db.saveData(_listaTarefas);
    });
  }
}
