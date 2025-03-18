import 'dart:io';

import 'package:evently/src/partners/models/evently_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  late Database database;
  static DbHelper dbHelper = DbHelper();
  //Define constants for the table names and columns
  final String tableName = 'events';
  final String tableActiveEvents = 'activeEvents';
  final String tableRegistration = 'registration';

  //Define column names for the 'events' table
  final String idColumn = 'docId';
  final String eventNameColumn = 'eventName';
  final String eventDescColumn = 'eventDesc';
  final String locationColumn = 'location';
  final String bannerPhotoColumn = 'bannerPhoto';
  final String hostNameColumn = 'hostName';
  final String eventDateColumn = 'eventDate';

  //Define column names for the 'activeEvents' table
  final String eventDocIdColumn = 'eventDocID'; // Foreign key to events table

  //Define column names for the 'registration table
  final String registrationEventDocIdColumn =
      'eventDocId'; // Foreign key to activeEvents table
  final String userNameColumn = 'userName';
  final String emailColumn = 'email';

  //initializing database
  initDatabase() async {
    database = await connectToDatabase();
  }

  //connecting to database
  Future<Database> connectToDatabase() async {
    // Get a location using getDatabasesPath
    Directory directory = await getApplicationDocumentsDirectory();

    // to speific name of database
    String path = '$directory/evently.db';

    // to create database and Tables
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute(
          //   'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT,$eventNameColumn TEXT, $descColumn TEXT, $locationColumn TEXT, $bannerPhotoColumn TEXT, $hostNameColumn TEXT, $eventDateColumn INTEGER  )'
          // );
          ''' 
        CREATE TABLE $tableName(
        $idColumn TEXT PRIMARY KEY,
        $eventNameColumn TEXT,
        $eventDescColumn TEXT,
        $locationColumn TEXT,
        $bannerPhotoColumn TEXT,
        $eventDateColumn TEXT,
        $eventDocIdColumn TEXT
        )
  ''',
        );

        // crate the registration table
        db.execute('''
  CREATE TABLE $tableRegistration (
  $registrationEventDocIdColumn TEXT, 
  $userNameColumn TEXT,
  $emailColumn TEXT,
  FOREIGN KEY ($registrationEventDocIdColumn) REFERENCES $tableActiveEvents($idColumn)
  )
''');
      },
      // onUpgrade: (db, oldVersion, newVersion) {
      //   db.execute(
      //     'CREATE TABLE $tableName ($idColumn INTEGER PRIMARY KEY AUTOINCREMENT,$eventNameColumn TEXT, $eventDescColumn TEXT, $locationColumn TEXT, $bannerPhotoColumn TEXT, $hostNameColumn TEXT, $eventDateColumn INTEGER  )',
      //   );
      //   db.execute('''
      //   CREATE TABLE $tableRegistration (
      //   $registrationEventDocIdColumn TEXT, 
      //   $userNameColumn TEXT,
      //   $emailColumn TEXT,
      //   FOREIGN KEY ($registrationEventDocIdColumn) REFERENCES $tableActiveEvents($idColumn)
      //   )''');
      // },
      // onDowngrade: (db, oldVersion, newVersion) {
      //   db.delete(tableName);
      // },
    );
  }

  //Insert EventModel into the database
  Future<void> insertEventModel(EventModel eventModel)async{
    //Insert into events table
    await database.insert(tableName, eventModel.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);

    //Insert each active event
    if(eventModel.activeEvents != null){
      for (var activeEvents in eventModel.activeEvents!){
        await database.insert(tableActiveEvents, activeEvents.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }

    //Insert each registration
    if(eventModel.registration != null){
      for (var registration in eventModel.registration!){
        await database.insert(tableRegistration, registration.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
      }
    }
  }
  // //To Read datas
  // Future<List<EventModel>> getAllEvents() async {
  //   List<Map<String, dynamic>> tasks = await database.query(tableName);
  //   return tasks.map((e) => EventModel.fromMap(e)).toList();
  // }
}
