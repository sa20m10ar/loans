import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Program {
  final int id;
  final String value;

  Program(this.id, this.value);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }
}

class ProgramHelper {
  Database db;

  ProgramHelper() {
    initDataBase();
  }

  Future<void> initDataBase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), "program_db.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE programs(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertProgram(Program program) async {
    try {
      db.insert(
        'programs',
        program.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (_) {
      print(_);
    }
  }

  Future<List<Program>> getAllPrograms() async {
    final List<Map<String, dynamic>> programs = await db.query('programs');
    return List.generate(programs.length, (i) {
      return Program(programs[i]['id'], programs[i]['value']);
    });
  }

  Future<void> deleteProgram(int id) async {
    await db.delete(
      'programs',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}

