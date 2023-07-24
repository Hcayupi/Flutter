import 'package:mantencion/Model/maquina.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  DatabaseHandler._privateConstructor();

  static final DatabaseHandler instance = DatabaseHandler._privateConstructor();
  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    /* Directory documentsDirectory = await getApplicationDocumentsDirectory();//iOS
    String path = join(documentsDirectory.path, 'mantencion.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );*/

    return openDatabase(join(await getDatabasesPath(), 'mantencion.db'),
        onCreate: (db, version) {
      return db.execute(
          '''CREATE TABLE maquina (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, nombre  TEXT NOT NULL, modelo TEXT NOT NULL,agno 
          INTEGER NOT NULL,descripcion  TEXT NULL,lecturaPanel  INTEGER NOT NULL,
          unidad TEXT NOT NULL)''');
    }, version: 2);
  }

  Future<int> nuevaMaquina(Maquina maquina) async {
    Database db = await instance.database;
    //db.query('maquina').then((value) => print(value));
    return await db.insert('maquina', maquina.toMap());
  }

  Future<List<Maquina>> listaMaquinas() async {
    Database db = await instance.database;

    List<Maquina> listaMaquinas = [];
    await db.query('maquina').then((value) {
      for (var maquina in value) {
        listaMaquinas.add(Maquina.fromMap(maquina));
      }
    });

    return listaMaquinas;
  }
}
