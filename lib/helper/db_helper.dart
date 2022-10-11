import 'package:album_app/models/album.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper? _dbHelper;
  static late Database _database;
  static const String _tableName = 'album';

  DBHelper._internal() {
    _dbHelper = this;
  }

  factory DBHelper() => _dbHelper ?? DBHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, 'album_db2.db');

    var db = openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, grup_name TEXT, album_name TEXT, price INTEGER, image_path TEXT)');
      },
      version: 2,
    );

    return db;
  }

  Future<List<Album>> getAlbums() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((album) => Album.fromMap(album)).toList();
  }

  Future<String> insertAlbum(Album album) async {
    final Database db = await database;

    await db.insert(_tableName, album.toMap());
    return 'Berhasil Menambahkan Album';
  }

  Future<String> updateAlbum(Album album) async {
    final Database db = await database;
    await db.update(_tableName, album.toMap(),
        where: 'id = ?', whereArgs: [album.id]);
    return 'Berhasil Mengubah Album';
  }

  Future<String> deleteAlbum(int albumId) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [albumId]);
    return 'Berhasil Menghapus Album';
  }
}
