import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Avaliados.dart';

// ATENÇÃO: fazer o import de produto.dart
// ignore: camel_case_types
class locaisAvaliadosDAO {
  static locaisAvaliadosDAO? _avaliadoDao;
  static Database? _database;
  locaisAvaliadosDAO._createInstance();
  factory locaisAvaliadosDAO() {
    _avaliadoDao ??= locaisAvaliadosDAO._createInstance();
    return _avaliadoDao!;
  }
  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String databaseName = 'avaliado.db';
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, databaseName);
    var produtosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return produtosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE avaliado ("
        "rank INTEGER PRIMARY KEY AUTOINCREMENT,"
        "nome TEXT,"
        "preco TEXT,"
        "avaliacao DOUBLE"
        ")");
  }

  void dropTable() async {
    Database db = await database;
    await db.execute("DROP TABLE avaliado");
  }

  Future<int> insertAvaliado(Avaliado avaliado) async {
    Database db = await database;
    var resultado = await db.insert(
      'avaliado',
      avaliado.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
    return resultado;
  }

  Future<List<Avaliado>> getAvaliados() async {
    Database db = await database;
    var resultado = await db.query('avaliado');
    List<Avaliado> lista = resultado.isNotEmpty
        ? resultado.map((item) => Avaliado.fromMap(item)).toList()
        : [];
    return lista;
  }

  Future<Avaliado?> getAvaliado(int rank) async {
    Database db = await database;
    List maps = await db.query(
      'avaliado',
      columns: ['rank', 'nome', 'preco', 'avaliacao'],
      where: "rank = ?",
      whereArgs: [rank],
    );
    if (maps.isNotEmpty) {
      return Avaliado.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateAvaliado(Avaliado avaliado) async {
    var db = await database;
    int resultado = await db.update(
      'avaliado',
      avaliado.toMap(),
      where: "rank = ?",
      whereArgs: [avaliado.rank],
    );
    return resultado;
  }

  Future<int> deleteAvaliado(int rank) async {
    var db = await database;
    int resultado = await db.delete(
      'avaliado',
      where: "rank = ?",
      whereArgs: [rank],
    );
    return resultado;
  }

  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> list =
        await db.rawQuery('SELECT COUNT (*) from avaliado');
    int? resultado = Sqflite.firstIntValue(list);
    return resultado!;
  }

  Future close() async {
    Database db = await database;
    db.close();
  }
}
