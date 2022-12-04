import 'package:cinema/models/booked_ticket_model.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabase {
  static Database? database;

  void createDatabase() async {
    database = await openDatabase(
        'Tickets.db',
        version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE Tickets (ID INTEGER PRIMARY KEY AUTOINCREMENT, Movie TEXT,UserName TEXT, Count INTEGER)'
          ).then((value) {
            print('table created');
          }).catchError((error) {
            print('error while creating database, ${error.toString()}');
          });
        },
        onOpen: (database) {
          print('database opened');
        }
    );
  }

  Future<void> insertToDatabase(String Movie, int Count, String UserName) async {
    database!.transaction((txn) async {
      txn.rawInsert(
        'INSERT INTO Tickets (Movie,UserName,Count) VALUES ( ?,?,? )', [Movie, UserName, Count],).then((value) {
        print('$value inserted successfully');
        getDataFromDatabase(UserName);
      }).catchError((error) {
        print('error while inserting into database, ${error.toString()}');
      });
    });
  }

  Future<List<BookedTicket>> getDataFromDatabase(String userName) async {
    print("Hna");
    final List<Map<String,dynamic>>maps=await database!.rawQuery('SELECT * FROM Tickets WHERE UserName=?', [userName]);
    return List.generate(maps.length, (index) =>
        BookedTicket(username: maps[index]["UserName"], movie: maps[index]["Movie"], ticketsCount: maps[index]["Count"]),
    );
  }

  LocalDatabase() {
    createDatabase();
  }
}
