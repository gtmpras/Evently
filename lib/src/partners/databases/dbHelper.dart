
import 'package:evently/src/presentations/create_events/create_event_model.dart';
import 'package:evently/src/presentations/widgets/create_event_form.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class EventDatabase{
  static final EventDatabase instance = EventDatabase._init();

  static Database? _database;

  EventDatabase._init();

  Future<Database> get database async{
    if(_database != null) return _database!;

    _database = await _initDB('events.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath)async{
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version:1, onCreate: _createDB);
}
Future _createDB(Database db, int version) async{
  final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  final textType = 'TEXT NOT NULL';
  final integerType = 'INTEGER NOT NULL';

  await db.execute('''
CREATE TABLE $tableEvents(
${EventFields.id} $idType,
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

Future<Event> create(Event event) async{
  final db = await instance.database;

  final id = await db.insert(tableEvents, event.toJson());
  return event.copy(id: id);
}

  
  
}