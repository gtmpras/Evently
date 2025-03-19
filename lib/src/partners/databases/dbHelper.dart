import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:evently/src/partners/models/evently_model.dart';

class DbHelper {
  late Database database;

  static DbHelper dbHelper = DbHelper();

  // Define constants for the table names and columns
  final String tableName = 'events';
  final String tableActiveEvents = 'activeEvents';
  final String tableRegistration = 'registration';

  // Define column names for the 'events' table
  final String idColumn = 'docId';
  final String eventNameColumn = 'eventName';
  final String eventDescColumn = 'eventDesc';
  final String locationColumn = 'location';
  final String bannerPhotoColumn = 'bannerPhoto';
  final String hostNameColumn = 'hostName';
  final String eventDateColumn = 'eventDate';

  // Define column names for the 'activeEvents' table
  final String eventDocIdColumn = 'eventDocID'; // Foreign key to events table

  // Define column names for the 'registration' table
  final String registrationEventDocIdColumn = 'eventDocId'; // Foreign key to activeEvents table
  final String userNameColumn = 'userName';
  final String emailColumn = 'email';

  // Initialize the database
  Future<void> initDatabase() async {
    database = await connectToDatabase();
  }

  // Connect to the database
  Future<Database> connectToDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/evently.db';

    // Create or open the database and define tables
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {

        //Tables for required tables in project.
        db.execute('''
          CREATE TABLE $tableName (
            $idColumn TEXT PRIMARY KEY,
            $eventNameColumn TEXT,
            $eventDescColumn TEXT,
            $locationColumn TEXT,
            $bannerPhotoColumn TEXT,
            $eventDateColumn TEXT
          )
        ''');

      //Tables for all the events in project.
        db.execute('''
          CREATE TABLE $tableActiveEvents (
            $eventDocIdColumn TEXT PRIMARY KEY,
            $idColumn TEXT,
            FOREIGN KEY ($idColumn) REFERENCES $tableName($idColumn)
          )
        ''');

      //Tables to store registration details.
        db.execute('''
          CREATE TABLE $tableRegistration (
            $registrationEventDocIdColumn TEXT,
            $userNameColumn TEXT,
            $emailColumn TEXT,
            FOREIGN KEY ($registrationEventDocIdColumn) REFERENCES $tableActiveEvents($eventDocIdColumn)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // Handle database upgrade if necessary
      },
    );
  }

  // Insert EventModel into the database
  Future<void> insertEventModel(EventModel eventModel) async {
    // Insert into events table
    await database.insert(tableName, eventModel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

    // Insert each active event
    if (eventModel.activeEvents != null) {
      for (var activeEvent in eventModel.activeEvents!) {
        await database.insert(tableActiveEvents, activeEvent.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    // Insert each registration
    if (eventModel.registration != null) {
      for (var registration in eventModel.registration!) {
        await database.insert(tableRegistration, registration.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }

  // Get all events from the events table
  Future<List<EventModel>> getAllEvents() async {
    List<Map<String, dynamic>> eventMaps = await database.query(tableName);
    return eventMaps.map((e) => EventModel.fromMap(e)).toList();
  }

  // Get active events by eventDocId
  Future<List<Map<String, dynamic>>> getActiveEventsByEventId(String eventDocId) async {
    return await database.query(
      tableActiveEvents,
      where: '$eventDocIdColumn = ?',
      whereArgs: [eventDocId],
    );
  }

  // Get registrations for a specific active event
  Future<List<Map<String, dynamic>>> getRegistrationsByEventDocId(String eventDocId) async {
    return await database.query(
      tableRegistration,
      where: '$registrationEventDocIdColumn = ?',
      whereArgs: [eventDocId],
    );
  }

  // Update event details
  Future<void> updateEvent(String docId, EventModel eventModel) async {
    await database.update(
      tableName,
      eventModel.toJson(),
      where: '$idColumn = ?',
      whereArgs: [docId],
    );
  }

  // Delete a specific event
  Future<void> deleteEvent(String docId) async {
    await database.delete(
      tableName,
      where: '$idColumn = ?',
      whereArgs: [docId],
    );
  }

  // Delete a specific active event
  Future<void> deleteActiveEvent(String eventDocId) async {
    await database.delete(
      tableActiveEvents,
      where: '$eventDocIdColumn = ?',
      whereArgs: [eventDocId],
    );
  }

  // Delete a registration
  Future<void> deleteRegistration(String eventDocId) async {
    await database.delete(
      tableRegistration,
      where: '$registrationEventDocIdColumn = ?',
      whereArgs: [eventDocId],
    );
  }
}