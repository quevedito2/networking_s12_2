import 'package:networking_s12_2/Modelo/Usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class db {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'usuarios.db'),
        onCreate: (database, version) async {
      await database.execute(
          "CREATE TABLE usuarios(id INTEGER PRIMARY KEY AUTOINCREMENT, nombre TEXT NOT NULL, correo TEXT NOT NULL)");
    }, version: 1);
  }

  Future<void> insertarUsuario(Usuario usuario) async {
    final db = await initializeDB();
    await db.insert('usuarios', usuario.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Usuario>> listarUsuarios() async {
    final db = await initializeDB();
    final List<Map<String, dynamic>> queryResult =
        await db.query('usuarios', orderBy: 'id');
    return queryResult.map((e) => Usuario.fromMap(e)).toList();
  }
}
