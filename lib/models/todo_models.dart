// ignore_for_file: avoid_print, unused_local_variable, prefer_const_declarations, prefer_typing_uninitialized_variables, avoid_returning_null_for_void, unused_import, body_might_complete_normally_nullable, non_constant_identifier_names, recursive_getters, depend_on_referenced_packages

// import 'package:app_notes/modules/newtasks/newtasks.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/shared/constans/constans.dart';

// import '../shared/component/constans.dart';

final String tableNote = 'note';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnTime = 'time';
final String columnDate = 'date';

class NoteModel {
  int? id;
  String? title;
  String? time;
  String? date;

  // get tim => null;

  // get tit => null;

  // get dat => null;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnTime: time,
      columnDate: date,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  NoteModel({this.title, this.time, this.date});

  NoteModel.fromMap(Map<String, dynamic> map) {
    id = map[columnId]!;
    title = map[columnTitle]!;
    time = map[columnTime]!;
    date = map[columnDate]!;
  }
}

class Sqldb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'test.db');
    Database Mydb = await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onUpgrade: _onUpgrade,
    );
    return Mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    print("onUpgrade================");
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE 'todo' (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT   NOT NULL  ,
      $columnTitle TEXT NOT NULL ,
      $columnTime TEXT NOT NULL ,
      $columnDate TEXT NOT NULL
    )
''');
    print('onCreate DataBase AND TABLE===========');
  }

  readData(String sql) async {
    Database? Mydb = await db;
    List<Map> response = await Mydb!.rawQuery(sql);
    // notesModels = response.cast<NoteModel>();
    return response;
  }

  insertData({required title, required time, required date}) async {
    Database? Mydb = await db;
    int response = await Mydb!.rawInsert(
        'INSERT INTO todo (title,time,date) VALUES("$title" ," $time" , "$date")');
    print("inserted successfuly");
    return response;
  }

  updateData(String sql) async {
    Database? Mydb = await db;
    int response = await Mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? Mydb = await db;
    int response = await Mydb!.rawDelete(sql);
    return response;
  }

  Future getAllNotesTable() async {
    notes = [];
    List<Map<String, dynamic>> data = await readData("SELECT * FROM todo");

    for (var element in data) {
      notes.add(element);
    }
    return notes;
  }
}

// class SqlDb {
//   static Database? _db;

//   Future<Database?> get db async {
//     if (_db == null) {
//       _db = await intialDb();
//     } else {
//       return db;
//     }
//   }

//   intialDb() async {
//     String databasepath = await getDatabasesPath();
//     String path = join(databasepath, 'test.db');
//     Database Mydb = await openDatabase(path,
//         version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
//     return Mydb;
//   }

//   _onUpgrade(Database db, int oldversion, int newversion) {}

//   _onCreate(Database db, int version) {
//     db.execute('''
//       CREATE TABLE '$tableNote'(
//         $columnId INTEGER PRIMARY KEY AUTOINCREMENT NO NULL ,
//         $columnTitle TEXT NO NULL ,
//         $columnTime TEXT NO NULL ,
//         $columnDate TEXT NO NULL

//       )
//  ''');
//     print("Create DATABASE AND TABLE==============");
//   }

//   readData(String sql) async {
//     Database? Mydb = await db;
//     List<Map> response = await Mydb!.rawQuery(sql);
//     return response;
//   }

//   insertData(String sql) async {
//     Database? Mydb = await db;
//     int response = await Mydb!.rawInsert(sql);
//     return response;
//   }

//   updateData(String sql) async {
//     Database? Mydb = await db;
//     int response = await Mydb!.rawUpdate(sql);
//     return response;
//   }

//   deleteData(String sql) async {
//     Database? Mydb = await db;
//     int response = await Mydb!.rawDelete(sql);
//     return response;
//   }
// }

// Database? database;
// List<Map> tasks = [];

// void creatDatabase() async {
//   database = await openDatabase(
//     'todo.db',
//     version: 1,
//     onCreate: (database, version) {
//       print("Database Created");
//       database
//           .execute(
//               'CREATE TABLE $tableNote($columnId INTEGER PRIMARY KEY , $columnTitle TEXT , $columnTime TEXT , $columnDate TEXT)')
//           .then((value) {
//         print('tabel Created');
//       }).catchError((error) {
//         print('Error When Creating Tabel ${error.toString()}');
//       });
//     },
//     onOpen: (database) {
//       print("Database Opened");
//     },
//   );
// }

// Future<void> insertDatabase(
//     {required String title, required String time, required String date}) async {
//   return await database!.transaction((txn) async {
//     await txn.rawInsert('''
//       INSERT INTO $tableNote($columnTitle , $columnTime , $columnDate)
//       VALUES ('$title' , '$time' , '$date')
//     ''');
//   }).then((value) {
//     print("database inserted");
//   }).catchError((error) {
//     print('Error When Inserting ${error.toString()}');
//   });

//   // return null;
// }

// Future<List<Map>> getDataFromDatabase(database) async {
//   return await database.rawQuery('SELECT * FROM $tableNote');
// }
// // getDataFromDatabase(database)
