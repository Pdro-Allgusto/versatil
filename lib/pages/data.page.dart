import 'package:versatil/pessoa.dart';
import 'package:flutter/material.dart';

class DadosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pessoa = ModalRoute.of(context)!.settings.arguments as Pessoa;
    return Scaffold(
      appBar: AppBar(title: Text('Dados Pessoais'), centerTitle: true),
      body: const Center(
        child: Text(
          'Home Page',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                  'E-mail: ${pessoa.email}',
                  style: const TextStyle(fontSize: 15),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/bart.jpg'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.announcement),
                title: const Text("Anúncios"),
                subtitle: const Text("mais informações..."),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/anuncios");
                  print("Anúncios");
                },
              ),
              ListTile(
                leading: const Icon(Icons.cloud),
                title: const Text("Dados"),
                subtitle: const Text("mais informações..."),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/dados");
                  print("Dados");
                },
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Favoritos"),
                subtitle: const Text("mais informações..."),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, "/favoritos");
                  print("Favoritos");
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Logout"),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  print("Logout");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
