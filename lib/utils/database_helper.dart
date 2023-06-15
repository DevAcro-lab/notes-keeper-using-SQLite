import 'package:notesapp/models/note_model.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class SQLHelper {
  static const _databaseName = 'notes.db';
  static const _databaseVersion = 1;

  static const table = 'notes';

  static const columnId = 'id';
  static const columnTitle = 'title';
  static const columnDescription = 'description';

  // Make this a singleton class
  SQLHelper._privateConstructor();
  static final SQLHelper instance = SQLHelper._privateConstructor();

  static sql.Database? _database;

  // if database is already created, then return that database, if not, return initDatabase and initialize a database
  Future<sql.Database?> get database async {
    _database ??= await initDatabase();
    return _database;
  }

  // initialize database
  initDatabase() async {
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _databaseName);
    return await sql.openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // onCreate method, which we have passed to openDatabase in initDatabase method.
  _onCreate(sql.Database database, int version) async {
    await database.execute('''
    CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY,
    $columnTitle TEXT NOT NULL,
    $columnDescription TEXT NOT NULL
    )
    ''');
  }

  // insert a note in a database
  Future<int> insertNote(NoteModel noteModel) async {
    sql.Database? db = await instance.database;
    return await db!.insert(table, noteModel.toMap());
  }

  // update an existing note
  Future<int> updateNote(NoteModel noteModel) async {
    sql.Database? db = await instance.database;
    return await db!.update(table, noteModel.toMap(),
        where: '$columnId= ?', whereArgs: [noteModel.id]);
  }

  // delete a note from the database
  Future<int> deleteNote(int id) async {
    sql.Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<NoteModel>> fetchNotesList() async {
    sql.Database? db = await instance.database;
    List<Map<String, dynamic>> maps = await db!.query(table);
    return maps.map((e) => NoteModel.fromMapObject(e)).toList();
  }
}
