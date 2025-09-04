
import 'dart:convert';

import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class EventDatabase {
  //singletone instance i.e This line ensures that only one instance of the database is used throughout the app.
  //It avoids opening the same database multiple times.
  static final EventDatabase instance = EventDatabase._init();

  static Database? _database;

  EventDatabase._init();

  //open/create Database
  // this checks if the database is already open?
  //If not, it calls _initDB("events.db") to create it.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('events.db');
    return _database!;
  }

  //it gets the default path on the device to store databases.
  //Then it creates a file named events.db and sets up the structure using the 
  // _createDB function.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

// This method is called only once when the databse is first created. 
// It defines the structure of your event table with the columns
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableEvents(
  ${EventFields.id} $idType,
  ${EventFields.uid} $textType,
  ${EventFields.eventTitle} $textType,
  ${EventFields.targetAudience} $textType,
  ${EventFields.description} $textType,
  ${EventFields.hostName} $textType,
  ${EventFields.eventDate} $textType,
  ${EventFields.eventTime} $textType,
  ${EventFields.location} $textType,
  ${EventFields.bannerImg} $textType
)
''');
  }

  // Create Event and returns the same event, but now with an id added by the database
  Future<Event> create(Event event) async {
    final db = await instance.database;

    final id = await db.insert(tableEvents, event.toJson());
    return event.copy(id: id);
  }

  // Read single event by ID, and if not found then return null
  Future<Event?> readEvent(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableEvents,
      columns: EventFields.values,
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );
    return maps.isNotEmpty ? Event.fromJson(maps.first) : null;
  }

  // Read all events, and if not found then return null
  Future<List<Event>> readUserEvents(String uid) async {
    final db = await instance.database;
    final result = await db.query(
      tableEvents,
      where: '${EventFields.uid} = ?',
      whereArgs: [uid],
      orderBy: '${EventFields.eventDate} ASC');

    return result.map((json) => Event.fromJson(json)).toList();
  }

  //Read Other users events.
  Future<List<Event>> readOtherUsersEvents(String currentUid) async {
  final db = await instance.database;
  final result = await db.query(
    'events',
    where: 'uid != ?',
    whereArgs: [currentUid],
  );
  return result.map((json) => Event.fromJson(json)).toList();
}

  // Update an exisiting event and matches the event by it's ID and replaces the old datas
  Future<int> update(Event event) async {
    final db = await instance.database;

    return db.update(
      tableEvents,
      event.toJson(),
      where: '${EventFields.id} = ?',
      whereArgs: [event.id],
    );
  }

  // Delete event with the specified ID from the database
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEvents,
      where: '${EventFields.id} = ?',
      whereArgs: [id],
    );
  }

  //Closes the database when you don't need it anymore(when app is closed)

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
