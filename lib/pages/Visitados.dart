import 'package:flutter/material.dart';
import 'package:versatil/pages/Avaliados.dart';
import 'package:versatil/pages/avalidos_page.dart';
import 'package:versatil/pages/locaisAvaliadosDAO.dart';

class Visitados extends StatefulWidget {
  const Visitados({Key? key}) : super(key: key);

  @override
  State<Visitados> createState() => _VisitadosState();
}

class _VisitadosState extends State<Visitados> {
  locaisAvaliadosDAO db = locaisAvaliadosDAO();
  List<Avaliado> _listaAvaliados = [];
  @override
  void initState() {
    super.initState();
    atualizarListaAvaliados();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avaliados'), centerTitle: true),
      body: ListView.builder(
        itemCount: _listaAvaliados.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
            direction: DismissDirection.startToEnd,
            background: Container(
              color: Colors.red,
              child: const Align(
                alignment: Alignment(-0.9, 0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
            onDismissed: (direcao) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (inContext) {
                  return WillPopScope(
                    onWillPop: () async => false,
                    child: AlertDialog(
                      title: const Text('Deseja mesmo excluir o produto?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(inContext);
                            atualizarListaAvaliados();
                          },
                          child: Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            removerProduto(_listaAvaliados[index].rank);
                            Navigator.pop(inContext);
                            atualizarListaAvaliados();
                          },
                          child: Text('Sim'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: ListTile(
              leading: const Icon(
                Icons.beenhere_outlined,
                color: Color.fromARGB(255, 70, 53, 33),
                size: 25,
              ),
              title: Text(_listaAvaliados[index].nome!),
              subtitle: Text(
                  '\$\$:${_listaAvaliados[index].preco!}, Avaliação: ${_listaAvaliados[index].avaliacao!}'),
              trailing: const Icon(
                Icons.assignment_outlined,
                color: Color.fromARGB(255, 70, 53, 33),
              ),
              onTap: () {
                exibeAvaliadoPage(_listaAvaliados[index]);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          exibeAvaliadoPage();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void exibeAvaliadoPage([Avaliado? avaliado]) async {
    final produtoRecebido = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AvaliadoPage(avaliado: avaliado)));
    if (produtoRecebido != null) {
      if (avaliado != null) {
        await db.updateAvaliado(produtoRecebido);
      } else {
        await db.insertAvaliado(produtoRecebido);
      }
      atualizarListaAvaliados();
    }
  }

  void atualizarListaAvaliados() {
    db.getAvaliados().then((lista) {
      setState(() {
        _listaAvaliados = lista;
      });
    });
  }

  void removerProduto(idProduto) async {
    await db.deleteAvaliado(idProduto);
  }
}
